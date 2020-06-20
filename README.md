Valueme Application
=======

Valueme es una plataforma open source diseñada para gestionar el proceso de Autoevaluación del MECI *Modelo Estandar De Control Interno* en las entidades publicas del gobierno.

![Principal](http://i.imgur.com/fWPhckp.png)

Valumeme is a open source platform that covers the bussiness operations related wth Performance Evaluation Self-Assessment in public Agencies. 

![Results](http://i.imgur.com/Lr20efS.png)

Uses the following technologies

* Grails Version: 3.2.0
* Groovy Version: 2.4.6
* JVM Version: 1.8.0_91

## Notes
For testing purposes, this apps launch an **embedded database SQL H2** and loads test data with default usernames and passwords:

- **Admin Username:** admin@valueme.com
- **Admin Password:** 1
- **User Username:** user@valueme.com
- **User password:** 1

## Demo App
The demo App is deployed on *Heroku* and can be found in this link https://ancient-lowlands-82325.herokuapp.com/ could take a couple of minutes if the Application is not Started yet.

## Documentation

The documentation for this application can be found on files `Manual usuario.docx`, `Estructura del codigo fuente.docx` and  `Aplicativo encuesta de sostenibilidad control interno.pdf` in this repository.

## How to run

The project is built using gradle. Use this command to compile and run the application.

`./gradlew stage`
`java -Dserver.port=$PORT $JAVA_OPTS -Dgrails.env=prod -jar build/libs/valueme-1.0.jar`

There is also a `Dockerfile` for make deployments using docker containers, for example to build and run this app with podman:

`sudo podman build --tag valueme-app:latest -f ./Dockerfile`
`sudo podman run -p 8080:8080 valueme-app:latest`

The enviroment variables `$PORT` and `JAVA_OPTS` can be used to change the application port and java parameters.

## RoadMap to future releases

- Upgrade to Grails latest release
- Upgrade Spring security to the latest version.
- Upgrade semantic ui to latest release
- Create Frontend with JS Framework (Angular, React)
- Change architecture to microservices backend
