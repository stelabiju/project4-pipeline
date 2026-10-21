pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'stelabiju/project4-devsecops'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'Github_jenkins',
                    url: 'https://github.com/stelabiju/project4-pipeline.git'
            }
        }

        stage('SAST - Semgrep') {
            steps {
                sh '''
                    docker run --rm \
                    -v "$WORKSPACE:/src" \
                    -w /src semgrep/semgrep \
                    semgrep scan --config auto .
                '''
            }
        }

        stage('Secret Scan - TruffleHog') {
            steps {
                sh '''
                    docker run --rm \
                    -v "$WORKSPACE:/src" \
                    trufflesecurity/trufflehog:latest \
                    filesystem /src --no-update \
                    --only-verified --fail
                '''
            }
        }

        stage('Dependency Scan - Trivy') {
            steps {
                sh '''
                    docker run --rm \
                    -v "$WORKSPACE:/src" \
                    aquasec/trivy:latest fs \
                    --scanners vuln,misconfig \
                    --severity HIGH,CRITICAL \
                    --ignore-unfixed \
                    --exit-code 0 /src
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-cred',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_TOKEN'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_TOKEN" | docker login \
                        -u "$DOCKER_USER" --password-stdin

                        docker push $DOCKER_IMAGE:$BUILD_NUMBER
                        docker logout
                    '''
                }
            }
        }

        stage('Update Kubernetes Manifest') {
            steps {
                sh '''
                    sed -i "s|image: stelabiju/project4-devsecops:.*|image: $DOCKER_IMAGE:$BUILD_NUMBER|" k8s/deployment.yaml
                '''
            }
        }

        stage('Commit and Push Changes') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'Github_jenkins',
                        usernameVariable: 'GIT_USER',
                        passwordVariable: 'GIT_TOKEN'
                    )
                ]) {
                    sh '''
                        git config user.name "Jenkins"
                        git config user.email "jenkins@localhost"

                        git add k8s/deployment.yaml
                        git commit -m "Update Project4 image to $BUILD_NUMBER"
                        git push https://$GIT_USER:$GIT_TOKEN@github.com/stelabiju/project4-pipeline.git HEAD:main
                    '''
                }
            }
        }
    }
}
