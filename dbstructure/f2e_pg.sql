/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost
 Source Database       : f2e

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : utf-8

 Date: 01/02/2013 18:26:36 PM
*/

-- ----------------------------
--  Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS favorite;

CREATE SEQUENCE favorite_id_seq
    START WITH 20;

CREATE TABLE favorite (
  id INT NOT NULL DEFAULT nextval('favorite_id_seq'),
  owner_user_id INT DEFAULT NULL,
  involved_type INT DEFAULT NULL,
  involved_topic_id INT DEFAULT NULL,
  involved_reply_id INT DEFAULT NULL,
  created TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE favorite_id_seq OWNED BY favorite.id;

-- ----------------------------
--  Table structure for node
-- ----------------------------
DROP TABLE IF EXISTS node;

CREATE SEQUENCE node_id_seq
    START WITH 41;

CREATE TABLE node (
  id INT NOT NULL DEFAULT nextval('node_id_seq'),
  name text,
  slug text,
  thumb text,
  introduction text,
  created text,
  updated text,
  plane_id INT DEFAULT NULL,
  topic_count INT DEFAULT NULL,
  custom_style text,
  limit_reputation INT DEFAULT NULL,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE node_id_seq OWNED BY node.id;

-- ----------------------------
--  Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS notification;

CREATE SEQUENCE notification_id_seq
    START WITH 255;

CREATE TABLE notification (
  id INT NOT NULL DEFAULT nextval('notification_id_seq'),
  content text,
  status INT DEFAULT NULL,
  involved_type INT DEFAULT NULL,
  involved_user_id INT DEFAULT NULL,
  involved_topic_id INT DEFAULT NULL,
  involved_reply_id INT DEFAULT NULL,
  trigger_user_id INT DEFAULT NULL,
  occurrence_time TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE notification_id_seq OWNED BY notification.id;

-- ----------------------------
--  Table structure for plane
-- ----------------------------
DROP TABLE IF EXISTS plane;

CREATE SEQUENCE plane_id_seq
    START WITH 9;

CREATE TABLE plane (
  id INT NOT NULL DEFAULT nextval('plane_id_seq'),
  name text,
  created text,
  updated text,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE plane_id_seq OWNED BY plane.id;

-- ----------------------------
--  Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS reply;

CREATE SEQUENCE reply_id_seq
    START WITH 181;

CREATE TABLE reply (
  id INT NOT NULL DEFAULT nextval('reply_id_seq'),
  topic_id INT DEFAULT NULL,
  author_id INT DEFAULT NULL,
  content text,
  created TIMESTAMP DEFAULT NULL,
  updated TIMESTAMP DEFAULT NULL,
  up_vote INT DEFAULT NULL,
  down_vote INT DEFAULT NULL,
  last_touched TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE reply_id_seq OWNED BY reply.id;

-- ----------------------------
--  Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS topic;

CREATE SEQUENCE topic_id_seq
    START WITH 24;

CREATE TABLE topic (
  id INT NOT NULL DEFAULT nextval('topic_id_seq'),
  title text,
  content text,
  status INT DEFAULT NULL,
  hits INT DEFAULT NULL,
  created TIMESTAMP DEFAULT NULL,
  updated TIMESTAMP DEFAULT NULL,
  node_id INT DEFAULT NULL,
  author_id INT DEFAULT NULL,
  reply_count INT DEFAULT NULL,
  last_replied_by INT,
  last_replied_time TIMESTAMP DEFAULT NULL,
  up_vote INT DEFAULT NULL,
  down_vote INT DEFAULT NULL,
  last_touched TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE topic_id_seq OWNED BY topic.id;


CREATE OR REPLACE FUNCTION topic_delete() RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM reply WHERE reply.topic_id = OLD.id;
  DELETE FROM notification WHERE notification.involved_topic_id = OLD.id;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER topic_delete_trigger BEFORE DELETE ON topic FOR EACH ROW 
EXECUTE PROCEDURE topic_delete ();

-- ----------------------------
--  Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS transaction;

CREATE SEQUENCE transaction_id_seq;

CREATE TABLE transaction (
  id INT NOT NULL DEFAULT nextval('transaction_id_seq'),
  type INT DEFAULT NULL,
  reward INT DEFAULT NULL,
  user_id INT DEFAULT NULL,
  current_balance INT DEFAULT NULL,
  involved_user_id INT DEFAULT NULL,
  involved_topic_id INT DEFAULT NULL,
  involved_reply_id INT DEFAULT NULL,
  occurrence_time text,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE transaction_id_seq OWNED BY transaction.id;

-- ----------------------------
--  Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS users;

CREATE SEQUENCE users_id_seq
    START WITH 169;

CREATE TABLE users (
  uid INT NOT NULL DEFAULT nextval('users_id_seq'),
  email text,
  password text,
  username text,
  nickname text,
  avatar text,
  signature text,
  location text,
  website text,
  company text,
  role INT DEFAULT NULL,
  balance INT DEFAULT NULL,
  reputation INT DEFAULT NULL,
  self_intro text,
  created TIMESTAMP DEFAULT NULL,
  updated TIMESTAMP DEFAULT NULL,
  twitter text,
  github text,
  douban text,
  last_login TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (uid)
) ;

ALTER SEQUENCE users_id_seq OWNED BY users.uid;


CREATE OR REPLACE FUNCTION user_delete() RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM topic WHERE topic.author_id = OLD.uid;
  DELETE FROM reply WHERE reply.author_id = OLD.uid;
  DELETE FROM notification WHERE notification.trigger_user_id = OLD.uid;
  DELETE FROM notification WHERE notification.involved_user_id = OLD.uid;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_delete_trigger BEFORE DELETE ON topic FOR EACH ROW 
EXECUTE PROCEDURE user_delete ();

-- ----------------------------
--  Table structure for vote
-- ----------------------------
DROP TABLE IF EXISTS vote;

CREATE SEQUENCE vote_id_seq
    START WITH 9;

CREATE TABLE vote (
  id INT NOT NULL DEFAULT nextval('vote_id_seq'),
  status INT DEFAULT NULL,
  involved_type INT DEFAULT NULL,
  involved_user_id INT DEFAULT NULL,
  involved_topic_id INT DEFAULT NULL,
  involved_reply_id INT DEFAULT NULL,
  trigger_user_id INT DEFAULT NULL,
  occurrence_time TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (id)
) ;

ALTER SEQUENCE vote_id_seq OWNED BY vote.id;
