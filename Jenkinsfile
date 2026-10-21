pipeline {

    agent any

    environment {
        IMAGE_NAME = 'stelabiju/project4-devsecops'
        IMAGE_TAG  = "${BUILD_NUMBER}"
        REPO_URL   = 'github.com/stelabiju/project4-pipeline.git'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                script {
                    // Stop the build loop caused by the GitOps manifest commit
                    def msg = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                    if (msg.contains('[skip ci]')) {
                        env.SKIP_BUILD = 'true'
                        currentBuild.result = 'NOT_BUILT'
                        echo 'Manifest-only commit detected. Skipping pipeline.'
                    } else {
                        env.SKIP_BUILD = 'false'
                    }
                }
            }
        }

        stage('Validate Project Files') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    set -eu
                    test -f requirements.txt
                    test -f Dockerfile
                    test -f manage.py
                    test -f k8s/deployment.yaml
                    echo "Required project files found."
                '''
            }
        }

        stage('SAST - Semgrep') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/src" \
                      semgrep/semgrep \
                      semgrep scan --config auto /src
                '''
            }
        }

        stage('Secret Scan - TruffleHog') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/src" \
                      trufflesecurity/trufflehog:latest \
                      filesystem /src --no-update --only-verified --fail
                '''
            }
        }

        stage('Dependency and Configuration Scan - Trivy') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/src" \
                      aquasec/trivy:latest \
                      fs --scanners vuln,misconfig,secret \
                      --severity HIGH,CRITICAL \
                      --ignore-unfixed \
                      --exit-code 0 \
                      /src
                '''
            }
        }

        stage('Django System Check') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    docker build -t project4-ci-check:${BUILD_NUMBER} .
                    docker run --rm \
                      --entrypoint python \
                      project4-ci-check:${BUILD_NUMBER} \
                      manage.py check
                '''
            }
        }

        stage('Build Docker Image') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    docker build \
                      -t ${IMAGE_NAME}:${IMAGE_TAG} \
                      -t ${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('DAST - OWASP ZAP') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                sh '''
                    chmod -R a+w "$WORKSPACE"
                    docker network create zapnet-${BUILD_NUMBER}
                    docker run -d --name app-${BUILD_NUMBER} \
                      --network zapnet-${BUILD_NUMBER} \
                      ${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 20
                    docker run --rm --network zapnet-${BUILD_NUMBER} \
                      -v "$WORKSPACE:/zap/wrk:rw" \
                      ghcr.io/zaproxy/zaproxy:stable \
                      zap-baseline.py -t http://app-${BUILD_NUMBER}:8000 \
                      -r zap-report.html -I
                '''
            }
            post {
                always {
                    sh '''
                        docker rm -f app-${BUILD_NUMBER} || true
                        docker network rm zapnet-${BUILD_NUMBER} || true
                    '''
                    archiveArtifacts artifacts: 'zap-report.html', allowEmptyArchive: true
                }
            }
        }

        stage('Push Image to Docker Hub') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-cred',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        set +x
                        echo "$DOCKER_PASS" | docker login \
                          --username "$DOCKER_USER" \
                          --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${IMAGE_NAME}:latest
                        docker logout
                    '''
                }
            }
        }

        stage('Update GitOps Manifest') {
            when { expression { env.SKIP_BUILD == 'false' } }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'github-cred',
                        usernameVariable: 'GIT_USER',
                        passwordVariable: 'GIT_TOKEN'
                    )
                ]) {
                    sh '''
                        set +x
                        sed -i "s|image: .*|image: ${IMAGE_NAME}:${IMAGE_TAG}|" k8s/deployment.yaml
                        git config user.email "jenkins@local"
                        git config user.name "jenkins"
                        git add k8s/deployment.yaml
                        git commit -m "Update image to ${IMAGE_TAG} [skip ci]" || exit 0
                        git push https://${GIT_USER}:${GIT_TOKEN}@${REPO_URL} HEAD:main
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Security checks, image publishing and GitOps update completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Review the stage logs and fix the reported issue.'
        }
        always {
            echo "Build result: ${currentBuild.currentResult}"
        }
    }
}
