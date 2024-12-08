# Imports
import csv
import nltk
from re import sub
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



    contents = [row[0] + "; " + row[1] for row in data]     # extract contents (title and text) separated by

    return contents

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



def main():

    file_path = 'Data/Fake.csv'                             # file path

    fakeContents = getData(file_path)                       # fake content                       
    # print(fakeContents[0]) 

    preProcessFakeData = preProcessData(fakeContents)       # pre processed fake content
    print(preProcessFakeData)


if __name__ == "__main__":
    main()