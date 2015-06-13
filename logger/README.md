
## Usage


mappingの指定(TODO:ここでanalyzer指定が効かないため調べる)

```
$ curl -XPUT 'localhost:9200/_template/slack_template2' -d '@slack.json'
```


analyzerの指定(slack-*とはできなかった)

- ana.sh
- generate_next_index_analyzer.sh (明日分のindexを更新)

```
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
```


インデックスにアナライザがデフォルトとして登録された確認する
```
$ curl 'localhost:9200/slack-2015.06.13/_analyze?pretty' -d '新しい日時フォーマットzz2テスト'
{
  "tokens" : [ {
    "token" : "新しい",
    "start_offset" : 0,
    "end_offset" : 3,
    "type" : "word",
    "position" : 1
  }, {
    "token" : "日時",
    "start_offset" : 3,
    "end_offset" : 5,
    "type" : "word",
    "position" : 2
  }, {
    "token" : "フォーマット",
    "start_offset" : 5,
    "end_offset" : 11,
    "type" : "word",
    "position" : 3
  }, {
    "token" : "zz",
    "start_offset" : 11,
    "end_offset" : 13,
    "type" : "word",
    "position" : 4
  }, {
    "token" : "2",
    "start_offset" : 13,
    "end_offset" : 14,
```
