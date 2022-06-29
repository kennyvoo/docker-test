FROM python:3.8-slim

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN apt update \
    && apt install python3-tk -y \
    && apt install x11-xserver-utils -y \
    && pip install matplotlib==3.2.1


COPY . .   
