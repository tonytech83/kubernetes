FROM python:3.9-slim-buster

RUN mkdir /data

COPY code/* /app/

WORKDIR /app

RUN pip3 install -r requirements.txt

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]