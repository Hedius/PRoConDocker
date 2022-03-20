# Docker PRoCon Image
# Creator:  H3dius/Hedius admin@e4gl.com
FROM mono:latest

# user and group ID of the account for full read/write access
ARG UID=5000
ARG GID=5000
ARG TZ="Europe/Berlin"
ARG FILE="procon.zip"
ARG DLURL="https://api.myrcon.net/procon/download?p=docker"

LABEL maintainer="Hedius @ gitlab.com/hedius" \
      description="PRoCon Docker image" \
      version="1.0"

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install unzip, wget
RUN apt-get update && apt-get install -y unzip wget iputils-ping

# account for execution
RUN groupadd -r -g $GID procon && \
    useradd -r -g procon -u $UID procon

# Set the workdirectory
WORKDIR /opt/procon

# Download and unzip procon
RUN wget -O $FILE $DLURL && \
    unzip -x $FILE && \
    chown procon:procon -R /opt/procon && \
    rm -r Configs Plugins $FILE

USER  procon:procon

VOLUME ["/opt/procon/Configs", "/opt/procon/Plugins", "/opt/procon/Logs"]

ENTRYPOINT ["mono", "PRoCon.Console.exe"]
