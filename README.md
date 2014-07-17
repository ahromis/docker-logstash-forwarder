## logstash-forwarder via docker

This is a Docker image to send container logs to logstash using logstash-forwarder via a container.

### To build:

`docker build -t logstash-forwarder .`

Then place your `logstash-forwarder.crt` and `logstash-forwarder.json` in the same directory on your host machine, and map that directory to `/etc/logstash-forwarder` in the container.

To create a `logstash-forwarder.crt` use the following command from the logstash-forwarder README:

		$ openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout logstash-forwarder.key -out logstash-forwarder.crt

### To run:

`docker run -d -v /var/lib/docker/aufs/mnt:/containers -v /opt/logstash-forwarder:/etc/logstash-forwarder logstash-forwarder`

#### Here is an example `logstash-forwarer.json`:

		{
		  "network": {
			"servers": [ "server.somewhere.com:5555" ],

			"ssl ca": "/opt/ssl/logstash-forwarder.crt",
			"timeout": 15
		  },

		  "files": [
			{
			  "paths": [ "/containers/*/data/app/log/*.log" ],
			  "fields": { "type": "rails", "tags": "tag-something" }
			}
		  ]
		}

