CREATE TABLE PROFESSOR(
	Prof_id VARCHAR(5) PRIMARY KEY CHECK (LENGTH(Prof_id)=5),
	Prof_name VARCHAR(20) NOT NULL, 
	Email VARCHAR(20) UNIQUE CHECK (Email LIKE '%@%.%') not null, 
	Mobile VARCHAR(10) UNIQUE CHECK (LENGTH(Mobile)=10) not null, 
	Speciality VARCHAR(10), Dept_id VARCHAR(5) 
);


CREATE TABLE SCHOOL( 
    SCode VARCHAR(5) PRIMARY KEY, 
	Scl_name VARCHAR(20) Not null,
    Prof_id VARCHAR(5), 
	Location VARCHAR(20), 
	
	FOREIGN KEY (Prof_id) 
	references PROFESSOR(Prof_id) on delete set null );

CREATE TABLE DEPARTMENT(
	Dept_id VARCHAR(5)PRIMARY KEY, 
	Dname VARCHAR(20) NOT NULL,
    SCode VARCHAR(5), 
	Prof_id VARCHAR(5), 
	
	FOREIGN KEY (SCode) 
	references SCHOOL (SCode) on delete cascade,
	
	FOREIGN KEY (Prof_id) 
	references PROFESSOR (Prof_id) on delete set null );

CREATE TABLE COURSE( 
	Crs_name VARCHAR(20) NOT NULL, 
	Crs_code VARCHAR(5) PRIMARY KEY,
    Description VARCHAR(100), 
	Credits INT NOT NULL, 
	Hours INT );

CREATE TABLE SEMESTER ( 
	Sem_code VARCHAR(5) PRIMARY KEY CHECK (Sem_code LIKE 'Win%' or
    Sem_code LIKE 'Fall%'), 
	Term VARCHAR(10) CHECK (Term IN ('Winter', 'Fall')) NOT NULL, 
	Year INT check (Year>1000 and Year<=9999), 
	Sdate DATE, Edate DATE );

CREATE TABLE CLASS( 
	Cls_code VARCHAR(5) PRIMARY KEY, 
	Slot VARCHAR(10) NOT NULL, 
	Stime TIMESTAMP(0), 
	Etime TIMESTAMP(0), 
	Crs_code VARCHAR(5), 
	Prof_id VARCHAR(5), 
	Room_no INT NOT NULL, 
	Sem_code VARCHAR(5), 
	Day_of_week VARCHAR(3) 
	check (Day_of_week in('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')), 
	
	FOREIGN KEY (Prof_id) 
	references PROFESSOR(Prof_id) on delete set null, 
	
	FOREIGN KEY (Sem_code) 
	references SEMESTER ( Sem_code) on delete set null, 
	
	FOREIGN KEY (Crs_code)
	references COURSE (Crs_code) on delete cascade );


CREATE TABLE STUDENT ( 
	Reg_no VARCHAR(5) PRIMARY KEY CHECK (LENGTH (Reg_no) = 5),
    Sname VARCHAR(20) NOT NULL, 
	Address VARCHAR(40) NOT NULL, 
	DOB DATE not null, 
	Email VARCHAR(20) UNIQUE CHECK (Email LIKE '%@%.%'), 
	Mobile VARCHAR(10) UNIQUE CHECK (LENGTH (Mobile) = 10), 
	Dept_id VARCHAR(5), 
	Prof_id VARCHAR(5), 
	
	FOREIGN KEY (Prof_id) 
	references PROFESSOR (Prof_id) on delete set null, 
	
	FOREIGN KEY (Dept_id) 
	references DEPARTMENT(Dept_id) on delete set null );

CREATE TABLE ENROLL( 
	Cls_code VARCHAR(5), 
    Reg_no VARCHAR(5), 
	Enroll_time TIMESTAMP (0),
    Grade VARCHAR(1) CHECK (Grade in ('S', 'A','B', 'C','D', 'E','F')), 
	PRIMARY KEY (Cls_code, Reg_no),
    
	FOREIGN KEY (Cls_code) 
	references CLASS (Cls_code) on delete set null, 
	
	FOREIGN KEY (Reg_no)
    references STUDENT (Reg_no) on delete cascade );


CREATE TABLE STUDENT_VISA ( 
	Reg_no VARCHAR(5) CHECK (LENGTH (Reg_no) = 5), 
	Visa_status VARCHAR(20) CHECK (Visa_status in('APPROVED', 'REJECTED', 'EXPIRED', 'PENDING', 'ISSUED')),
    
	FOREIGN KEY (Reg_no) 
	references STUDENT (Reg_no) on delete cascade );

CREATE TABLE PROGRAMME ( 
	Prog_code VARCHAR(5) PRIMARY KEY, 
	Prog_name VARCHAR(20) NOT NULL, 
	Prog_preamble VARCHAR(30), 
	SCode VARCHAR(5), 
	Dept_id VARCHAR(5), 
	FOREIGN KEY(SCode) 
	references SCHOOL (SCode) on delete cascade, 
	FOREIGN KEY (Dept_id) 
	references DEPARTMENT (Dept_id) on delete cascade );
	
	
