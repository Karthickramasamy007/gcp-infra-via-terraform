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
              containers:
              - name: terraform
                image: europe-west1-docker.pkg.dev/dev-demo-proj-1-id/my-artifact-repo/terraform:1.9.5
                command: [ "cat" ]
                tty: true
            """
        }
    }

    environment {
        // Define GCP credentials (make sure these are stored securely, e.g., in Jenkins credentials store)
        GOOGLE_CREDENTIALS = credentials('allow-gcp-resource-create-and-manage') // The ID of the stored secret in Jenkins
        GOOGLE_PROJECT_ID = 'dev-demo-proj-1-id'
        //GOOGLE_REGION = 'us-central1' // Change to your desired region
        //GOOGLE_ZONE = 'us-central1-a' // Change to your desired zone
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout your Terraform code from the Git repository
                git url: 'https://github.com/Karthickramasamy007/gcp-infra-via-terraform', branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Set up the environment for GCP authentication
                    withCredentials([file(credentialsId: 'allow-gcp-resource-create-and-manage', variable: 'GOOGLE_CREDENTIALS')]) {
                        sh """
                            export GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_CREDENTIALS}
                            terraform init
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
                        // Run terraform apply only when plan is successful
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
                    sh 'terraform destroy -auto-approve'  // Optional, for teardown purposes
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
