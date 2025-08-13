CREATE USER postgres
WITH
  PASSWORD 'password';

CREATE DATABASE postgres OWNER postgres;

-- choice: 選択肢
CREATE TABLE
  choice (
    choice_id SERIAL PRIMARY KEY NOT NULL,
    question_id int4 NOT NULL REFERENCES question (question_id),
    choice_number int4 NOT NULL CHECK (choice_number > 0),
    choice_text varchar(100) NOT NULL,
    version int4 NOT NULL,
  );

-- choice_answer: 選択肢回答
CREATE TABLE
  choice_answer (
    choice_answer_id SERIAL PRIMARY KEY NOT NULL,
    question_answer_id int4 NOT NULL REFERENCES question_answer (question_answer_id),
    choice_id int4 NOT NULL REFERENCES choice (choice_id),
  );

-- dept: 部署
CREATE TABLE
  dept (
    dept_id SERIAL PRIMARY KEY NOT NULL,
    dept_name varchar(100) NOT NULL UNIQUE,
  );

-- enquete: アンケート
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
    completion_message varchar(100) NOT NULL,
  );

-- enquete_admin_user: アンケート管理者
CREATE TABLE
  enquete_admin_user (
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    esq_id varchar(6) NOT NULL REFERENCES esq_user (esq_id),
    delete_flag int4 NOT NULL CHECK (delete_flag IN (0, 1)) DEFAULT 0,
    PRIMARY KEY (enquete_id, esq_id),
  );

-- enquete_answer: アンケート回答
CREATE TABLE
  enquete_answer (
    enquete_answer_id SERIAL PRIMARY KEY NOT NULL,
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    esq_id varchar(6) NOT NULL REFERENCES esq_user (esq_id),
    answer_date timestamptz,
  );

-- enquete_dept: アンケート回答対象の部署
CREATE TABLE
  enquete_dept (
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    dept_id int4 NOT NULL REFERENCES dept (dept_id),
    PRIMARY KEY (enquete_id, dept_id),
  );

-- enquete_state: アンケート状態
CREATE TABLE
  enquete_state (
    enquete_state_id SERIAL PRIMARY KEY NOT NULL,
    enquete_state varchar(100) NOT NULL UNIQUE,
  );

-- esq_user: ユーザー
CREATE TABLE
  esq_user (
    esq_id varchar(6) PRIMARY KEY NOT NULL,
    dept_id int4 NOT NULL REFERENCES dept (dept_id),
    user_name varchar(100) NOT NULL,
    password varchar(128) NOT NULL,
  );

-- question: 質問
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
    section_number int4 NOT NULL CHECK (section_number > 0) DEFAULT 1,
  );

-- question_answer: 質問回答
CREATE TABLE
  question_answer (
    question_answer_id SERIAL PRIMARY KEY NOT NULL,
    enquete_answer_id int4 NOT NULL REFERENCES enquete_answer (enquete_answer_id),
    question_id int4 NOT NULL REFERENCES question (question_id),
    answer_text varchar(200),
  );

-- question_type: 質問タイプ
CREATE TABLE
  question_type (
    question_type_id int4 PRIMARY KEY NOT NULL,
    question_type varchar(10) NOT NULL UNIQUE,
  );

-- teams: microsoft Teams通知用
CREATE TABLE
  teams (
    teams_id SERIAL PRIMARY KEY NOT NULL,
    enquete_id int4 NOT NULL REFERENCES enquete (enquete_id),
    respon_start_flag int4 CHECK (respon_start_flag IN (0, 1)) DEFAULT 0,
    respon_finish_flag int4 CHECK (respon_finish_flag IN (0, 1)) DEFAULT 0,
    admin_start_flag int4 CHECK (admin_start_flag IN (0, 1)) DEFAULT 0,
    admin_finish_flag int4 CHECK (admin_finish_flag IN (0, 1)) DEFAULT 0,
    time_answer_flag int4 CHECK (time_answer_flag IN (0, 1)) DEFAULT 0,
    teams_channel int4 CHECK (teams_channel IN (0, 1)) DEFAULT 0,
  );

-- 初期データの流し込み