pipeline {
    agent any
    
    tools {
        maven "maven3"
    }
    
    stages {
        stage('Code Checkout') {
            steps {
                git branch: 'master', credentialsId: 'git-token', url: 'https://github.com/jaladeesh/my-webapp.git'
            }
        }
        
        stage('Code Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Code Compile') {
            steps {
                withCredentials([string(credentialsId: 'nexus-token', variable: 'nexus-token')]) {
                    sh "mvn compile"
                }
            }
        }
        
        stage('Code Deploy to Nexus') {
            steps {
                configFileProvider([configFile(fileId: '71f3258c-c20a-4465-9597-21de3230ce3f', variable: 'mavensettings')]) {
                    sh "mvn -s $mavensettings clean deploy -DskipTests=true"
                }
            }
        }
        
        stage('Docker Build') {
            steps {
                sh "docker build -t jaladeesh/web-application:v1 -f Dockerfile ."
            }
        }
        
        stage('Docker Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-token') {
                        sh 'docker push jaladeesh/web-application:v1'
                    }
                }
            }
        }
    }
}
