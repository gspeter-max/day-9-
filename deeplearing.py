import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.optimizers import SGD

# Sample data: [hours of study, hours of sleep]
# Let's assume the labels: 1 -> Passed, 0 -> Failed
X = np.array([[5, 7],  # 5 hours of study, 7 hours of sleep -> Passed
              [1, 3],  # 1 hour of study, 3 hours of sleep -> Failed
              [6, 8],  # 6 hours of study, 8 hours of sleep -> Passed
              [2, 4],  # 2 hours of study, 4 hours of sleep -> Failed
              [7, 5],  # 7 hours of study, 5 hours of sleep -> Passed
              [3, 2]]) # 3 hours of study, 2 hours of sleep -> Failed

y = np.array([1, 0, 1, 0, 1, 0])  # Labels (1 = Passed, 0 = Failed)

# Define the perceptron model (a simple neural network with 1 layer)
model = Sequential()

# The perceptron has 2 input neurons (one for each feature) and 1 output neuron
# 'sigmoid' activation function since it's binary classification
model.add(Dense(1, input_dim=2, activation='sigmoid'))

# Compile the model with binary cross-entropy loss and stochastic gradient descent
model.compile(loss='binary_crossentropy', optimizer=SGD(), metrics=['accuracy'])

# Train the model with the data
model.fit(X, y, epochs=100, verbose=1)

# Making predictions (for example, predicting for a student with 4 hours of study and 6 hours of sleep)
prediction = model.predict(np.array([[4, 6]]))
print(f'Prediction for 4 hours of study and 6 hours of sleep: {"Passed" if prediction >= 0.5 else "Failed"}')

