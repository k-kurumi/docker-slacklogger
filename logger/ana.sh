#!/bin/bash

# テンプレートからanalyzer指定がうまくいかないので
# logstash形式のindexが出来る前にこれを実行して
# kuromoji_tokenizerを使うようにする(しないと検索不可)
curl -XPUT 'localhost:9200/slack-2015.06.13' -d '
{
  "settings": {
    "analysis": {
      "analyzer": {
        "default": {
          "tokenizer": "kuromoji_tokenizer"
        }
      }
    }
  }
}
'
