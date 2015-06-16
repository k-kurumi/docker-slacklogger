# docker-slacklogger

kuromoji入りのelasticsearchにslackのログを保存する

コンテナ
- fluentd
- elasticsearch
- kibana

## INSTALL

```
pip install docker-compose
```

## USAGE

ビルドと起動
```
docker-compose up
```

## TODO
- [ ] loggerをコンテナ化する
- [ ] 分かち書きをやめて2gram化(記号が検索できないため)
