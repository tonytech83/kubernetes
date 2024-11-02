import random
import os
import platform
import requests
import dns.resolver
from flask import Flask

a = ['Blue', 'Black', 'Yellow', 'White', 'Green', 'Orange', 'Purple', 'Pink', 'Brown', 'Gray', 'Red']
b = ['Tigers', 'Lions', 'Crocodiles', 'Horses', 'Donkeys', 'Dogs', 'Cats', 'Bears', 'Pandas', 'Coalas', 'Chameleons', 'Lizards']
c = ['Fat', 'Fast', 'Slow', 'Tall', 'Short', 'Weak', 'Strong', 'Slim']
d = ['Eat', 'Dream', 'Like', 'Adore', 'Trow', 'Love', 'Dislike']
e = ['Oranges', 'Bananas', 'Tomatoes', 'Potatoes', 'Onions', 'Cucumbers', 'Nuts']

app = Flask(__name__)

@app.route('/')
def main():
  f = a[random.randrange(10)] + ' ' + b[random.randrange(11)] + ' Are ' + c[random.randrange(7)] + ' And ' + d[random.randrange(6)] + ' ' + e[random.randrange(6)]

  fin = open('/data/facts.txt', 'a')
  fin.write(f + '\n')
  fin.close()

  s = '<h5>Recently discovered fact</h5>\n'
  s = s + '<h3>' + f + '</h3>\n'
  s = s + '<hr>\n'
  s = s + '<small><i>Served by <b>' + platform.node() + '</b></i></small>\n'
  s = s + '<hr>\n'

  records = dns.resolver.resolve('facts.default.svc.cluster.local', 'SRV')
  for r in records:
    response = requests.get('http://' + str(r.target).rstrip('.') + ':5000/facts')
    s = s + response.text + '<br />\n'

  return s

@app.route('/facts')
def facts():
  i = 0

  if os.path.isfile('/data/facts.txt'):
    i = len(open('/data/facts.txt').readlines(  ))

  s = platform.node() + ' contains ' + str(i) + ' fact(s)'
  return s
