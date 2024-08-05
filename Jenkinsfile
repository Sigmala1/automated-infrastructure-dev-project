pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        GITHUB_CREDENTIALS = credentials('github-credentials')
        ANSIBLE_SSH_KEY = credentials('ansible-ssh-key')
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/Sigmala1/automated-infrastructure-dev-project.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                                 string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                                 string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                                 string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Ansible Playbook') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-ssh-key', keyFileVariable: 'ANSIBLE_PRIVATE_KEY')]) {
                    sh 'ansible-playbook -i inventory playbook.yml --private-key $ANSIBLE_PRIVATE_KEY'
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
