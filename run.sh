#!/bin/bash
set -e

mongod &
npm install
bower install
gulp