FROM ubuntu:16.04
MAINTAINER Bodastage Engineering <engineering@bodastage.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y python python-pip python-virtualenv gunicorn netcat

# Setup flask application
RUN mkdir -p /deploy/
RUN mkdir -p /app
COPY ./requirements.txt /deploy/requirements.txt
RUN pip install -r /deploy/requirements.txt
WORKDIR /app

# 
COPY ./wait-for-it.sh /wait-for-it.sh
RUN chmod 777 /wait-for-it.sh

EXPOSE 8181

# Start gunicorn
CMD ["/usr/bin/gunicorn", "--config", "/app/gunicorn_config.py", "wsgi:app"]
