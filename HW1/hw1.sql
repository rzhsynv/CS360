-- Active: 1631263300773@@127.0.0.1@3306@ hw1
-- -----------------------------------------------------
-- Schema  hw1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS  hw1;

-- -----------------------------------------------------
-- Schema  hw1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS  hw1 DEFAULT CHARACTER SET utf8 ;
USE  hw1;

-- -----------------------------------------------------
-- Table ` hw1`.`STUDENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS  hw1.STUDENT ;

CREATE TABLE IF NOT EXISTS  hw1.STUDENT (
  `studentID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `deptName` VARCHAR(10) NOT NULL,
  `CGPA` FLOAT NOT NULL,
  `MentorID` INT,
  PRIMARY KEY (`studentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ` hw1`.`INSTRUCTOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS  hw1.INSTRUCTOR ;

CREATE TABLE IF NOT EXISTS  hw1.INSTRUCTOR(
  `instructorID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `deptName` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`instructorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ` hw1`.`COURSE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS  hw1.COURSE;

CREATE TABLE IF NOT EXISTS  hw1.COURSE(
  `courseID` VARCHAR(7) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `deptName` VARCHAR(10) NOT NULL,
  `credits` INT NOT NULL,
  PRIMARY KEY (`courseID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ` hw1`.`TAKES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS  hw1.TAKES;

CREATE TABLE IF NOT EXISTS  hw1.TAKES(
  `semester` VARCHAR(10) NOT NULL,
  `studentID` INT NOT NULL,
  `courseID` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`studentID`, `courseID`, `semester`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ` hw1`.`TEACHES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS  hw1.TEACHES;

CREATE TABLE IF NOT EXISTS  hw1.TEACHES(
  `semester` VARCHAR(10) NOT NULL,
  `courseID` VARCHAR(7) NOT NULL,
  `instructorID` INT NOT NULL,
  PRIMARY KEY (`semester`, `courseID`, `instructorID`))
ENGINE = InnoDB;

INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (1001, "Jang, Young Min", "HSS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (1002, "Kim, Do Min", "HSS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (3001, "Park, Taesu", "CS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (3002, "Kim, Chul Hwan", "CS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (3003, "Han, Yang Soo", "CS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (3004, "Choi, Jin Young", "CS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (3005, "Choi, Jung Wook", "CS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (4001, "Choi, Jin Young", "EE");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (4002, "Ahn, Tae Hwan", "EE");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (4003, "Kim, Jiwon", "EE");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (5001, "Kim Yoon Hwan", "BIS");
INSERT INTO  hw1.INSTRUCTOR (instructorID, name, deptName) VALUES (5002, "Ha, Taewook", "BIS");

INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("CS101", "Introduction to Programming", "CS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("CS230", "System Programming", "CS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("CS206", "Data Structure", "CS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("CS360", "Introduction to Database", "CS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("CS380", "Introduction to Computer Graphics", "CS", 4);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("EE201", "Circuit Theory", "EE", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("EE303", "Digital System Design", "EE", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("EE485", "Special Topics in Electronic Engineering", "EE", 1);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("BIS301", "Bioengineering Laboratory I ", "BIS", 4);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("BIS332", "Bio-Information Processing", "BIS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("HSS090", "Happy College Life", "HSS", 1);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("HSS586", "Korean1 for graduate international students", "HSS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("HSS587", "Korean2 for graduate international students", "HSS", 3);
INSERT INTO  hw1.COURSE (courseID, title, deptName, credits) VALUES ("CS496", "Immersion Camp", "CS", 1);

INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20180001, "Kim, Chul Soo", "CS", 2.89, 20180001);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20180002, "Lee, Young Ja", "EE", 3.75, 20180002);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20180003, "Park, Young Min", "BIS",3.61, 20180003);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20180004, "Kim, Seong Hwan", "EE", 4.01, 20180004);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20190001, "Lee, Bong Soon", "CS", 3.54, 20180003);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20190002, "Kim, Young Soo", "CS", 3.46, 20180004);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20190003, "Choi, Yunho", "EE", 2.17, 20180002);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20190004, "Lee, Sujin", "CS", 2.96, 20180001);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20200001, "Cho, Kwang Soo", "BIS", 3.04, 20180003);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20200002, "Lee, Soon Ja", "EE", 3.77, 20190003);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20200003, "Choi, Young Sik", "CS", 3.76, 20190001);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20210001, "Park, Young Soon", "CS",  4.15, 20200003);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20210002, "Jeong, Sang Soo", "EE", 3.59, 20190004);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20210003, "Kim, Seung Jae", "BIS", 1.99, 20200001);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20210004, "Park, Sang Hyun", "CS", 2.79, 20200002);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20220001, "Park, Young Soon", "FRESH", 3.13, 20210003);
INSERT INTO  hw1.STUDENT (studentID, name, deptName, CGPA, MentorID) VALUES (20220002, "Jeong, Sang Soo", "FRESH", 3.40, 20210004);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'CS101', 3002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'CS230', 3003);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'CS206', 3004);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'CS360', 3005);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'EE201', 4001);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'EE303', 4002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'EE485', 4002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'BIS301', 5001);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'BIS332', 5002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Spring', 'HSS090', 4003);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Summer', 'CS496', 3002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Summer', 'HSS586', 1002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Summer', 'HSS587', 1001);

INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'CS101', 3002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'CS230', 3001);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'CS360', 3005);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'CS380', 3003);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'EE201', 4002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'EE303', 4001);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'EE485', 4003);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'BIS301', 5002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'BIS332', 5001);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Fall', 'HSS090', 3004);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Winter', 'CS496', 3003);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Winter', 'HSS586', 1002);
INSERT INTO  hw1.TEACHES (semester, courseID, instructorID) VALUES ('Winter', 'HSS587', 1001);