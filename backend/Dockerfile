# GradleとJavaの両方が入ったイメージを使う
FROM gradle:8.10.2-jdk17-alpine AS build

# 作業ディレクトリ設定
WORKDIR /app

# 依存関係だけ先にコピーしてキャッシュ
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
RUN gradle dependencies --no-daemon || return 0

# 残りのソースをコピー
COPY . .

# Spring Bootのビルド
RUN gradle bootJar --no-daemon

# 実行用イメージ
FROM openjdk:17-jdk-slim
WORKDIR /app

# ビルド成果物をコピー
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

# Spring Boot実行
ENTRYPOINT ["java", "-jar", "app.jar"]
