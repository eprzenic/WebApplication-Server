#!/bin/bash
set -e

mongod &
npm install
call forever -m 6 server.js