from nltk.corpus import wordnet
import re
from nltk.stem import WordNetLemmatizer
import numpy as np
import pickle
import streamlit as st

from string import punctuation
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
stop_nltk = stopwords.words("english")
stop_nltk.remove('not')
stop_words = stop_nltk + list(punctuation) + ["..."] + ["phone", "mobile", "lenovo",
                                                        "k8", "product", "note", "amazon", "got", "n't", "'s"] + ["...."] + [".."]

lemm = WordNetLemmatizer()


def clean_txtlemma(sent):
    sent = re.sub(r"[^\w\s]+", " ", sent)
    tokens = word_tokenize(sent.lower())
    lemmatized = [lemm.lemmatize(
        term, pos='v') for term in tokens if term not in stop_nltk and len(term) > 1]
    res = " ".join(lemmatized)
    res = re.sub("n't", "not", res)  # replacing n't with not
    words = word_tokenize(res)
    new_words = []
    temp_word = ''
    for word in words:
        antonyms = []
        if word == 'not':
            temp_word = 'not '
        elif temp_word == 'not ':
            for syn in wordnet.synsets(word):
                for s in syn.lemmas():
                    for a in s.antonyms():
                        # replacing word following not with its antonymn
                        antonyms.append(a.name())
            if len(antonyms) >= 1:
                word = antonyms[0]
            else:
                word = temp_word + word
            temp_word = ''
        if word != 'not':
            new_words.append(word)
    new_words = [
        word for word in new_words if word not in stop_words and len(word) >= 2]
    res = ' '.join(new_words)
    return res


loaded_model = pickle.load(open('trained_model.sav', 'rb'))


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
        if res == 1:
            st.success("Sentiment: Positive")
        else:
            st.markdown('''
            <style>
            p {
                color: red;
            }
            </style>
            ''', unsafe_allow_html=True)
            st.success("Sentiment: Negative")


if __name__ == '__main__':
    main()
