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
	`grade` VARCHAR(32) NOT NULL comment '�꼶',
	`nickname` VARCHAR(128) NULL comment '�ǳ�',
	`password` VARCHAR(128) NOT NULL comment '����',
    `major` varchar(32) null comment 'רҵ����',
    `school` varchar(32) null comment '����ѧԺ',
    `number` varchar(32) not null comment 'ѧ��',
	`email` VARCHAR(128) NULL comment '����',
	`mail` VARCHAR(128) NULL comment '�ʱ�',
	`call` VARCHAR(128) NULL comment '��ϵ�绰',
	`signature` VARCHAR(256) NULL comment 'ǩ��',
	`pre_school` VARCHAR(256) NULL comment 'ԭѧУ',
	`address` VARCHAR(256) NULL comment '��ַ',
	`detail_address` VARCHAR(512) NULL comment '��ϸ��ַ',
	`pic_url` VARCHAR(256) NULL comment 'ͷ������',
	`score` INTEGER not NULL comment '�û�����',
	`rank` INTEGER not NULL comment '�û��ȼ�',
	`login_time` INTEGER not null comment '�����¼ʱ��',
	`cookie` VARCHAR(1024) NULL comment 'cookie',
	unique key(`username`),
	primary key (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='ѧ����';

drop table if exists `teacher`;
CREATE TABLE `teacher`
(
	`tea_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
    `tea_name` varchar(512) not null comment '����',
    `school` varchar(512) null comment '����ѧԺ',
	`sex` VARCHAR(16) NULL comment '�Ա�',
	`score` INTEGER NOT NULL comment '���۷���',
	primary key (`tea_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='��ʦ��';

drop table if exists `course`;
CREATE TABLE `course`
(
	`cou_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
    `resourceID` varchar(32) not null comment '�γ�resourceID',
    `course_name` varchar(512) not null comment '�γ�����',
    `time` varchar(1024) not null comment '�Ͽ�ʱ��',
    `tea_id` INTEGER not null comment '�ڿ���ʦ',
	CONSTRAINT `cou_ibfk_1` FOREIGN KEY (`tea_id`)
		REFERENCES `teacher` (`tea_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`cou_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='�γ̱�';

drop table if exists `stu_course`;
CREATE TABLE `stu_course`
(
	`sc_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
    `stu_id` INTEGER not null comment '�γ�ID',
    `cou_id` INTEGER not null comment 'ѧ��ID',
	CONSTRAINT `sc_ibfk_1` FOREIGN KEY (`cou_id`)
		REFERENCES `course` (`cou_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `sc_ibfk_2` FOREIGN KEY (`stu_id`)
		REFERENCES `student` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`sc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='ѧ��-�γ̱�';

drop table if exists `friend`;
CREATE TABLE `friend`
(
	`fr_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
    `stu1` INTEGER not null comment 'ѧ��1',
    `stu2` INTEGER not null comment 'ѧ��2',
	CONSTRAINT `fr_ibfk_1` FOREIGN KEY (`stu1`)
		REFERENCES `student` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fr_ibfk_2` FOREIGN KEY (`stu2`)
		REFERENCES `student` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`fr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='���ѹ�ϵ��';

drop table if exists `post`;
CREATE TABLE post
(
	`post_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`title` VARCHAR(128) NOT NULL comment '����',
	`content` TEXT NOT NULL comment '��������',
	`tags` TEXT NULL comment '��ǩ',
	`status` INTEGER NOT NULL default 0 comment '״̬��0 = �ݸ壬1 = ����',
	`is_name` tinyint NOT NULL default 0 comment '�Ƿ�������0 = ��1 = ��',
	`create_time` INTEGER not null comment '����ʱ��',
	`author_id` INTEGER NOT NULL comment '����',
	`cou_id` INTEGER NOT NULL comment '�����γ�',
	CONSTRAINT `post_ibfk_1` FOREIGN KEY (author_id)
		REFERENCES student(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `post_ibfk_2` FOREIGN KEY (`cou_id`)
		REFERENCES `course` (`cou_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='��־��';

drop table if exists `comments`;
CREATE TABLE `comments`
(
	`com_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`content` TEXT NOT NULL comment '��������',
	`create_time` INTEGER not NULL comment '����ʱ��',
	`author_id` INTEGER NOT NULL comment '������',
	`post_id` INTEGER NOT NULL comment '�ظ�����ID',
	CONSTRAINT `com_ibfk_1` FOREIGN KEY (`author_id`)
		REFERENCES `student` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `com_ibfk_2` FOREIGN KEY (`post_id`)
		REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`com_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='���۱�';

drop table if exists `message`;
CREATE TABLE `message`
(
	`me_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`fr_id` INTEGER NOT NULL comment '��Ӧ���Ѷ�',
	`content` VARCHAR(1024) NOT NULL comment '��Ϣ����',
	`send_time` INTEGER not NULL comment '����ʱ��',
	CONSTRAINT `me_ibfk_1` FOREIGN KEY (`fr_id`)
		REFERENCES `friend` (`fr_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (`me_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='���Ѽ���Ϣ��';

drop table if exists `Error`;
CREATE TABLE `Error`
(
	`er_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`user_id` VARCHAR(124) NOT NULL comment '�û� ID',
	`psw` VARCHAR(124) NOT NULL comment '����',
	primary key (`er_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='��¼�����';

drop table if exists `score`;
CREATE TABLE `score`
(
	`sc_id` INTEGER NOT NULL AUTO_INCREMENT comment '����',
	`num` VARCHAR(124) NOT NULL comment '���ַ���',
	`time` date NOT NULL comment '��������',
	primary key (`er_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='�û����ֱ�';

