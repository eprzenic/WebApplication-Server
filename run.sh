#!/bin/bash
set -e

mongod &
npm install
bower install
call forever -m 6 server.js