package valueme

import grails.boot.GrailsApp
import grails.boot.config.GrailsAutoConfiguration

class Application extends GrailsAutoConfiguration {
    static void main(String[] args) {
        MongoEmbedded mongo = new MongoEmbedded();
        mongo.myMongoEmbedded()
        GrailsApp.run(Application, args)
    }
}