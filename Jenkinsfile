pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            metadata:
              labels:
                app: jenkins-agent
            spec:
            //   imagePullSecrets:
            //   - name: gcr-json-key  // Use the secret for pulling images from Artifact Registry
            //  containers:
              - name: terraform
                image: hashicorp/terraform
                command: [ "cat" ]
                tty: true
            """
        }
    }

    environment {
        GOOGLE_CREDENTIALS = credentials('allow-gcp-resource-create-and-manage')  // This assumes you have the credentials stored securely in Jenkins
        GOOGLE_PROJECT_ID = 'dev-demo-proj-1-id'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Karthickramasamy007/gcp-infra-via-terraform', branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'allow-gcp-resource-create-and-manage', variable: 'GOOGLE_CREDENTIALS')]) {
                        sh """
                            export GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_CREDENTIALS}
                            terraform init -backend-config="project=${GOOGLE_PROJECT_ID}"
                        """
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'allow-gcp-resource-create-and-manage', variable: 'GOOGLE_CREDENTIALS')]) {
                        sh """
                            export GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_CREDENTIALS}
                            terraform plan -out=tfplan
                        """
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'allow-gcp-resource-create-and-manage', variable: 'GOOGLE_CREDENTIALS')]) {
                        input message: 'Approve Terraform Apply?', ok: 'Apply'
                        sh """
                            export GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_CREDENTIALS}
                            terraform apply tfplan
                        """
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    sh 'terraform workspace select default || terraform workspace new default'
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment successful!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
        always {
            echo 'Cleaning up...'
        }
    }
}
