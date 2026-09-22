  pipeline {
    agent { label 'agent-1' }
	
    stages {
        stage('Checkout') {
            steps {
                git changelog: false, poll: false, url: 'https://github.com/tanveerkkhan/hellojava-kluster.git', branch: 'main'
            }
        }
		
        stage('Docker Build & Push') {
            steps {
                dir('app') {
                    withCredentials([usernamePassword(credentialsId: 'khatanve', passwordVariable: 'dockerpass', usernameVariable: 'dockerusername')]) {
                        sh '''
                            echo $dockerpass | docker login -u $dockerusername --password-stdin
                            docker build . -t khatanve/webapp-demo:${BUILD_NUMBER}
                            docker push khatanve/webapp-demo:${BUILD_NUMBER}
                        '''
                    }
                }
            }
        }

        stage('Deploy using Manifestfile') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh """
                    kubectl apply -f deploy.yaml
                    kubectl apply -f ingress.yaml
					"""
                     }
    }
}

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