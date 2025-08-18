DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

-- CREATE USER postgres
-- WITH
--   PASSWORD 'password';
-- CREATE DATABASE postgres OWNER postgres;
-- 依存関係を考慮した順序でテーブルを作成
CREATE TABLE
  dept (
    dept_id SERIAL PRIMARY KEY NOT NULL,
    dept_name varchar(100) NOT NULL UNIQUE
  );

CREATE TABLE
  enquete_state (
    enquete_state_id SERIAL PRIMARY KEY NOT NULL,
    enquete_state varchar(100) NOT NULL UNIQUE
  );

CREATE TABLE
  question_type (
    question_type_id int4 PRIMARY KEY NOT NULL,
    question_type varchar(10) NOT NULL UNIQUE
  );

CREATE TABLE
  enquete (
    enquete_id SERIAL PRIMARY KEY NOT NULL,
    enquete_name varchar(100),
    enquete_state_id int4 NOT NULL REFERENCES enquete_state (enquete_state_id),
    create_user_id varchar(6) NOT NULL,
    create_date timestamptz NOT NULL,
    start_date timestamptz,
    finish_date timestamptz,
    enquete_subtext varchar(200),
    version int4 NOT NULL,
    completion_message varchar(100) NOT NULL
  );

CREATE TABLE
  esq_user (
    esq_id varchar(6) PRIMARY KEY NOT NULL,
    dept_id int4 NOT NULL REFERENCES dept (dept_id),
    user_name varchar(100) NOT NULL,
    password varchar(128) NOT NULL
  );

CREATE TABLE
  question (
    question_id SERIAL PRIMARY KEY NOT NULL,
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    question_number int4 NOT NULL CHECK (question_number > 0),
    question_type_id int4 NOT NULL REFERENCES question_type (question_type_id),
    require_flag int4 NOT NULL CHECK (require_flag IN (0, 1)) DEFAULT 0,
    question_text varchar(100),
    question_subtext varchar(200),
    version int4 NOT NULL,
    max_selection int4 CHECK (max_selection > 0) DEFAULT 1,
    section_number int4 NOT NULL CHECK (section_number > 0) DEFAULT 1
  );

CREATE TABLE
  choice (
    choice_id SERIAL PRIMARY KEY NOT NULL,
    question_id int4 NOT NULL REFERENCES question (question_id),
    choice_number int4 NOT NULL CHECK (choice_number > 0),
    choice_text varchar(100) NOT NULL,
    version int4 NOT NULL
  );

CREATE TABLE
  enquete_admin_user (
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    esq_id varchar(6) NOT NULL REFERENCES esq_user (esq_id),
    delete_flag int4 NOT NULL CHECK (delete_flag IN (0, 1)) DEFAULT 0,
    PRIMARY KEY (enquete_id, esq_id)
  );

CREATE TABLE
  enquete_answer (
    enquete_answer_id SERIAL PRIMARY KEY NOT NULL,
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    esq_id varchar(6) NOT NULL REFERENCES esq_user (esq_id),
    answer_date timestamptz
  );

CREATE TABLE
  enquete_dept (
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    dept_id int4 NOT NULL REFERENCES dept (dept_id),
    PRIMARY KEY (enquete_id, dept_id)
  );

CREATE TABLE
  question_answer (
    question_answer_id SERIAL PRIMARY KEY NOT NULL,
    enquete_answer_id int4 NOT NULL REFERENCES enquete_answer (enquete_answer_id),
    question_id int4 NOT NULL REFERENCES question (question_id),
    answer_text varchar(200)
  );

CREATE TABLE
  choice_answer (
    choice_answer_id SERIAL PRIMARY KEY NOT NULL,
    question_answer_id int4 NOT NULL REFERENCES question_answer (question_answer_id),
    choice_id int4 NOT NULL REFERENCES choice (choice_id)
  );

CREATE TABLE
  teams (
    teams_id SERIAL PRIMARY KEY NOT NULL,
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    respon_start_flag int4 CHECK (respon_start_flag IN (0, 1)) DEFAULT 0,
    respon_finish_flag int4 CHECK (respon_finish_flag IN (0, 1)) DEFAULT 0,
    admin_start_flag int4 CHECK (admin_start_flag IN (0, 1)) DEFAULT 0,
    admin_finish_flag int4 CHECK (admin_finish_flag IN (0, 1)) DEFAULT 0,
    time_answer_flag int4 CHECK (time_answer_flag IN (0, 1)) DEFAULT 0,
    teams_channel int4 CHECK (teams_channel IN (0, 1)) DEFAULT 0
  );

-- 部署マスタ
INSERT INTO
  dept (dept_name)
VALUES
  ('総務部'),
  ('人事部'),
  ('開発部'),
  ('営業部'),
  ('企画部');

-- アンケート状態マスタ
INSERT INTO
  enquete_state (enquete_state)
VALUES
  ('公開前'),
  ('公開中'),
  ('終了');

-- 質問タイプマスタ
INSERT INTO
  question_type (question_type_id, question_type)
VALUES
  (1, '単一選択'),
  (2, '複数選択'),
  (3, '自由記述');

-- アンケート
INSERT INTO
  enquete (
    enquete_name,
    enquete_state_id,
    create_user_id,
    create_date,
    start_date,
    finish_date,
    enquete_subtext,
    version,
    completion_message
  )
VALUES
  (
    '社内満足度調査',
    1,
    'li0001',
    NOW (),
    NOW (),
    NOW () + interval '7 day',
    '会社全体の満足度を調査します。',
    1,
    'ご協力ありがとうございました！'
  ),
  (
    '新製品アイデア募集',
    1,
    'li0002',
    NOW (),
    NOW (),
    NOW () + interval '14 day',
    '自由なアイデアをお書きください。',
    1,
    'アイデア提供に感謝します！'
  ),
  (
    'リモートワーク環境アンケート',
    2,
    'li0003',
    NOW (),
    NOW () - interval '3 day',
    NOW () + interval '4 day',
    'リモートワークに関するご意見を伺います。',
    1,
    '回答ありがとうございます。'
  );

-- ユーザ
INSERT INTO
  esq_user (esq_id, dept_id, user_name, password)
VALUES
  (
    'li0001',
    1,
    '山田太郎',
    '$argon2id$v=19$m=4096,t=3,p=1$ZIbhZuKui9717yrS4SJvGw$Jw45XdOIphQF9elXUCd1a4Q1v4YsXrSKOXU3nf6T4ek'
  ),
  (
    'li0002',
    2,
    '佐藤花子',
    '$argon2id$v=19$m=4096,t=3,p=1$ZIbhZuKui9717yrS4SJvGw$Jw45XdOIphQF9elXUCd1a4Q1v4YsXrSKOXU3nf6T4ek'
  ),
  (
    'li0003',
    3,
    '鈴木一郎',
    '$argon2id$v=19$m=4096,t=3,p=1$ZIbhZuKui9717yrS4SJvGw$Jw45XdOIphQF9elXUCd1a4Q1v4YsXrSKOXU3nf6T4ek'
  ),
  (
    'li0004',
    4,
    '高橋美咲',
    '$argon2id$v=19$m=4096,t=3,p=1$ZIbhZuKui9717yrS4SJvGw$Jw45XdOIphQF9elXUCd1a4Q1v4YsXrSKOXU3nf6T4ek'
  ),
  (
    'li0005',
    5,
    '伊藤健',
    '$argon2id$v=19$m=4096,t=3,p=1$ZIbhZuKui9717yrS4SJvGw$Jw45XdOIphQF9elXUCd1a4Q1v4YsXrSKOXU3nf6T4ek'
  );

-- 質問
INSERT INTO
  question (
    enquete_id,
    question_number,
    question_type_id,
    require_flag,
    question_text,
    version,
    section_number
  )
VALUES
  (1, 1, 1, 1, '現在の職場環境に満足していますか？', 1, 1),
  (1, 2, 2, 1, '会社に改善してほしい点を選んでください。', 1, 1),
  (2, 1, 3, 0, '新製品のアイデアを自由に記入してください。', 1, 1),
  (3, 1, 1, 1, 'リモートワーク環境に満足していますか？', 1, 1);

-- 選択肢
INSERT INTO
  choice (question_id, choice_number, choice_text, version)
VALUES
  (1, 1, 'とても満足', 1),
  (1, 2, '満足', 1),
  (1, 3, '不満', 1),
  (2, 1, '給与', 1),
  (2, 2, '労働時間', 1),
  (2, 3, '福利厚生', 1),
  (2, 4, '評価制度', 1),
  (4, 1, 'とても満足', 1),
  (4, 2, 'まあまあ満足', 1),
  (4, 3, '不満', 1);

-- 管理ユーザ
INSERT INTO
  enquete_admin_user (enquete_id, esq_id, delete_flag)
VALUES
  (1, 'li0001', 0),
  (2, 'li0002', 0),
  (3, 'li0003', 0);

-- 回答（enquete_answer）
INSERT INTO
  enquete_answer (enquete_id, esq_id, answer_date)
VALUES
  (1, 'li0002', NOW () - interval '1 day'),
  (1, 'li0003', NOW () - interval '2 day'),
  (2, 'li0004', NOW () - interval '3 day'),
  (3, 'li0005', NOW () - interval '1 day');

-- 質問回答
INSERT INTO
  question_answer (enquete_answer_id, question_id, answer_text)
VALUES
  (1, 1, NULL),
  (1, 2, NULL),
  (2, 1, NULL),
  (3, 3, 'スマホアプリが欲しい'),
  (4, 4, NULL);

-- 選択肢回答
INSERT INTO
  choice_answer (question_answer_id, choice_id)
VALUES
  (1, 2),
  (2, 1),
  (2, 3),
  (3, 2),
  (5, 1);

-- アンケート対象部署
INSERT INTO
  enquete_dept (enquete_id, dept_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (3, 4),
  (3, 5);

-- Teams連携情報
INSERT INTO
  teams (
    enquete_id,
    respon_start_flag,
    respon_finish_flag,
    admin_start_flag,
    admin_finish_flag,
    time_answer_flag,
    teams_channel
  )
VALUES
  (1, 1, 0, 1, 0, 0, 1),
  (2, 0, 0, 1, 0, 0, 0),
  (3, 1, 1, 1, 1, 1, 1);