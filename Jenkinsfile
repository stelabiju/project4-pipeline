pipeline {
    agent any

    environment {
        IMAGE_NAME = 'stelabiju/project4-devsecops'
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate Project Files') {
            steps {
                sh '''
                    set -eu
                    test -f requirements.txt
                    test -f Dockerfile
                    test -f manage.py
                    echo "Required project files found."
                '''
            }
        }

        stage('SAST - Semgrep') {
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
            steps {
                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/src" \
                      trufflesecurity/trufflehog:latest \
                      filesystem /src --no-update --fail
                '''
            }
        }

        stage('Dependency and Configuration Scan - Trivy') {
            steps {
                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/src" \
                      aquasec/trivy:latest \
                      fs --scanners vuln,misconfig,secret \
                      --severity HIGH,CRITICAL \
                      --exit-code 1 \
                      /src
                '''
            }
        }

        stage('Django System Check') {
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
            steps {
                sh '''
                    docker build \
                      -t ${IMAGE_NAME}:${IMAGE_TAG} \
                      -t ${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Docker Image Vulnerability Scan') {
            steps {
                sh '''
                    docker run --rm \
                      -v /var/run/docker.sock:/var/run/docker.sock \
                      aquasec/trivy:latest \
                      image --severity HIGH,CRITICAL \
                      --exit-code 1 \
                      ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Push Image to Docker Hub') {
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
    }

    post {
        success {
            echo 'Security checks and image publishing completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Review the stage logs and fix the reported issue.'
        }
        always {
            echo "Build result: ${currentBuild.currentResult}"
        }
    }
}