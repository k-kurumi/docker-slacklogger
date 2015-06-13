# docker-slacklogger

kuromoji入のelasticsearchにslackのログを保存する

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
- [ ] loggerを動くようする
- [ ] loggerをコンテナ化する

- [ ] analyzer指定が効いてない(今はindexごとに指定することで対処)
