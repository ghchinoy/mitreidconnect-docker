# Changelog

## 0.0.4 20160710

* Change to use FROM maven:latest
* Added a build.sh script that tags the current mitreid-connect version as well as :latest.

## 0.0.3 20150822

* slimmed image slightly to 1.207 GB by removing double maven build
* added jetty preload

## 0.0.2 20150822

* slimmed image slightly from 1.225 GB to 1.217 GB
* removed curl
* changed `HOME` from `/home/mitreidc` to `/opt/mitreidc`
* placed git checkout in `HOME` with no subdir

## 0.0.1 20150822

* initial image created
