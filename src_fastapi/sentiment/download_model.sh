#!/bin/bash
wget https://frenzy86.s3.eu-west-2.amazonaws.com/python/hugging/sentiment_distilbert/model.bin
mv model.bin app/api/distilbert/

wget https://frenzy86.s3.eu-west-2.amazonaws.com/python/hugging/sentiment_roberta/model.bin
mv model.bin app/api/roberta/