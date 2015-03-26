@echo off

:: Node getting stuck on keeping port locked
taskkill /F /IM node.exe > nul 2>&1

:: not running by default in windows env
start mongod --dbpath C:\Temp\data

call npm install
call bower install
call forever -m 6 server.js