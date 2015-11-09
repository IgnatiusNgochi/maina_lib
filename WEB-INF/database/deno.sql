CREATE TABLE Roles(
id              serial primary key,
role_id 	int ,
role_name 	varchar,
role_details	text
);

CREATE TABLE Users(
User_id 	serial primary key,
User_username 	character varying(30),
User_password 	character varying(50),
User_name 	character varying(50),
User_reg_no 	int not null,
User_age	int not null,
role_id         int references Roles,
User_telephone 	int,
User_email 	character varying(30),
User_gender	boolean,
User_course_id 	character varying(30)
);

CREATE TABLE courses(
course_id 		serial primary key,
course_name     	character varying(30),
course_description 	character varying(30),
User_reg_no 		int references Users,
course_date_setup 	date,
course_details 		text
);

CREATE TABLE timetable(
timetable_id   		serial primary key,
course_id     		int references courses,
timetable_start_time 	time,
end_time 		time,
timetable_venue 	character varying(30),
timetable_instructor    character varying(35)
);



