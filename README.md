# Dockerfile for MITREid Connect

From https://github.com/mitreid-connect

Version 1.2.1 of MITREid Connect

## Run

Docker Hub image: https://hub.docker.com/r/ghchinoy/mitreid-connect/

	docker pull ghchinoy/mitreid-connect

The default `server-config.xml` for the webserver uses `localhost`. To override this, specify a volume at runtime via `-v`. A sample `server-config.xml` is included in this repository

	docker run -d --name mitreoidc -p 8080:8080 -v `pwd`/server-config.xml:/users/mitreidc/oidc/openid-connect-server-webapp/src/main/webapp/WEB-INF/server-config.xml ghchinoy/mitreid-connect

Without any other changes, the user/password is the same as the default git repo.

## Use

See the [MITREid Connect documentation](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki) for more info. For example, [Endpoints available](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Server-configuration).

## Build

See the `Dockerfile.mitreid-connect` for more info on how the image was constructed.

	docker build --tag ghchinoy/mitreid-connect -f Dockerfile.mitreid-connect .

## Notes

* the image is pretty fat, could use some slimming
* no need for `sudo` `curl`
* might be nice to regen jwks as per [docs](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Key-generation) on start of container
