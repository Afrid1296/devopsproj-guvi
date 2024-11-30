pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "afrid1296/devops-guvi:dev"
        DOCKER_PROD_REPO = "afrid1296/devops-guvi:prod"
        DOCKER_CREDENTIALS_ID = "docker-hub"  // Add Docker credentials ID here
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'
                    docker.build(env.DOCKER_DEV_REPO)
                }
            }
        }

        stage('Push to Dev Repo') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    withDockerRegistry(credentialsId: env.DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${env.DOCKER_DEV_REPO}"
                    }
                }
            }
        }

        stage('Push to Prod Repo') {
            when {
                allOf {
                    branch 'master'
                    changeRequest() // This ensures the step runs only when it's a pull request or merge
                }
            }
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'
                    docker.build(env.DOCKER_PROD_REPO)
                    withDockerRegistry(credentialsId: env.DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${env.DOCKER_PROD_REPO}"
                    }
                }
            }
        }

        // Deployment stage to deploy the image to your production environment
        stage('Deploy to Production') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Assuming deploy.sh deploys the Docker image to your prod environment
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'  // Deploy the image to production
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
