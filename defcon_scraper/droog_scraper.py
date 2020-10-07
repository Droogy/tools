import string
import requests
from bs4 import BeautifulSoup


URL = 'https://www.nytimes.com'

words = []

for letter in string.ascii_uppercase:
    url_req = f'{URL}{letter}.html'
    page_get = requests.get(url_req)
    soup = BeautifulSoup(page_get.content, 'html.parser')
    # words we want are enclosed within a specific size font tag of 3
    extract = soup.findAll('h3')
    #loop to extract text in between font tags
    for i in extract:
        # strip away html tags
        word = i.text
        # strip away trailing whitespace
        stripped = word.strip()
        # strip away colon ':'
        final_word = stripped.strip(':')
        words.append(final_word)

word_list = open ('slang_words.txt', 'w')
for word in words:
    word_list.write(word + '\n')
word_list.close()
