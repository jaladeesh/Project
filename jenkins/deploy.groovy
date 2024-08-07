pipeline {
    agent any

    environment {
        kubeconfig = "/home/ubuntu"
    }

    stages {
        stage('Code Checkout') {
            steps {
                git credentialsId: 'git-token', url: 'https://github.com/jaladeesh/Task7.git'
            }
        }
        
        stage('Setup Kubeconfig') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig-file', variable: 'kubeconfig')]) {
                        sh 'cp $kubeconfig-file $kubeconfig'
                    }
                }
            }
        }
        
        stage('Deploy Prometheus Helm Chart') {
            steps {
                script {
                    sh 'helm upgrade --install prometheus-chart ./prometheus-chart'
                }
            }
        }

        stage('Deploy Grafana Helm Chart') {
            steps {
                script {
                    sh 'helm upgrade --install grafana-chart ./grafana-chart'
                }
            }
        }

        stage('Deploy webapplication Helm Chart') {
            steps {
                script {
                    sh 'helm upgrade --install web-application-chart ./web-application-chart'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
