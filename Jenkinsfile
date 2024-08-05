pipeline {
    agent any

    environment {
        // Define any necessary environment variables here
        TF_VERSION = '1.1.7'
        ANSIBLE_VERSION = '2.12.2'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub
                git branch: 'main', url: 'https://github.com/your-repo/your-repo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Run Terraform init
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Run Terraform plan
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply Terraform changes
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Ansible Playbook') {
            steps {
                script {
                    // Run Ansible playbook
                    sh 'ansible-playbook -i inventory/hosts playbooks/site.yml'
                }
            }
        }

        stage('Test') {
            steps {
                // Add any tests or validations here
                echo 'Running tests...'
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
