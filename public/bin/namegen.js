#!/usr/bin/env node
'use strict';

const https = require('https');
const method = 'GET';
const hostname = '7zeykcc5z3.execute-api.us-east-1.amazonaws.com';
const path = '/prod/namegen/' ;
const port = 443;

const headers = {
  'x-treme': 'true',
}

const postData = JSON.stringify({
  'key' : 'val'
});

const options = {
  hostname: hostname,
  port: port,
  path: path,
  method: method,
  headers: headers,
}

const req = https.request(options, (res) => {

  res.on('data', function(data) {
    const jsonData = JSON.parse(data.toString('utf8'));
    console.log(jsonData.body);
  });

  res.on('end', () => {
    console.log('no more data');
  });

});

req.on('error', (e) => {
  console.error(`problem with request: ${e.message}`);
});

// write data to request body
req.write(postData);
req.end();
