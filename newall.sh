#!/bin/bash
# 
# usage: ./new.sh pause

for dir in $(ls images)
do
{
    bash new.sh $dir
}
done
