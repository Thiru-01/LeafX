import cv2
from flask import Flask, jsonify, request
import os
import base64
import json
import numpy as np
from keras.models import load_model
from keras.applications.vgg16 import preprocess_input
from keras.preprocessing.image import img_to_array
global jsondata
#python -m flask run --host 192.168.1.4 --port 444
app = Flask(__name__)
model = load_model(os.getcwd()+"\plant_disease_detection.h5")
total_data = ['Apple___Apple_scab', 'Apple___Black_rot', 'Apple___Cedar_apple_rust', 'Apple___healthy', 'Blueberry___healthy', 'Cherry_(including_sour)___healthy', 'Cherry_(including_sour)___Powdery_mildew', 'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot', 'Corn_(maize)___Common_rust_', 'Corn_(maize)___healthy', 'Corn_(maize)___Northern_Leaf_Blight', 'Grape___Black_rot', 'Grape___Esca_(Black_Measles)', 'Grape___healthy', 'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)', 'Orange___Haunglongbing_(Citrus_greening)', 'Peach___Bacterial_spot', 'Peach___healthy', 'Pepper,_bell___Bacterial_spot', 'Pepper,_bell___healthy', 'Potato___Early_blight', 'Potato___healthy', 'Potato___Late_blight', 'Raspberry___healthy', 'Soybean___healthy', 'Squash___Powdery_mildew', 'Strawberry___healthy', 'Strawberry___Leaf_scorch', 'Tomato___Bacterial_spot', 'Tomato___Early_blight', 'Tomato___healthy', 'Tomato___Late_blight', 'Tomato___Leaf_Mold', 'Tomato___Septoria_leaf_spot', 'Tomato___Spider_mites Two-spotted_spider_mite', 'Tomato___Target_Spot', 'Tomato___Tomato_mosaic_virus', 'Tomato___Tomato_Yellow_Leaf_Curl_Virus']
@app.route('/home' , methods=['GET', 'POST'])
def API():
     
    images = request.files['asset'].read()
    npimg = np.fromstring(images,np.uint8)
    im = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
    im = cv2.resize(im,(500,600))
    with open(os.getcwd()+"\data.json",encoding="utf8") as jsonFile:
        data = json.load(jsonFile)
        jsondata = data
    current_data = validatemodel(im)
    print(current_data)
    if jsondata[current_data]["image_path"]=="None":
        string_img = base64.b64encode(cv2.imencode('.jpg', im)[1]).decode()
        jsondata[current_data]["image_path"]=string_img
    else:
        print(os.path.join(os.getcwd(),jsondata[current_data]["image_path"]))
        healthy_image = cv2.imread(os.path.join(os.getcwd(),jsondata[current_data]["image_path"]))
        string_img = base64.b64encode(cv2.imencode('.jpg', healthy_image)[1]).decode()
        jsondata[current_data]["image_path"]=string_img
    
    return jsonify(jsondata[current_data])    

def validatemodel(file):
    vid_data = cv2.resize(file, (224, 224))
    image = img_to_array(vid_data)
    image = np.expand_dims(image, axis=0)
    image = preprocess_input(image)
    result = model.predict(image)
    return total_data[np.argmax(result, axis=1)[0]]


if __name__ == '__main__':
    app.run()
