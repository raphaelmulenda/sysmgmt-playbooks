pipeline {
    agent any
    environment {
        HARBOR_URL = "192.168.1.27:8080" // This is your local Harbor IP
        HARBOR_PROJECT = "cicd-infra" // Replace with your project name in Harbor
        IMAGE_NAME = "cicd-test-app" // Replace with your desired image name
        APP_NAME = "cicd-test-app" // Replace with your app name
        IMAGE_TAG = "${env.BUILD_NUMBER}" // Uses Jenkins build number for versioning
    }
    stages {
        stage('Checkout') {
            steps {
                // This step checks out your code from GitHub
                git credentialsId: 'github-org-credentials', url: 'https://github.com/Opsmiths-Technologies/cicd-infra.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                // Builds the Docker image with the specified tag
                sh "docker build -t $HARBOR_URL/$HARBOR_PROJECT/$IMAGE_NAME:$IMAGE_TAG ."
            }
        }
        stage('Login to Harbor') {
            steps {
                // Logs into Harbor using the credentials you've set up
                withCredentials([usernamePassword(credentialsId: 'harbor-credentials', usernameVariable: 'HARBOR_USER', passwordVariable: 'HARBOR_PASS')]) {
                    sh """
                    echo '$HARBOR_PASS' | docker login -u $HARBOR_USER --password-stdin $HARBOR_URL
                    """
                }
            }
        }
        stage('Push to Harbor') {
            steps {
                // Pushes the Docker image to Harbor
                sh "docker push $HARBOR_URL/$HARBOR_PROJECT/$IMAGE_NAME:$IMAGE_TAG"
            }
        }
        stage('Trigger Ansible Deployment') {
            steps {
                // Run Ansible playbook locally since they are on the same server
                withCredentials([usernamePassword(credentialsId: 'harbor-credentials', usernameVariable: 'HARBOR_USER', passwordVariable: 'HARBOR_PASS')]) {
                    sh """
                    ansible-playbook -i /etc/ansible/inventory.ini /etc/ansible/deploy.yml \
                    --extra-vars "image=$HARBOR_URL/$HARBOR_PROJECT/$IMAGE_NAME:$IMAGE_TAG app_name=$APP_NAME"
                    """
                }
            }
        }
    }
}