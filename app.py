import numpy as np
import pickle
import streamlit as st

loaded_model = pickle.load(open('trained_model.sav','rb'))
def prediction(input_data):
    # input_data = ['Without uniform','Overspeeding']
    prediction = loaded_model.predict(input_data)
    print(prediction)
    return prediction[0]
def main():
    st.title('Prediction App')
    offence = st.text_input('Review')
    res = ''
    if st.button('Check Sentiment'):
        res = prediction([offence])
        if res==1:
            st.success("Sentiment: Positive")
        else:
            st.success("Sentiment: Negative")         
if __name__ == '__main__':
    main()