FROM python:3.7.4-alpine

ENV SERVER_PORT 8888

RUN apk update && apk upgrade --no-cache

RUN apk --no-cache -U add python3-pip

RUN pip3 install webssh

RUN wssh --port=$SERVER_PORT
