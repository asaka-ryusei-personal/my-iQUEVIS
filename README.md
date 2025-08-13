# my-iQUEVIS
アンケートシステムの画面モックを作成します。
## 技術要素
用いるのは以下。あまりよくわかっていないため、キャッチアップしながら開発を行っていきます。
* Next.js
* React bootstrap
* App Router
## おおまかな方針
* 手元でコードを書いて動作させながら、技術をキャッチアップします。
* おおよそ5日間程度の開発期間の見込み（-2025/07/23まで）。
* と考えていましたが、もう少しだけ頑張ろうと思います（現在2025/07/25）。
## DBの初期化について
* docker compose build のやり直しは不要。
* initialize.sqlを書き直した場合、docker exec -i myiquevis-db psql -U postgres -d postgres < db/initialize.sql で再実行すればデータを残したまま初期化できる。
* 既存のデータが不要な場合、docker compose down -v でコンテナ+ボリュームを削除し、docker compose up で初期化される。


