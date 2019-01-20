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
	 stage('Package image') {
		 	sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore install dockerfile:build"
	 }
	 stage('Push image') {
		 	sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore dockerfile:push"
	 }
   stage('Results') {
      junit '**/target/surefire-reports/TEST-*.xml'
   }
}