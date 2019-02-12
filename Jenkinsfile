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
			parallel {
				stage ('amd64') {
					steps {
						script {
								// build docker image
							def dockerImage = docker.build(repository + ":amd64-${env.BUILD_ID}")
							docker.withRegistry('', registryCredential) {
								dockerImage.tag('latest')
								dockerImage.push()
							}
			    	}
					}
				}
				stage ('rpi') {
					steps {
						script {
								// build docker image
							def dockerImage = docker.build(repository + ":rpi-${env.BUILD_ID}", "-f Dockerfile.rpi .")
							docker.withRegistry('', registryCredential) {
								dockerImage.tag('rpi')
								dockerImage.push()
							}
			    	}
					}
				}
			}
			
		}
		stage('Remove Unused docker image') {
            steps{
                sh "docker rmi $repository:amd64-$BUILD_ID"
                sh "docker rmi $repository:rpi-$BUILD_ID"
            }
        }
		stage('Results') {
			steps {
				junit '**/target/surefire-reports/TEST-*.xml'
			}
		}
	}
}