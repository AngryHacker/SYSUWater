drop database if exists `sysuwater`;

create database `sysuwater`
	default character set utf8
	default collate utf8_general_ci;

use sysuwater;

drop table if exists `users`;
CREATE TABLE users
(
	`user_id` INTEGER NOT NULL AUTO_INCREMENT comment '主键',
	`username` VARCHAR(128) NOT NULL comment '用户名',
	`sex` tinyint NOT NULL comment '性别',
	`nickname` VARCHAR(128) NULL comment '昵称',
	`password` VARCHAR(128) NOT NULL comment '密码',
	`email` VARCHAR(128) NULL comment '邮箱',
	`signature` VARCHAR(256) NULL comment '签名',
	`score` INTEGER not NULL comment '用户积分',
	`login_time` INTEGER not null comment '最近登录时间',
	unique key(`username`),
	primary key (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='用户表';

drop table if exists `plate`;
CREATE TABLE `plate`
(
	`p_id` INTEGER NOT NULL AUTO_INCREMENT comment '主键',
    `pname` varchar(32) not null comment '版块名称',
	primary key (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='论坛版块表';

drop table if exists `post`;
CREATE TABLE post
(
	`post_id` INTEGER NOT NULL AUTO_INCREMENT comment '主键',
	`title` VARCHAR(128) NOT NULL comment '标题',
	`content` TEXT NOT NULL comment '帖子内容',
	`create_time` INTEGER not null comment '创建时间',
	`author_id` INTEGER NOT NULL comment '作者',
	`is_delete` TINYINT NOT NULL DEFAULT 0 comment '是否删除',
	`p_id` INTEGER NOT NULL comment '关联课程',
	CONSTRAINT `post_ibfk_1` FOREIGN KEY (author_id)
		REFERENCES users(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `post_ibfk_2` FOREIGN KEY (`p_id`)
		REFERENCES `plate` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='帖子表';

drop table if exists `comments`;
CREATE TABLE `comments`
(
	`com_id` INTEGER NOT NULL AUTO_INCREMENT comment '主键',
	`content` TEXT NOT NULL comment '评论内容',
	`create_time` INTEGER not NULL comment '评论时间',
	`author_id` INTEGER NOT NULL comment '评论者',
	`post_id` INTEGER NOT NULL comment '回复帖子ID',
	CONSTRAINT `com_ibfk_1` FOREIGN KEY (`author_id`)
		REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `com_ibfk_2` FOREIGN KEY (`post_id`)
		REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`com_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='评论表';

