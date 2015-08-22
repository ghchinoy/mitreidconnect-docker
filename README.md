# Dockerfile for MITREid Connect

From https://github.com/mitreid-connect

Version 1.2.1 of MITREid Connect

## Run

Docker Hub image: https://hub.docker.com/r/ghchinoy/mitreid-connect/

	docker pull ghchinoy/mitreid-connect

The default `server-config.xml` for the webserver uses `localhost` as the "issuer" base host. This will need to be overridden, otherwise the server will reference itself at `localhost` and not the expected Docker IP. To override this, specify a volume at runtime via the `-v` flag on `docker run`. A sample `server-config.xml` is included in this repository.

Example, run image with name `mitreoidc`, exposing port 8080 (as 8080), and mapping the `server-config.xml` to the one in the current directory:

	docker run -d --name mitreoidc -p 8080:8080 \
	-v `pwd`/server-config.xml:/users/mitreidc/oidc/openid-connect-server-webapp/src/main/webapp/WEB-INF/server-config.xml \
	ghchinoy/mitreid-connect

## Use

See the [MITREid Connect documentation](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki) for more info. For example, [Endpoints available](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Server-configuration).

Without any other changes, the user/password is the same as the default git repo (`user` / `password`).

Exposed at 8080, as above (in the Run section), a few useful URLs, relative to "issuer" url, `IP/openid-connect-server-webapp`:

* Web interface - /
* Well-known configuration URL/ Provider url: /openid-connect-server-webapp/.well-known/openid-configuration
* Authorization endpoint: /authorize
* Token endpoint: /token
* Token introspection: /introspect
* Token revocation: /revoke
* JSON Web Key Set (public key): /jwk
* User info: /userinfo


## Build

See the `Dockerfile.mitreid-connect` for more info on how the image was constructed.

	docker build --tag ghchinoy/mitreid-connect -f Dockerfile.mitreid-connect .

## Notes

* the image is pretty fat, could use some slimming (1.225 GB)
* no need for `sudo` `curl`
* shorter filepath (no need for `/home/mitreidc`, for example)
* might be nice to regen jwks as per [docs](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Key-generation) on start of container
