import csv
from bs4 import BeautifulSoup
import requests
import time

rows = []

# url = "https://en.wikipedia.org/wiki/Category:Cryptographic_attacks"
def scrape_content(url):
    page = requests.get(url)
    page_content = page.content
    soup = BeautifulSoup(page_content, 'html.parser')
    content = soup.find('div', class_='mw-category')
    all_groupings = content.find_all('div', class_='mw-category-group')
    for grouping in all_groupings:
        names_list = grouping.find('ul')
        category = grouping.find('h3').get_text()
        alpha_names = names_list.find_all('li')
        for alpha_name in alpha_names:
            name = alpha_name.text
            anchortag = alpha_name.find('a',href = True)
            link = anchortag['href']
            letter_name = category
            row = {'name':name,
                   'link':link,
                   'letter_name':letter_name}
            rows.append(row)

user_url = input('What url do you wanna scrape?: ')
scrape_content(user_url)
csv_name = input('what do you wanna name the csv?: ')

with open(csv_name + '.csv', 'w+') as csvfile:
    fieldnames = ['name', 'link', 'letter_name']
    writer = csv.DictWriter(csvfile, fieldnames = fieldnames)
    writer.writeheader()
    for row in rows:
        writer.writerow(row)
print(csv_name + '.csv is ready!')
