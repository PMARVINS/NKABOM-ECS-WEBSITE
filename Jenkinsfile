pipeline {
    agent any
    
    stages {
        stage('Git checkout') {
           steps{
                git branch: 'main', credentialsId: 'Github', url:'https://github.com/PMARVINS/NKABOM-ECS-WEBSITE.git'
            }
        }
        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }

        stage ("terraform Action") {
              steps {
            echo "Terraform action is --> ${action}"
            sh ('terraform ${action} -var-file=prod.tfvars -auto-approve')
            }
        }
        
    }

}