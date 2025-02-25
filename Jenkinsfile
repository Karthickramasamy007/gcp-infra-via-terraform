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
                image: hashicorp/terraform
                command: [ "sh", "-c", "echo 'Checking Terraform version...' && terraform version && sleep 3600" ]
                tty: true
                env:
                    - name: GOOGLE_CREDENTIALS
                    valueFrom:
                        secretKeyRef:
                        name: allow-gcp-resource-create-and-manage
                        key: credentials.json  # Name of the key in the secret
                    - name: GOOGLE_APPLICATION_CREDENTIALS
                    value: /dev/null  # Silences any prompts asking for the credentials file
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

        stage('Check Terraform Version') {
                steps {
                    container('terraform') {
                    sh 'terraform --version' // Check Python version inside the container
                    sh 'terraform init'
                    sh 'terraform plan' 
                    sh 'terraform apply -auto-approve' 
                    }
            }
        }

        // stage('Terraform Apply') {
        //     steps {
        //         script {
        //             withCredentials([file(credentialsId: 'allow-gcp-resource-create-and-manage', variable: 'GOOGLE_CREDENTIALS')]) {
        //                 input message: 'Approve Terraform Apply?', ok: 'Apply'
        //                 sh """
        //                     export GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_CREDENTIALS}
        //                     terraform apply tfplan
        //                 """
        //             }
        //         }
        //     }
        // }

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
