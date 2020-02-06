package valueme

import de.flapdoodle.embed.mongo.config.IMongodConfig;
import de.flapdoodle.embed.mongo.config.MongodConfigBuilder;
import de.flapdoodle.embed.mongo.config.Net;
import de.flapdoodle.embed.mongo.config.RuntimeConfigBuilder;
import de.flapdoodle.embed.mongo.distribution.Version;
import de.flapdoodle.embed.process.config.IRuntimeConfig;
import de.flapdoodle.embed.process.runtime.Network;
import de.flapdoodle.embed.mongo.MongodProcess;
import de.flapdoodle.embed.mongo.MongodExecutable;
import de.flapdoodle.embed.mongo.MongodStarter;

class MongoEmbedded { 

    public void myMongoEmbedded(){
    println 'Init Mongo Embedded database'
	MongodStarter starter = MongodStarter.getDefaultInstance();
	String bindIp = "127.0.0.1";
	int port = 27018;
	IMongodConfig mongodConfig = new MongodConfigBuilder()
		.version(Version.Main.PRODUCTION)
		.net(new Net(bindIp, port, Network.localhostIsIPv6()))
		.build();
	MongodExecutable mongodExecutable = null;
    mongodExecutable = starter.prepare(mongodConfig);
    MongodProcess mongod = mongodExecutable.start();
    println 'Mongo Embedded database Started'
    }
}