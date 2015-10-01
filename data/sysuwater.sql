drop database if exists `sysuwater`;

create database `sysuwater`
	default character set utf8
	default collate utf8_general_ci;

use sysuwater;

drop table if exists `users`;
CREATE TABLE users
(
	`user_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`username` VARCHAR(128) NOT NULL comment '�û���',
	`sex` tinyint NOT NULL comment '�Ա�',
	`nickname` VARCHAR(128) NULL comment '�ǳ�',
	`password` VARCHAR(128) NOT NULL comment '����',
	`email` VARCHAR(128) NULL comment '����',
	`signature` VARCHAR(256) NULL comment 'ǩ��',
	`score` INTEGER not NULL comment '�û�����',
	`login_time` INTEGER not null comment '�����¼ʱ��',
	unique key(`username`),
	primary key (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='�û���';

drop table if exists `plate`;
CREATE TABLE `plate`
(
	`p_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
    `pname` varchar(32) not null comment '�������',
	primary key (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='��̳����';

drop table if exists `post`;
CREATE TABLE post
(
	`post_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`title` VARCHAR(128) NOT NULL comment '����',
	`content` TEXT NOT NULL comment '��������',
	`create_time` INTEGER not null comment '����ʱ��',
	`author_id` INTEGER NOT NULL comment '����',
	`is_delete` TINYINT NOT NULL DEFAULT 0 comment '�Ƿ�ɾ��',
	`p_id` INTEGER NOT NULL comment '�����γ�',
	CONSTRAINT `post_ibfk_1` FOREIGN KEY (author_id)
		REFERENCES users(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `post_ibfk_2` FOREIGN KEY (`p_id`)
		REFERENCES `plate` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='���ӱ�';

drop table if exists `comments`;
CREATE TABLE `comments`
(
	`com_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`content` TEXT NOT NULL comment '��������',
	`create_time` INTEGER not NULL comment '����ʱ��',
	`author_id` INTEGER NOT NULL comment '������',
	`post_id` INTEGER NOT NULL comment '�ظ�����ID',
	CONSTRAINT `com_ibfk_1` FOREIGN KEY (`author_id`)
		REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `com_ibfk_2` FOREIGN KEY (`post_id`)
		REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`com_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='���۱�';

