pipeline {
    agent any
    environment {
        AWS_REGION      = "eu-central-1"
        ECR_REPOSITORY  = "cicd-infra"
        APP_NAME        = "cicd-test-app"
        IMAGE_NAME      = "cicd-test-app"
        IMAGE_TAG       = "${env.BUILD_NUMBER}"
        AWS_ACCOUNT_ID  = "225320283044"
        ECR_URL         = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-org-credentials', url: 'https://github.com/Opsmiths-Technologies/cicd-infra.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t $ECR_URL/$ECR_REPOSITORY:$IMAGE_TAG ."
            }
        }
        stage('Login to ECR') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                    aws configure set region $AWS_REGION
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URL
                    """
                }
            }
        }
        stage('Push to ECR') {
            steps {
                sh "docker push $ECR_URL/$ECR_REPOSITORY:$IMAGE_TAG"
            }
        }
        stage('Trigger Ansible Deployment') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    // Passing the dynamic image name as an extra variable to the playbook.
                    sh """
                    ansible-playbook -i /etc/ansible/inventory.ini /etc/ansible/deploy.yml \
                    --extra-vars "image=$ECR_URL/$ECR_REPOSITORY:$IMAGE_TAG app_name=$APP_NAME aws_access_key=$AWS_ACCESS_KEY_ID aws_secret_key=$AWS_SECRET_ACCESS_KEY aws_region=$AWS_REGION"
                    """
                }
            }
        }
    }
}
