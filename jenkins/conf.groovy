pipeline {
    agent any

    stages {
      
        stage('Installation of Jenkins') {
            steps {
                ansiblePlaybook credentialsId: 'ansible-key', disableHostKeyChecking: true, installation: 'ansible', 
                inventory: '/etc/ansible/hosts', playbook: '/etc/ansible/jenkins-installation.yaml', vaultTmpPath: '',
                extras: '-e "@/etc/ansible/jenkinsvars.yaml"'
                
            }
        }

        stage('Installation of Nexus') {
            steps {
                ansiblePlaybook credentialsId: 'ansible-key', disableHostKeyChecking: true, installation: 'ansible', 
                inventory: '/etc/ansible/hosts', playbook: '/etc/ansible/nexus-installation.yaml', vaultTmpPath: '',
                extras: '-e "@/etc/ansible/nexusvars.yaml"'
                
            }
        }

        stage('installation of microK8s') {
            steps {
                ansiblePlaybook credentialsId: 'ansible-key', disableHostKeyChecking: true, installation: 'ansible', 
                inventory: '/etc/ansible/hosts', playbook: '/etc/ansible/microk8s-installation.yaml', vaultTmpPath: '', 
                extras: '-e "@/etc/ansible/microk8svars.yaml"'
                
            }
        }
    }
    
}
