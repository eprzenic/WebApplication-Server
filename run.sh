#!/bin/bash
set -e

mongod &
npm install
bower install
forever -m 6 server.js