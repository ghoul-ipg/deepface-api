FROM python:3.11-slim
WORKDIR /app
ADD app.py app.py
RUN pip install deepface

CMD python app.py
