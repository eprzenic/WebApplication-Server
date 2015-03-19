@echo off

:: not running by default in windows env
start mongod --dbpath C:\Temp\data

call npm install
call forever -m 6 server.js