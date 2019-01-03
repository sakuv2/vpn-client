## これは何？
softether vpn clientを用いてsoftether vpn serverに接続するdockerイメージ

## 使い方
鯖が建ってる前提

docker-compose.yamlの環境変数を編集して

```bash
docker-compose up -d
```

するだけ

## ISSUE
DHCPで自動的にip付加するとなんかバグる