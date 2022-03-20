# PRoCon Docker

A docker image for the lastest PRoCon release.

## Available images
```
For Europe: Time zone Europe/Berlin CET/CEST
hedius/procon:latest hedius/procon:cet

For USA: (Automatically switches to daylight saving time)
hedius/procon:cst
hedius/procon:pst
hedius/procon:est

The images are also available over gitlab:
registry.gitlab.com:e4gl/procon:lastest ...
```

## Permissions
The image runs with UID and GID 5000 (non-root).

Make sure that all files within volumes are owned by that user.

## Volumes
* /opt/procon/Configs
* /opt/procon/Plugins
* /opt/procon/Logs

You have to mount the volumes and fill them with valid configuration data for a PRoCon layer.

## License
The repo is licensed under GPLv3.

The images are licensed under the current license of [myrcon.net](https://myrcon.net/files/file/29-procon-client/).
