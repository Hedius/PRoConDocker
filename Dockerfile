# Docker PRoCon Image
# Creator:  H3dius/Hedius admin@e4gl.com
FROM mono:latest

# user and group ID of the account for full read/write access
ARG UID=5000
ARG GID=5000
ARG TZ="Europe/Berlin"
ARG FILE="procon_1.5.3.5.zip"
# ARG DLURL="https://api.myrcon.net/procon/download?p=docker&v=1.5.3.0"

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
ADD --chown=procon:procon $FILE .
#RUN wget -q -O $FILE $DLURL && \
RUN    unzip -x $FILE && \
    chown procon:procon -R /opt/procon && \
    rm -r Configs Plugins $FILE

USER  procon:procon

VOLUME ["/opt/procon/Configs", "/opt/procon/Plugins"]

ENTRYPOINT ["mono", "PRoCon.Console.exe"]