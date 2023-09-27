-- Create Database Scheme
CREATE DATABASE IF NOT EXISTS todo_db;

-- Create User
CREATE USER IF NOT EXISTS 'todo_user'@'%' IDENTIFIED BY 'todo_user';
GRANT ALL PRIVILEGES ON todo_db.* TO 'todo_user'@'%';
FLUSH PRIVILEGES;

USE todo_db;

-- Create Table
CREATE TABLE IF NOT EXISTS user (
	USERNAME VARCHAR(255) PRIMARY KEY NOT NULL,
	PASSWORD VARCHAR(100),
	FULL_NAME VARCHAR(255),
	USER_STATUS VARCHAR(100) NOT NULL DEFAULT 'A',
	MODIFIED INT NOT NULL DEFAULT 0,
	CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	UPDATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS user_attribute (
	USERNAME VARCHAR(255) PRIMARY KEY NOT NULL,
	PROVIDER VARCHAR(50) NOT NULL,
	MODIFIED INT NOT NULL DEFAULT 0,
	CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	UPDATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	
	CONSTRAINT `fk_user_attribute_username` FOREIGN KEY (USERNAME) REFERENCES user (USERNAME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS todo_item_category (
	ITEM_CATEGORY_ID BIGINT PRIMARY KEY NOT NULL,
	USERNAME VARCHAR(255) NOT NULL,
	ITEM_CATEGORY_NAME VARCHAR(100) NOT NULL,
	ITEM_CATEGORY_STATUS VARCHAR(100) NOT NULL,
	MODIFIED INT NOT NULL DEFAULT 0,
	CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	UPDATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	
	CONSTRAINT `fk_todo_item_category_username` FOREIGN KEY (USERNAME) REFERENCES user (USERNAME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS todo_item (
	ITEM_ID BIGINT PRIMARY KEY NOT NULL,
	USERNAME VARCHAR(255) NOT NULL,
	ITEM_CATEGORY_ID BIGINT,
	ITEM_TITLE VARCHAR(100) NOT NULL,
	ITEM_DESC TEXT,
	ITEM_STATUS VARCHAR(100) NOT NULL DEFAULT 'I',
	MODIFIED INT NOT NULL DEFAULT 0,
	CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	UPDATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	
	CONSTRAINT `fk_todo_item_username` FOREIGN KEY (USERNAME) REFERENCES user (USERNAME) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_todo_item_category_item_category_id` FOREIGN KEY (ITEM_CATEGORY_ID) REFERENCES todo_item_category (ITEM_CATEGORY_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexing
CREATE INDEX todo_item_name_idx ON todo_item(ITEM_TITLE);
CREATE INDEX todo_item_status_idx ON todo_item(ITEM_STATUS);
CREATE INDEX todo_item_created_at_idx ON todo_item(CREATED_AT);