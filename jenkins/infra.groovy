pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('terraform')
        AWS_SECRET_ACCESS_KEY = credentials('terraform')
        AWS_REGION = 'ap-southeast-1' 
    }


    stages {
        stage('Git checkout') {
            steps {
                git credentialsId: 'git-token', url: 'https://github.com/jaladeesh/Task7.git'
            }
        }
        
        stage('Initiating terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        
        stage('resource planning') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }
        
        stage('applying resources') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
