import base64
import traceback

from flask import Flask, request, jsonify
from deepface import DeepFace

app = Flask(__name__)

@app.route("/")
def check():
    return "Work on"


def clean_data(obj):
    result = {}
    if age := obj.get('age'):
        result['age'] = age
    if race := obj.get('dominant_race'):
        result['race'] = race
    if gender := obj.get('dominant_gender'):
        result['gender'] = gender
    if region := obj.get('region'):
        result['region'] = [region['x'], region['y'], region['x'] + region['w'], region['y'] + region['h']]
    return result

def image_to_base64(image):
    image_bytes = image.stream.read()
    base64_image = base64.b64encode(image_bytes).decode('utf-8')
    return "data:image/png;base64," + base64_image

@app.route("/deepface", methods=["POST"])
def process_image():
    image = request.files.get('image')
    try:
        objs = DeepFace.analyze(
            img_path=image_to_base64(image),
            detector_backend='retinaface',
            actions=['age', 'gender', 'race'],
        )
        return jsonify([clean_data(obj) for obj in objs])
    except Exception as e:
        print(traceback.format_exc())
        return jsonify({"error_message": str(e)}), 400


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
