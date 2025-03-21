# Docker PRoCon Image
# Creator:  H3dius/Hedius admin@e4gl.com
FROM mono:latest

# user and group ID of the account for full read/write access
ARG UID=5000
ARG GID=5000
ARG TZ="Europe/Berlin"
ARG FILE="procon.zip"
# ARG DLURL="https://api.myrcon.net/procon/download?p=docker"
# Custom E4GL image for also logging spawn events.
ARG DLURL="https://github.com/Hedius/Procon-1/releases/download/1.5.5.0-e4gl/latest_procon.zip"

LABEL maintainer="Hedius @ gitlab.com/hedius" \
      description="PRoCon Docker image" \
      version="1.0"

# install unzip, wget
RUN apt-get update && \
    apt-get install -y unzip wget iputils-ping && \
    rm -rf /var/lib/apt/lists/*

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

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER  procon:procon

VOLUME ["/opt/procon/Configs", "/opt/procon/Plugins", "/opt/procon/Logs"]

ENTRYPOINT ["mono", "PRoCon.Console.exe"]
