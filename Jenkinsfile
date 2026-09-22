  pipeline {
    agent { label 'built-in' }
	
    stages {
        stage('Checkout') {
            steps {
                git changelog: false, poll: false, url: 'https://github.com/tanveerkkhan/hellojava-kluster.git', branch: 'main'
            }
        }
		
        // stage('Docker Build & Push') {
        //     steps {
        //         dir('8-Project-1-Python-Flask-App') {
        //             withCredentials([usernamePassword(credentialsId: 'khatanve', passwordVariable: 'dockerpass', usernameVariable: 'dockerusername')]) {
        //                 sh '''
        //                     echo $dockerpass | docker login -u $dockerusername --password-stdin
        //                     docker build . -t khatanve/hellotanveer:${BUILD_NUMBER}
        //                     docker push khatanve/hellotanveer:${BUILD_NUMBER}
        //                 '''
        //             }
        //         }
        //     }
        // }
			// 	kubectl apply -f deploy.yaml

        stage('Deploy to K8s') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh """
                    helm upgrade --install demo-app ./hellojava-kluster
					"""
                     }
    }
}
}
}
