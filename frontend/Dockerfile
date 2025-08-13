# Node.js公式イメージ（LTS）を使用
FROM node:20-alpine

# 作業ディレクトリを設定
WORKDIR /app

# 依存関係だけ先にコピーしてインストール
COPY package*.json ./
RUN npm install

# 残りのソースコードをコピー
COPY . .

# Next.jsのポート
EXPOSE 3000

# 開発モード（ホットリロード）
CMD ["npm", "run", "dev"]
