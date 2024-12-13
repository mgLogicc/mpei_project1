import csv
import sys

input_file = 'Fake.csv'
output_file = 'bf_data_fake.csv'

csv.field_size_limit(sys.maxsize)

with open(input_file, mode ='r')as file:
  csvFile = csv.reader(file)

  header = next(csvFile)

  links = []
  for row in csvFile:
    if len(row) > 8:
      links.append(row[8]);
  
  
  setlinks = set(links)
  print(setlinks)


with open(output_file, "w",newline="") as outfile:
    writer = csv.writer(outfile)
    
    writer.writerow(['site_url'])

    for value in setlinks:
        writer.writerow([value])
