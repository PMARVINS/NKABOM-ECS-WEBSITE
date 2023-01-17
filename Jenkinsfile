

pipeline{
	agent any
	
	stages{
		stage('clonecode'){
			steps{
				git "https://github.com/PMARVINS/NKABOM-ECS-WEBSITE.git"
			}
		}
		stage('createInfra') {
			steps{
				sh "terraform init"
				sh "terraform apply --auto-approve"
			}
		}
	}
}
