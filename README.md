# Dockerfile for MITREid Connect

From https://github.com/mitreid-connect

Version 1.2.1 of MITREid Connect

## Run

Docker Hub image: https://hub.docker.com/r/ghchinoy/mitreid-connect/

	docker pull ghchinoy/mitreid-connect

### Configure 

The default `server-config.xml` for the webserver uses `localhost` as the "issuer" URL: `http://localhost/openid-connect-server-webapp/`

This will need to be overridden, otherwise the server will reference itself at `localhost` and not the expected Docker IP. To override this, specify the path to a custom `server-config.xml` file at runtime via the `-v` flag on `docker run`. A sample `server-config.xml` is included in this repository.

### Example

Example, run image with name `mitreoidc`, exposing port 8080 (as 8080), and mapping the `server-config.xml` to the one in the current directory:

	docker run -d --name mitreoidc -p 8080:8080 \
	-v `pwd`/server-config.xml:/users/mitreidc/oidc/openid-connect-server-webapp/src/main/webapp/WEB-INF/server-config.xml \
	ghchinoy/mitreid-connect

## Use

See the [MITREid Connect documentation](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki) for complete information. 

Web interface, where `ISSUER` is `issuer`, as above, user-modifiable via `server-config.xml`:

	http://ISSUER/openid-connect-server-webapp/

Without any other changes in additional configuration files, the user/password is the same as the default git repo (`user` / `password`).

Other [endpoints available](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Server-configuration):

Exposed at 8080, as above (in the Run section), a few useful URLs, relative to "issuer" url:

* Well-known configuration URL/ Provider url: `/.well-known/openid-configuration`
* Authorization endpoint: `/authorize`
* Token endpoint: `/token`
* Token introspection: `/introspect`
* Token revocation: `/revoke`
* JSON Web Key Set (public key): `/jwk`
* User info: `/userinfo`


## Build

See the `Dockerfile.mitreid-connect` for more info on how the image was constructed.

	docker build --tag ghchinoy/mitreid-connect -f Dockerfile.mitreid-connect .

## Notes

* the image is pretty fat, could use some slimming (1.225 GB)
* no need for `sudo` `curl`
* shorter filepath (no need for `/home/mitreidc`, for example)
* might be nice to regen jwks as per [docs](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Key-generation) on start of container
