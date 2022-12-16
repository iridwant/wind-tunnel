FROM python:3.8-slim

ENV WIND_TUNNEL /usr/local/windtunnel

# Downloading basic lib
RUN set -ex \
    && apt-get update \
    && useradd -ms /bin/bash -d ${WIND_TUNNEL} wind_tunnel \
    && apt-get install -y \ 
    default-libmysqlclient-dev \ 
    gcc

COPY ./requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

WORKDIR ${WIND_TUNNEL}

COPY . .

COPY ./script/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]