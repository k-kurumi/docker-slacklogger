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

## TODO

- [ ] kuromojiをやめて2gram化(記号が検索できないため)
