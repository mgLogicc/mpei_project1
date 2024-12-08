import nltk
from nltk.corpus import stopwords

nltk.download('stopwords')


stop_words = set(stopwords.words('english'))
print(stop_words)