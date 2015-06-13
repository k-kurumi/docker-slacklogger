#!/bin/bash

# templateでの設定がうまくいかないため
# analyzerをindexごとに指定する
#
# indexが作られる前に指定しないと失敗する
# cronで日付が変わる前に実行させること


# curl -XPUT 'localhost:9200/slack-2015.06.13' -d '
# {
#   "settings": {
#     "analysis": {
#       "analyzer": {
#         "default": {
#           "tokenizer": "kuromoji_tokenizer"
#         }
#       }
#     }
#   }
# }
# '

next_index=$(date -d '1 days' '+slack-%Y.%m.%d')

echo "create next index analyzer: $next_index"

# 明日のindexにkuromoji_tokenizerを指定する
curl -XPUT "localhost:9200/${next_index}" -d '
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
