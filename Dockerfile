FROM tensorflow/tensorflow:2.14.0-gpu

RUN apt-get update && apt-get install -y libgl1 libglib2.0-0 wget

WORKDIR /app

RUN pip install --ignore-installed deepface tf-keras flask
RUN wget https://github.com/serengil/deepface_models/releases/download/v1.0/age_model_weights.h5 -P /root/.deepface/weights/
RUN wget https://github.com/serengil/deepface_models/releases/download/v1.0/gender_model_weights.h5 -P /root/.deepface/weights/
RUN wget https://github.com/serengil/deepface_models/releases/download/v1.0/race_model_single_batch.h5 -P /root/.deepface/weights/
RUN wget https://github.com/serengil/deepface_models/releases/download/v1.0/vgg_face_weights.h5 -P /root/.deepface/weights/
RUN wget https://github.com/serengil/deepface_models/releases/download/v1.0/facial_expression_model_weights.h5 -P /root/.deepface/weights/
RUN wget https://github.com/serengil/deepface_models/releases/download/v1.0/retinaface.h5 -P /root/.deepface/weights/

ADD app.py app.py

CMD python app.py
