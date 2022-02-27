import os 
import numpy as np
import visualkeras
import pandas as pd 
import matplotlib.pyplot as plt 
import tensorflow as tf
from tensorflow import keras
from keras.layers import *
from tensorflow.keras import callbacks, layers, Model
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from ann_visualizer.visualize import ann_viz

image_size = 224
target_size = (image_size, image_size)
input_shape = (image_size, image_size, 3)
grid_shape = (1, image_size, image_size, 3)

batch_size = 32
dataset_root="herbalDect/DataSet/New Plant Diseases Dataset(Augmented)/New Plant Diseases Dataset(Augmented)"
train_dir = os.path.join(dataset_root, "train")
test_dir = os.path.join(dataset_root, "valid")
train_aug = ImageDataGenerator(
    
    rescale=1/255.0, 
    fill_mode="nearest", 
    width_shift_range=0.2,
    height_shift_range=0.2, 
    zoom_range=0.2, 
    shear_range=0.2,
) 
train_data = train_aug.flow_from_directory(
    train_dir,
    target_size=(image_size, image_size),
    batch_size=batch_size,
    class_mode="categorical"
)
cats = list(train_data.class_indices.keys())
model = keras.models.Sequential()

model.add(
  Conv2D(
      32, (3, 3),
      padding="same",
      input_shape=input_shape,
      activation="relu"))
model.add(Dropout(0.2))

model.add(
  Conv2D(
      32, (3, 3),
      padding="same",
      input_shape=(32, 32, 3),
      activation="relu"))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.2))

model.add(
  Conv2D(
      64, (3, 3),
      padding="same",
      input_shape=(32, 32, 3),
      activation="relu"))
model.add(Dropout(0.2))

model.add(
  Conv2D(
      64, (3, 3),
      padding="same",
      input_shape=(32, 32, 3),
      activation="relu"))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.2))

model.add(Flatten())
model.add(Dense(512, activation="relu"))
model.add(Dropout(0.2))

model.add(Dense(38, activation="softmax"))


model.summary()
model.compile(optimizer="adam", loss="categorical_crossentropy", metrics=["accuracy"])
ann_viz(model, title="LeafX")
early_stopping_cb = callbacks.EarlyStopping(monitor="loss", patience=3) 
epochs = 30
history = model.fit(
    train_data,
    epochs=epochs,
    steps_per_epoch=150,
    callbacks=[early_stopping_cb]
)
model.save("plant_disease_detection.h5")

hist = history.history

# Plot accuracy and loss
plt.plot(hist["accuracy"], label="accuracy")
plt.plot(hist["loss"], label="loss")

if "val_accuracy" in hist and "val_loss" in hist:
    plt.plot(hist["val_accuracy"], label="val_accuracy")
    plt.plot(hist["val_loss"], label="val_loss")
0
# Add the labels and legend
plt.ylabel("Accuracy / Loss")
plt.xlabel("Epochs #")
plt.legend()

# Finally show the plot
plt.show()
