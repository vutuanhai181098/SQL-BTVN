create database techmaster;

use techmaster;

create table tbl_role (
	id int primary key auto_increment,
    keyy varchar(50) not null,
    name varchar(50) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null
);

create table tbl_users (
	id int primary key auto_increment,
    username varchar(50) not null unique,
    password varchar(35) not null,
    email varchar(50) not null unique,
    name varchar(30) not null,
    image varchar(255),
    date_of_birth date not null,
    address varchar(255),
    phone_number varchar(15) not null,
    role_id int not null,
    status int default 0 comment '0. Active | 1. Blocked | 2. Deleted',
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_users_role foreign key (role_id) references tbl_users(id)
);

create table tbl_courses(
	id int primary key auto_increment,
	name varchar(100) not null,
	time_start date not null,
	address varchar(255) not null,
	tuition float not null,
	status int default 0 comment '0. Active | 1. In active',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null
);

create table tbl_transaction_history(
	id int primary key auto_increment,
	courses_id int not null,
	user_id int not null,
	registration_date date not null,
	status int default 0 comment '0. Processing | 1. Successful',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_transaction_courses foreign key (courses_id) references tbl_courses(id),
    constraint fk_transaction_users foreign key (user_id) references tbl_users(id)
);


create table tbl_class(
	id int primary key auto_increment,
	courses_id int not null,
	name varchar(100) not null,
	user_id int not null comment 'User is a teacher',
	start_date date not null,
	end_date date not null,
	status int default 0 comment '0. Active | 1. Completed | 2. Closed',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_class_courses foreign key (courses_id) references tbl_users(id),
    constraint fk_class_users foreign key (user_id) references tbl_users(id)
);

create table tbl_class_student(
	id int primary key auto_increment,
	user_id int not null comment 'User is a student',
	class_id int not null,
	day_add date not null,
	status int default 0 comment '0. Active | 1. Completed | 2. Dropped',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_student_class foreign key (class_id) references tbl_class(id),
    constraint fk_student_users foreign key (user_id) references tbl_users(id)
);

create table tbl_lectures(
	id int primary key auto_increment,
	class_id int not null,
    user_id int not null,
	title varchar(100) not null,
	content text not null,
	file_url varchar(255) not null,
	status int default 0 comment '0. Active | 1. Inactive',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_lectures_class foreign key(class_id) references tbl_class(id)
);

create table tbl_attendance(
	id int primary key auto_increment,
	class_id int not null,
	user_id int not null,
	day date not null,
	status int default 0 comment '0. Present | 1. Absent',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_attendance_class foreign key(class_id) references tbl_class(id),
    constraint fk_attendance_users foreign key(user_id) references tbl_users(id)
);


create table tbl_score(
	id int primary key auto_increment,
	class_id int not null,
	user_id int not null comment 'User is a student',
	score float,
	status int default 0 comment '0. Unpublished | 1. Published',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_score_class foreign key(class_id) references tbl_class(id),
    constraint fk_score_users foreign key(user_id) references tbl_users(id)
);

create table tbl_reviews(
	id int primary key auto_increment,
	class_id int not null,
	user_id int not null,
	rating float not null,
	comment text,
	status int default 0 comment '0. Successful | 1. Canceled',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_reviews_class foreign key(class_id) references tbl_class(id),
    constraint fk_reviews_users foreign key(user_id) references tbl_users(id)
);


create table tbl_blog(
	id int primary key auto_increment,
	user_id int not null,
	title varchar(100) not null,
	content text not null,
	status int default 0 comment '0. Pending | 1. Published',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_blog_users foreign key(user_id) references tbl_users(id)
);

create table tbl_blog_comment(
	id int primary key auto_increment,
    blog_id int not null,
	user_id int not null,
	content text,
	image varchar(255),
	status int default 0 comment '0. Successful | 1. Canceled',
	created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    deleted_at timestamp null default null,
    constraint fk_comment_blogg foreign key(blog_id) references tbl_blog(id),
    constraint fk_comment_users foreign key(user_id) references tbl_users(id)
);


insert into tbl_role(keyy, name)
values ('student', 'Học sinh'),
    ('teacher', 'Giáo viên'),
    ('admin', 'Quản trị viên');

insert into tbl_users(username, password, email, name, image, date_of_birth, address, phone_number, role_id)
values ('user1', '1', 'email1', 'Nguyễn Văn A', 'ảnh', '1997-06-08', 'Hà Nội', '0987145237', '1'),
    ('user2', '1', 'email2', 'Nguyễn Văn B', null, '1997-06-30', 'Đà Nẵng', '0985745237', '1'),
    ('user3', '1', 'email3', 'Nguyễn Văn C', 'ảnh', '2000-06-08', 'Hà Nội', '0987895237', '1'),
    ('user4', '1', 'email4', 'Nguyễn Văn D', null, '2002-06-08', 'Hà Nội', '0987145457', '1'),
    ('user5', '1', 'email5', 'Nguyễn Văn E', 'ảnh', '1998-06-08', 'Tuyên Quang', '0985645237', '2'),
    ('user6', '1', 'email6', 'Nguyễn Văn F', 'ảnh', '1995-07-08', 'Hà Nội', '0987195237', '2'),
    ('user7', '1', 'email7', 'Nguyễn Văn G', 'ảnh', '1994-06-08', null, '0987140237', '2'),
    ('user8', '1', 'email8', 'Nguyễn Văn H', 'ảnh', '1997-10-08', 'Hà Nội', '0987145217', '2'),
    ('user9', '1', 'email9', 'Nguyễn Văn K', null, '1997-06-08', null, '0987149237', '1'),
    ('user10', '1', 'email10', 'Nguyễn Văn T', null, '1998-06-08', 'Bắc Ninh', '0987145239', '3');

insert into tbl_courses(name, time_start, address, tuition, status)
values ('Java Fullstack 16', '2021-05-18', 'Tố Hữu', '25000000', '1'),
    ('Java Fullstack 19', '2023-02-21', 'Tố Hữu', '25000000', ''),
    ('PHP Fullstack 16', '2023-05-18', 'Tố Hữu', '20000000', ''),
    ('Web Fullstack 16', '2021-05-18', 'Dịch Vọng Hậu', '25000000', '1'),
    ('Lập trình di động IOS', '2023-01-18', 'Tố Hữu', '25000000','');

insert into tbl_transaction_history(courses_id, user_id, registration_date, status)
values('1', '1', '2021-05-15', '1'),
    ('2', '2', '2023-02-21', '1'),
    ('3', '3', '2023-05-14', ''),
    ('4', '4', '2021-05-18', '1'),
    ('5', '5', '2023-01-12', '1');

insert into tbl_class(courses_id, name, user_id, start_date, end_date, status)
values('1', 'Web căn bản', '5', '2021-05-18', '2021-06-18', '1'),
    ('1', 'Java core', '6', '2021-06-25', '2021-07-18', '1'),
    ('1', 'SQL', '7', '2021-07-20', '2021-08-18', '1'),
    ('1', 'Giải thuật', '8', '2021-08-26', '2021-09-30', '1'),
    ('1', 'Spring boot', '6', '2021-10-03', '2021-12-18', '1');

insert into tbl_class_student(user_id, class_id, day_add, status)
values ('1', '1', '2021-05-17', '1'),
    ('2', '1', '2021-05-17', '1'),
    ('3', '1', '2021-05-17', '1'),
    ('4', '1', '2021-05-17', '1'),
    ('9', '1', '2021-05-17', '1');

insert into tbl_lectures(class_id, user_id, title, content, file_url, status)
values('1', '5', 'tiêu đề', 'nội dung', 'url', '1'),
    ('2', '6', 'tiêu đề', 'nội dung', 'url', '1'),
    ('3', '7', 'tiêu đề', 'nội dung', 'url', '1'),
    ('4', '8', 'tiêu đề', 'nội dung', 'url', '1'),
    ('5', '6', 'tiêu đề', 'nội dung', 'url', '1');

insert into tbl_attendance(class_id, user_id, day, status)
values('1', '1', '2021-05-27',''),
    ('1', '2', '2021-05-27',''),
    ('1', '3', '2021-05-27','1'),
    ('1', '4', '2021-05-27',''),
    ('1', '9', '2021-05-27','1');

insert into tbl_score(class_id, user_id, score, status)
values('1', '1', '8.0', '1'),
    ('1', '2', '7.0', '1'),
    ('1', '3', '8.7', '1'),
    ('1', '4', '8.3', '1'),
    ('1', '9', '8.9', '1');

insert into tbl_reviews(class_id, user_id, rating, comment, status)
values('1', '1', '8', '', ''),
    ('1', '2', '9', 'Good', ''),
    ('1', '3', '10', 'Good', ''),
    ('1', '4', '7', '', ''),
    ('1', '9', '10', 'Good', '');

insert into tbl_blog(user_id, title, content, status)
values('1', ' Tiêu đề', 'Nội dung', '1'),
    ('3', ' Tiêu đề', 'Nội dung', '1'),
    ('5', ' Tiêu đề', 'Nội dung', '1'),
    ('8', ' Tiêu đề', 'Nội dung', '1'),
    ('9', ' Tiêu đề', 'Nội dung', '1');

insert into tbl_blog_comment(blog_id, user_id, content, image, status)
values('1', '1', 'Nội dung', 'url', ''),
    ('1', '2', 'Nội dung', 'url', ''),
    ('2', '6', 'Nội dung', 'url', ''),
    ('4', '4', 'Nội dung', 'url', ''),
    ('5', '9', 'Nội dung', 'url', '1');