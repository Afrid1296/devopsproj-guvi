pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "afrid1296/devops-guvi:dev"
        DOCKER_PROD_REPO = "afrid1296/devops-guvi:prod"
        DOCKER_CREDENTIALS_ID = "docker-hub"
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
                    branch 'main'
                    changeRequest() 
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

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                script {
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
