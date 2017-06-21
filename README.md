Domoticz
======

Domoticz - http://www.domoticz.com/

Latest Domoticz git release.

## Dockerimage

[![](https://images.microbadger.com/badges/image/jccomputing/rpi-domoticz.svg)](https://microbadger.com/images/jccomputing/rpi-domoticz "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/jccomputing/rpi-domoticz.svg)](https://microbadger.com/images/jccomputing/rpi-domoticz "Get your own version badge on microbadger.com")

## How to use

**Pull image**

```
docker pull jccomputing/rpi-domoticz:$VERSION

```

**Run container**

```
docker run -d -p 8080:8080 --name=<container name> -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro --device=<device_id> jccomputing/rpi-domoticz:$VERSION
```

Please replace all user variables in the above command defined by <> with the correct values (you can have several USB devices attached, just add other `--device=<device_id>`).

**Access Domoticz**

```
http://<host ip>:8080
```

8080 can be another port (you change `-p 8080:8080` to `-p 8081:8080` to have 8081 out of the container for example).
