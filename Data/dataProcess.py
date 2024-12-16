# Imports
import csv
import nltk
from nltk.corpus import stopwords

# Downloads
nltk.download('stopwords')


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
    
    for sentence in contents:

        loweredContent = sentence.lower().split()           # lower the sentence and split to check every word

        # for every word in the current sentence, if it meets the conditions, the word is added to filteredContent
        filteredContent = [word for word in loweredContent if word.isalpha() and word not in stop_words]
        filteredData.append(filteredContent)                # append to the data

    return filteredData


# Function calculates the frequency of each word in the dataset
def getWordFrequencies(preProcessedData):

    wordFrequencies = {}                    # initialize the dictionary to store the frequencies of each word

    for sentence in preProcessedData:       # for each sentence
        
        for word in sentence:               # for each word

            if word in wordFrequencies:     # if the word is in the dictionary
                wordFrequencies[word] += 1  # increment it
            else:   
                wordFrequencies[word] = 1   # if not: initialize its counter

    return wordFrequencies

# Function tot remove rare words
def processData(preProcessedData, wordFrequencies):

    processedData = []                  # initialize the processed data

    for sentence in preProcessedData:   # for each sentence 
       
        # add word with only more than 3 occurences to processedSentence
        processedSentence = [word for word in sentence if wordFrequencies.get(word,0) > 3 & isinstance(word, str)]
        
        # reconstructs the string from the list of words
        reconstructedSentence = ' '.join(processedSentence)
        processedData.append(reconstructedSentence)



    return processedData

    
# Function to save processed data to a CSV file
def saveDataToCSV(file_name, data):
    with open(file_name, mode='w', encoding='utf-8', newline='') as file:
        writer = csv.writer(file)
        for sentence in data:
            writer.writerow([sentence])  # Each line contains one sentence

def main():

    ## Processing fake news

    file_path = 'Fake.csv'                                 # file path
    fakeData = getData(file_path)                               # store all the data from the fake news


    preProcessedFakeData = preProcessData(fakeData)                         # pre process the fake data
    fakeWordFreqs = getWordFrequencies(preProcessedFakeData)                # get word frequencies from fake data
    processedFakeData = processData(preProcessedFakeData, fakeWordFreqs)    # process the fake data

    ##

    ## Processing real news

    file_path = 'True.csv'                             # file path
    realData = getData(file_path)                               # store all the data from the fake news


    preProcessedRealData = preProcessData(realData)                             # pre process the real data
    realWordFreqs = getWordFrequencies(preProcessedRealData)                    # get word frequencies from real data
    processedRealData = processData(preProcessedRealData, realWordFreqs)        # process the real data

    ##

    saveDataToCSV('processedFake.csv', processedFakeData)
    saveDataToCSV('processedTrue.csv', processedRealData)


if __name__ == "__main__":
    main()