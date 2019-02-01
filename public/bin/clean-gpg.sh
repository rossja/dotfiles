#!/bin/bash
gpg --list-keys --with-colons | awk -F: '/^pub:/ { print  }'
