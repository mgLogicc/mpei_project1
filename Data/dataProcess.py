# Imports
import csv
import nltk
from re import sub
from nltk.corpus import stopwords

# Downloads
nltk.download('stopwords')

counter = 0

# Function to extract title and content of each new in a csv file
def getData(file_path):

    data = []                                       # initialize list of lists containing the data

    # 'with' ensures the file is properly closed after used
    with open(file_path, mode='r', encoding='utf-8') as file:

        reader = csv.reader(file)                   # csv.reader interprets the file content as csv text. it treats each row as a list of values

        header = next(reader)                       # next() function retrieves the first row of the file
        
        for row in reader:                          # for each row in the reader
            data.append(row)                        # append the list to the data list



    data = [row[0] + "; " + row[1] for row in data]     # extract contents (title and text) separated by

    return data

# Function to pre-process data
def preProcessData(contents):

    stop_words = set(stopwords.words('english'))            # get stop words
    #print(stop_words)

    filteredData = []                                       # initialize list with the filtered news contents
    for i in range(len(contents)):                          # for each new                           

        tokenizedContent = contents[i].lower().split()      # tokenize the content 
        filteredContent = [word for word in tokenizedContent if word.isalpha() and word not in stop_words]   # filter out stop words and unwanted elements

        filteredData.append(filteredContent)                

    return filteredData

# Function to extract the vocabulary of the entire data (every unique word alphabetically sorted)
def buildVocabulary(preProcessedData):
    
    vocabulary = set()                          # initialize set to store vocabulary
    
    for data in preProcessedData:               # for each new 
        
        vocabulary.update(data)                 # add unique words from each document

    vocabulary = sorted(list(vocabulary))       # sort list

    return vocabulary


# Function to create a bag of words of a sentence
def createBagOfWords(sentence, vocab):
    #global counter
    vector = [0] * len(vocab)                           # list of zeros with the size of vocabulary

    #print(counter)
    for word in sentence:                               # for every word in the array
        if word in vocab:                               # if the word is in the vocabulary
            idx = vocab.index(word)                     # get the index of the current word
            vector[idx] += 1                            # increment the value
    #counter += 1
    return vector


# Function calculates the frequency of each word in the dataset
def getWordFrequencies(preProcessedData):

    wordFrequencies = {}                    # initialize the dictionary to store the frequencies of each word

    for sentence in preProcessedData:         # for each sentence
        
        for word in sentence:               # for each word

            if word in wordFrequencies:     # if the word 
                wordFrequencies[word] += 1
            else:
                wordFrequencies[word] = 1

    return wordFrequencies

def removeRareWords(preProcessedData, wordFrequencies):

    processedData = []

    for sentence in preProcessedData:
       
        processedSentence = [word for word in sentence if wordFrequencies.get(word,0) > 1]
        processedData.append(processedSentence)

    return processedData

def main():

    ## Processing fake news

    file_path = 'Data/Fake.csv'                             # file path

    fakeContents = getData(file_path)                       # fake content  (title + article)                  
    # print(fakeContents[0]) 

    preProcessFakeData = preProcessData(fakeContents)       # pre processed fake content
    #print(preProcessFakeData)

    ##

    ## Processing real news

    file_path = 'Data/True.csv'                             # file parh

    realContents = getData(file_path)                       # real content
    #print(realContents[0])

    preProcessRealData = preProcessData(realContents)       # pre processed real content
    # print(preProcessRealData)

    #words = 0 
    #news = 0
    #for sentence in preProcessRealData:                    #counter of news and words
    #    news = news + 1
    #    for word in sentence:
    #        words = words +1

    #print('news : ', news)
    #print('words : ', words)

    realVocabulary = buildVocabulary(preProcessRealData)        # vocabulary of the real data
    #print(vocabulary)

    #realBowVectors = [createBagOfWords(sentence, realVocabulary) for sentence in preProcessRealData]
    realBowVectors = [createBagOfWords(preProcessRealData[i], realVocabulary) for i in range(30)]
    #print("Bag of Words Vectors:")
    
    #non_zero_sum = sum(value for value in bow_vectors[4] if value != 0)
    #print(non_zero_sum)

    wordFreqs = getWordFrequencies(preProcessRealData)
    print(wordFreqs)

    processedRealData = removeRareWords(preProcessRealData, wordFreqs)
    print(processedRealData)


if __name__ == "__main__":
    main()