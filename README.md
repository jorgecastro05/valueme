Valueme APP
=======

Valueme es una plataforma open source diseñada para gestionar el proceso de Autoevaluación del MECI, Modelo Estandar De Control Interno.


* Grails Version: 3.2.0
* Groovy Version: 2.4.6
* JVM Version: 1.8.0_91

Notes:
For testing purposes, this apps launch an embedded database mongo,then loads test data with default usernames and passwords:
- Admin Username: admin@valueme.com
- Admin Password: 1
- User Username: user@valueme.com
- User password: 1

To remove the default embeded database, remove the lines from Application class.
MongoEmbedded mongo = new MongoEmbedded();
mongo.myMongoEmbedded()



Paleta de Colores

Rojo
#4c0000
#b20000
#ff0000

Azul
#000033
#0000e5
#1919ff


Amarillo
#b2b200
#e5e500
