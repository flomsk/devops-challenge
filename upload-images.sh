#!/bin/bash
docker build -f Dockerfile.calc -t calc .
docker build -f Dockerfile.a -t a .
docker build -f Dockerfile.dv -t dv .
docker tag a $1/$2:a && docker tag dv $1/$2:dv && docker tag calc $1/$2:calc
docker push $1/$2:a && docker push $1/$2:dv && docker push $1/$2:calc
