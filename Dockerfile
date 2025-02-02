# syntax=docker/dockerfile:1

FROM python:3.11-slim-buster

WORKDIR /app
VOLUME ["/cfg", "/log", "/rec"]

COPY src src/
COPY setup.py setup.cfg ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg build-essential python3-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install --no-cache-dir -e . && \
    apt-get purge -y --auto-remove build-essential python3-dev
# ref: https://github.com/docker-library/python/issues/60#issuecomment-134322383

ENV DEFAULT_SETTINGS_FILE=/cfg/settings.toml
ENV DEFAULT_LOG_DIR=/log
ENV DEFAULT_OUT_DIR=/rec

EXPOSE 2233
ENTRYPOINT ["blrec", "--host", "0.0.0.0"]
CMD []
