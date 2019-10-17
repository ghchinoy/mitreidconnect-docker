# Dockerfile for MITREid Connect

This is a Dockerfile that builds an image for the latest version of [MITREid Connect](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server).

For OpenID Connect supported features of this server, see [Supported Features documentation](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Features).

## Run

Obtain the Docker image from Docker Hub image: https://hub.docker.com/r/ghchinoy/mitreid-connect/

	docker pull ghchinoy/mitreid-connect

If you'd like to build your own image, see the [Build](#build) section, below.

### Configure

#### Server URL

The default `server-config.xml` for the webserver uses `localhost` as the "issuer" host and context url (http://HOST/CONTEXT):

	http://localhost:8080/openid-connect-server-webapp/

This will need to be overridden, otherwise the server will reference itself at `localhost` and not the expected Docker IP. To override this, modify `server-config.xml`'s `issuer` property. Specify the path to a custom `server-config.xml` file at runtime via the `-v` flag on `docker run`.

The file to override is `openid-connect-server-webapp/src/main/webapp/WEB-INF/server-config.xml` and is located in the installation home, `/opt/mitreidc/`.

A sample `server-config.xml` is included in this repository.


#### Users

The image uses an in-memory HyperSQL database with default users. To add users, provide a user-specified `resources/db/users.sql` file.

### Example

Run a container  

* named `mitreoidc`
* expose port 8080 (as 8080)
* map `server-config.xml` to one in the current directory. You must have a `server-config.xml`. You could use the sample file included in this repository.

```
docker run -d --name mitreoidc -p 8080:8080 \
-v `pwd`/server-config.xml:/opt/mitreidc/openid-connect-server-webapp/src/main/webapp/WEB-INF/server-config.xml \
ghchinoy/mitreid-connect
```

## Use

See the [MITREid Connect documentation](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki) for complete information.

Web interface, where `HOST` is `issuer`'s host, as [above](#configure), user-modifiable via `server-config.xml`:

	http://HOST/openid-connect-server-webapp/

Without any other changes in additional configuration files, the user/password is the same as the default git repo (`user` / `password`; there's also an `admin` user).

Other [endpoints available](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Server-configuration):

Exposed at 8080, as above (in the [Run](#configure) section), a few useful URLs, relative to "issuer" context path:

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

See also build.sh which automatically sets the version tag to the version of mitreid-connect.

## Notes

* the image is pretty fat, could use some slimming (1.207 GB, thanks maven!)
* no need for `sudo`
* probably no need for other projects, for now (client, uma-server*)
* might be nice to regen jwks as per [docs](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/wiki/Key-generation) on start of container
