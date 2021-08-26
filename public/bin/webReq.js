'use strict';
/* --------------------------------------------
** generic web request framework using nodejs
** --------------------------------------------
**/
const http = require('http');

const method = 'GET';
const hostname = 'icanhazip.com';
const path = '/'
const port = 80;

const postData = JSON.stringify({
  'key' : 'val'
})

const headers = {
  'x-random-header': 'true',
  'Cookie': 'JSESSIONID=supersecrettoken',
}

const options = {
  hostname: hostname,
  port: port,
  path: path,
  method: method,
  headers: headers,
}

const req = http.request(options, (res) => {
  console.log(`STATUS: ${res.statusCode}`);
  console.log(`HEADERS: ${JSON.stringify(res.headers)}`);
  res.setEncoding('utf8');
  res.on('data', (chunk) => {
    console.log(`BODY: ${chunk}`);
  });
  res.on('end', () => {
    console.log('No more data in response.');
  });
});

req.on('error', (e) => {
  console.error(`problem with request: ${e.message}`);
});

// write data to request body
req.write(postData);
req.end();
