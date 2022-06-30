FROM python:slim-buster as build-stage

COPY . /app

WORKDIR /app

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install nginx \
    && apt-get -y install python3-dev \
    && apt-get -y install build-essential \
    && apt-get -y install wkhtmltopdf \
    && apt-get -y install git \
    && apt-get -y install netcat

ENV FLASK_APP /app/app.py

RUN pip install -r requirements.txt --src /usr/local/src
COPY nginx.conf /etc/nginx
RUN chown -R www-data:www-data ./templates
RUN chmod +x ./start.sh
CMD flask run

FROM python:slim-buster as production-stage
RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install nginx \
    && apt-get -y install wkhtmltopdf \
    && apt-get -y install python3-dev \
    && apt-get -y install build-essential \
    && apt-get -y install netcat

COPY --from=build-stage /app /app

WORKDIR /app

RUN pip install -r requirements.txt --src /usr/local/src
COPY nginx.conf /etc/nginx
RUN chown -R www-data:www-data ./templates
RUN chmod +x ./start.sh

CMD ["./start.sh"]

