FROM python:3.11-slim

RUN apt-get update && apt-get install -y libgl1 libglib2.0-0

WORKDIR /app

RUN pip install deepface tf-keras flask 

ADD app.py app.py

CMD python app.py
