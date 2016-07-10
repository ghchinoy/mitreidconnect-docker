#!/bin/sh
version=`curl -s https://raw.githubusercontent.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/master/pom.xml \
   | sed -n -e '1,/\<version\>/s~^.*<version>\(.*\)</version>~\1~p'`
echo Current version of mitreid-connect is $version
docker build --tag ghchinoy/mitreid-connect:$version --tag ghchinoy/mitreid-connect:latest -f Dockerfile.mitreid-connect .


