node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/dnachman/lesb-discovery-server.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'M3'
   }
   stage('Build') {
      // Run the maven build
      sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
   }
	 stage('Package/Push image') {
		 	// build docker image
			def dockerImage = docker.build("logicalenigma/discovery-server:build-${env.BUILD_ID}")
			dockerImage.push()
	 }
   stage('Results') {
      junit '**/target/surefire-reports/TEST-*.xml'
   }
}