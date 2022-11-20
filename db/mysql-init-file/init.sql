create user 'tester'@'%' identified with mysql_native_password by 'password';
grant all privileges on *.* to 'tester'@'%';
flush privileges;

CREATE DATABASE db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use db;

CREATE TABLE `students` (
                            `student_id`	INT(9)	NOT NULL,
                            `email`	VARCHAR(15)	NOT NULL,
                            `password`	VARCHAR(20)	NOT NULL,
                            `name`	VARCHAR(15)	NOT NULL,
                            `grade`	INT(1)	NOT NULL,
                            `credits`	INT(2)	NULL	DEFAULT 0
);

CREATE TABLE `course` (
                          `course_id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          `target_grade`	INT(1)	NOT NULL,
                          `credit`	INT(1)	NOT NULL,
                          `name`	VARCHAR(20)	NOT NULL,
                          `class_number`	INT(1)	NOT NULL,
                          `professor`	VARCHAR(20)	NOT NULL,
                          `capacity`	INT(2)	NOT NULL
);

CREATE TABLE `register_course` (
                                   `course_id`	BIGINT	NOT NULL,
                                   `student_id`	INT(9)	NOT NULL
);

CREATE TABLE `places` (
                          `place_id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          `name`	VARCHAR(20)	NOT NULL
);

CREATE TABLE `course_and_place` (
                                    `course_id`	BIGINT	NOT NULL,
                                    `place_id`	BIGINT	NOT NULL,
                                    `start_time`	TIME	NOT NULL,
                                    `end_time`	TIME	NOT NULL
);

CREATE TABLE `administrator` (
                                 `administrator_id`	INT(9)	NOT NULL,
                                 `password`	VARCHAR(20)	NOT NULL
);

ALTER TABLE `students` ADD CONSTRAINT `PK_STUDENTS` PRIMARY KEY (
                                                                 `student_id`
    );

ALTER TABLE `register_course` ADD CONSTRAINT `PK_REGISTER_COURSE` PRIMARY KEY (
                                                                               `course_id`,
                                                                               `student_id`
    );

ALTER TABLE `course_and_place` ADD CONSTRAINT `PK_COURSE_AND_PLACE` PRIMARY KEY (
                                                                                 `course_id`,
                                                                                 `place_id`
    );

ALTER TABLE `administrator` ADD CONSTRAINT `PK_ADMINISTRATOR` PRIMARY KEY (
                                                                           `administrator_id`
    );

ALTER TABLE `register_course` ADD CONSTRAINT `FK_course_TO_register_course_1` FOREIGN KEY (
                                                                                           `course_id`
    )
    REFERENCES `course` (
                         `course_id`
        );

ALTER TABLE `register_course` ADD CONSTRAINT `FK_students_TO_register_course_1` FOREIGN KEY (
                                                                                             `student_id`
    )
    REFERENCES `students` (
                           `student_id`
        );

ALTER TABLE `course_and_place` ADD CONSTRAINT `FK_course_TO_course_and_place_1` FOREIGN KEY (
                                                                                             `course_id`
    )
    REFERENCES `course` (
                         `course_id`
        );

ALTER TABLE `course_and_place` ADD CONSTRAINT `FK_places_TO_course_and_place_1` FOREIGN KEY (
                                                                                             `place_id`
    )
    REFERENCES `places` (
                         `place_id`
        );

