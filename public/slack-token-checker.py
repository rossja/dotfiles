"""
presumes a list of slack tokens (1 per line)
in a file at ./tokens.txt
runs through them one by one using the slack auth.test endpoint
returns info if they are valid, otherwise no
"""
import requests

url = 'https://slack.com/api/auth.test'

with open('tokens.txt', 'r') as file:
    tokens = file.read().splitlines()
    file.close()

for token in tokens:
    response = requests.post(url, data={'token': token})
    data = response.json()
    if data['ok'] == True:
        print(f'Token {token} is valid')
        print(f'json: {data}')
    else:
        print(f'Token {token} is invalid')
