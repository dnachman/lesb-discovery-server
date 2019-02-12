def POM_VERSION = 'UNKNOWN'
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
				script {
					POM_VERSION = readMavenPom().getVersion()
				}
			}
   	}
		stage('Package/Push image') {
			parallel {
				stage ('amd64') {
					steps {
						script {
								// build docker image
							def dockerImage = docker.build(repository + ":${POM_VERSION}"
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
							def dockerImageRpi = docker.build(repository + ":rpi-${POM_VERSION}", '-f Dockerfile.rpi .')
							docker.withRegistry('', registryCredential) {
								dockerImageRpi.tag('rpi')
								dockerImageRpi.push()
							}
			    	}
					}
				}
			}
			
		}
		stage('Remove Unused docker image') {
            steps{
                sh "docker rmi $repository:${POM_VERSION}"
                sh "docker rmi $repository:rpi-${POM_VERSION}"
            }
        }
		stage('Results') {
			steps {
				junit '**/target/surefire-reports/TEST-*.xml'
			}
		}
	}
}