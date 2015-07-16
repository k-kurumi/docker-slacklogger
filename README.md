# docker-slacklogger

kuromoji入りのelasticsearchにslackのログを保存する

コンテナ
- fluentd
- elasticsearch
- kibana
- logger(slackのログボット)
- rawlog(fluentdで分離したログ)

## INSTALL

```
pip install docker-compose
```

## USAGE

1. 設定ファイルの修正

        # サンプルから設定ファイルを作る
        cp logger/slack.env.sample logger/slack.env

        # SLACKのTOKENなどを変更する
        vi logger/slack.env

2. ビルドと起動

        docker-compose build
        docker-compose up


## elasticsearchが壊れた時の復旧方法について

2種類の復旧方法あり

- elasticsearch的な復旧手順をとる (要調査)
- 生ログ(rawlog)から流し直す (生ログはtsvで3つ目をそのまま送ればよい)


## TODO

- [ ] kuromojiをやめて2gram化(記号が検索できないため)
