create table USER(
	userID varchar(20),
	userPassword varchar(64),
	userEmail varchar(50),
	useremailHash varchar(64),
	userEmailChecked boolean
);

alter table user add primary key (userID);

create table EVALUATION(
	evaluationID int primary key auto_increment,
	userID varchar(20),
	lectureName varchar(50),
	professorName varchar(20),
	lectureYear int,
	semesterDivide varchar(20),
	lectureDivide varchar(10),
	evaluationTitle varchar(50),
	evaluationContent varchar(2048),
	totalScore varchar(5),
	creditScore varchar(5),
	comfortableScore varchar(5),
	lectureScore varchar(5),
	likeCount int
);

create table LIKEY(
	userID varchar(20),
	evaluationID int,
	userIP varchar(50)
);
