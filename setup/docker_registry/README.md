# Local docker registry

You can host your own docker registry that can be used to transmit images to a drone over a local network.
To start the regisry, spin up the compose session in this folder.
The registry is going to be insecure without a proper SSL certificate, therefore, the client needs to treat it in a special way.
Add the following line to `/etc/docker/daemon.json` in the client host operating system to allow pulling from your local registry:

```json
  
```
