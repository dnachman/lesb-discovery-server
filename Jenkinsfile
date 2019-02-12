pipeline {
    environment {
        repository = "logicalenigma/discovery-server"
        registryCredential = 'docker-hub'
    }
	agent any
	stages{
		stage('Preparation') { 
      steps {
				// Get some code from a GitHub repository
				git 'https://github.com/dnachman/lesb-discovery-server.git'
			}
		}
		stage('Build') {
			steps {
				// Run the maven build
      	sh "./mvnw -Dmaven.test.failure.ignore clean package"
			}
   	}
		stage('Package/Push image') {
			steps {
			    script {
			        // build docker image
    				def dockerImage = docker.build(repository + ":build-${env.BUILD_ID}")
    				docker.withRegistry('', registryCredential) {
							dockerImage.tag(latest)
    				  dockerImage.push()
								
    				}
			    }
				
			}
		}
		stage('Remove Unused docker image') {
            steps{
                sh "docker rmi $registry:build-$BUILD_NUMBER"
            }
        }
		stage('Results') {
			steps {
				junit '**/target/surefire-reports/TEST-*.xml'
			}
		}
	}
}