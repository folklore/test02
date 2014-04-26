#!/bin/bash

git add . ;
git add -u ;
git commit -m 'deploy' ;
git push heroku master ;