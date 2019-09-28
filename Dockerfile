FROM python:3.7.4-alpine

RUN apk update && apk upgrade --no-cache

RUN apk --no-cache -U add wget build-base openssl-dev libffi-dev

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 ./get-pip.py && \
    pip3 install webssh

EXPOSE 8888

ENTRYPOINT ["sh", "-c", "wssh", "--port=8888"]
