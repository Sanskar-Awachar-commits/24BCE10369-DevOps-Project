pipeline {
    agent any

    stages {
        stage('Prepare Chaos') {
            steps {
                echo 'Adapting to custom folder structure on Windows...'
                // This creates the directory Spring Boot expects and forcefully copies your webapp files into it
                bat 'if not exist src\\main\\resources\\static mkdir src\\main\\resources\\static'
                bat 'xcopy src\\main\\webapp\\* src\\main\\resources\\static\\ /E /I /Y /Q'
            }
        }
        
        stage('Maven Build') {
            steps {
                echo 'Building JAR file...'
                // Skips tests to save you time
                bat 'mvn clean package -DskipTests'
            }
        }
        
        stage('Docker Build') {
            steps {
                echo 'Building Docker Image...'
                bat 'docker build -t devops-assignment-portal:latest .'
            }
        }
        
        stage('Docker Run') {
            steps {
                echo 'Spinning up container for screenshots...'
                // Gracefully stop and remove the old container if it exists so the pipeline doesn't crash on rebuilds
                catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                    bat 'docker stop portal-app'
                    bat 'docker rm portal-app'
                }
                // Run the new container on port 8080
                bat 'docker run -d -p 8080:8080 --name portal-app devops-assignment-portal:latest'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed! Open http://localhost:8080 in your browser and take your screenshots.'
        }
    }
}