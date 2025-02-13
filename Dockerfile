FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends avahi-utils alsa-utils curl build-essential libusb-1.0-0 libusb-1.0-0-dev

WORKDIR /app

COPY sounds/ ./sounds/
COPY script/setup ./script/
COPY pyproject.toml ./
COPY wyoming_satellite/ ./wyoming_satellite/
COPY examples/ ./examples/

RUN script/setup

COPY script/run ./script/
COPY script/run_usbmic ./script/
COPY docker/run ./

EXPOSE 10700

ENTRYPOINT ["/app/run"]
