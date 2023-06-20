create database employee_manager;

use employee_manager;

create table tbl_status(
	id int primary key auto_increment,
	keyy varchar(20) not null,
    valuee varchar(50) not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null
);

create table tbl_branch(
	id int primary key auto_increment,
    address varchar(255) not null,
	phone_number varchar(15) not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_branch_status foreign key(status_id) references tbl_status(id)
);

create table tbl_department(
	id int primary key auto_increment,
    name varchar(100) not null,
    phone_number varchar(15) not null,
    mission text,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_department_status foreign key(status_id) references tbl_status(id)
);

create table tbl_job_position(
	id int primary key auto_increment,
    department_id int not null,
    name varchar(100) not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_jobPos_department foreign key (department_id) references tbl_department(id),
    constraint fk_jobPos_status foreign key(status_id) references tbl_status(id)
);

create table tbl_type_personnel(
	id int primary key auto_increment,
    name varchar(50) not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_typePersonnel_status foreign key(status_id) references tbl_status(id)
);

create table tbl_gender(
	id int primary key auto_increment,
    name varchar(30) not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null
);

create table tbl_staff(
	id int primary key auto_increment,
    name varchar(50) not null,
    gender_id int not null,
    date_of_birth date not null,
    phone_number varchar(15) not null,
    address varchar(255) not null,
    citizen_identity varchar(15) not null unique,
    image varchar(255) not null,
    branch_id int not null,
    jobPosition_id int not null,
    typePersonnel_id int not null,
	status_id int not null,
    created_at timestamp not null default current_timestamp,
	updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_staff_gender foreign key (gender_id) references tbl_gender(id),
    constraint fk_staff_branch foreign key (branch_id) references tbl_branch(id),
    constraint fk_staff_jobPos foreign key (jobPosition_id) references tbl_job_position(id),
    constraint fk_staff_typePersonnel foreign key (typePersonnel_id) references tbl_type_personnel(id),
    constraint fk_staff_status foreign key(status_id) references tbl_status(id)
);

create table tbl_contract(
	id int primary key auto_increment,
    code varchar(20) not null,
    staff_id int not null,
    time_start date not null,
    time_end date not null,
    content text not null,
    signing_date date not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_contract_staff foreign key (staff_id) references tbl_staff(id),
    constraint fk_contract_status foreign key(status_id) references tbl_status(id)
);

create table tbl_academic_level(
	id int primary key auto_increment,
    staff_id int not null,
    major varchar(50) not null,
	school varchar(100) not null,
    graduation_year varchar(4),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_level_staff foreign key (staff_id) references tbl_staff(id)
);

create table tbl_insurance(
	id int primary key auto_increment,
    staff_id int not null,
    insurance_code varchar(15) not null,
	issue_date date not null,
    place_of_issue varchar(255) not null,
    hospital varchar(255) not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
	constraint fk_insurance_staff foreign key (staff_id) references tbl_staff(id),
    constraint fk_insurance_status foreign key(status_id) references tbl_status(id)
);

create table tbl_timesheets(
	id int primary key auto_increment,
    staff_id int not null,
    working_day date not null,
    time_start time not null,
    time_end time not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_timesheets_staff foreign key (staff_id) references tbl_staff(id),
    constraint fk_timesheets_status foreign key (status_id) references tbl_status(id)
);

create table tbl_discipline_reward(
	id int primary key auto_increment,
    type varchar(50) not null,
    staff_id int not null,
    content text,
	dayy date not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_disciplineReward_staff foreign key (staff_id) references tbl_staff(id),
    constraint fk_disciplineReward_status foreign key(status_id) references tbl_status(id)
);

create table tbl_overtime(
	id int primary key auto_increment,
    staff_id int not null,
    working_day date not null,
    number_hours float not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_overtime_staff foreign key (staff_id) references tbl_staff(id),
    constraint fk_overtime_status foreign key(status_id) references tbl_status(id)
);

create table tbl_salary(
	id int primary key auto_increment,
    staff_id int not null,
    monthh int not null,
    yearr year not null,
    salary_base float not null,
    allowance float not null,
    overtime float not null,
    reward float not null,
	discipline float not null,
    tax float not null,
    status_id int not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
	deleted_at timestamp null default null,
    constraint fk_salary_staff foreign key (staff_id) references tbl_staff(id),
    constraint fk_salary_status foreign key(status_id) references tbl_status(id)
);


insert into tbl_status(keyy, valuee)
values ('branch', 'Đang mở cửa'),
	('branch', 'Đang đóng cửa'),
    ('department', 'Đang hoạt động'),
	('department', 'Dừng hoạt động'),
    ('jobPosition', 'Đang tuyển dụng'),
	('jobPosition', 'Dừng tuyển dụng'),
    ('typePersonnel', 'Đang sử dụng'),
	('typePersonnel', 'Dừng sử dụng'),
    ('staff', 'Đang làm việc'),
    ('staff', 'Đã nghỉ việc'),
    ('insurance', 'Có hiệu lực'),
    ('insurance', 'Không hiệu lực'),
    ('contract','Còn hạn'),
    ('contract','Hết hạn'),
    ('timesheets', 'Đã chấm công'),
    ('timesheets', 'Chưa chấm công'),
    ('overtime', 'Đã xác nhận'),
    ('overtime', 'Chưa xác nhận'),
    ('discipline_reward', 'Đã phê duyệt'),
    ('discipline_reward', 'Chưa phê duyệt'),
    ('salary', "Đã thanh toán"),
    ('salary', "Chưa thanh toán");

insert into tbl_branch(address, phone_number, status_id)
values ('Hà Nội', '0933595666', '1'),
	('Hồ Chí Minh', '0933444444', '1'),
    ('Đà Nẵng', '0763777879', '1'),
    ('Hải Dương', '0353716666', '1'),
    ('Bắc Ninh', '0915637637', '1');

insert into tbl_department(name, phone_number, mission, status_id)
values ('Bộ phận quản lý', '0343888888', 'Quản lý và điều hành toàn bộ hoạt động của công ty', '3'),
	('Bộ phận kinh doanh', '0967456789', 'Tìm kiếm và giữ chân khách hàng, xây dựng mối quan hệ và bán sản phẩm hoặc dịch vụ của công ty', '3'),
    ('Bộ phận tài chính', '0968686868', 'Quản lý tài chính, đảm bảo các giao dịch tài chính được thực hiện đúng thời hạn và giám sát hoạt động tài chính của công ty', '3'),
    ('Bộ phận sản xuất', '0332588888', 'Sản xuất và cung cấp sản phẩm hoặc dịch vụ của công ty', '3'),
    ('Bộ phận nhân sự', '0987654444', 'Quản lý và phát triển nhân sự, tuyển dụng, đào tạo và giữ chân nhân viên', '3'),
    ('Bộ phận kỹ thuật', '0369258147', 'Quản lý hệ thống thông tin và hỗ trợ kỹ thuật cho các bộ phận khác của công ty', '3');    


insert into tbl_job_position(department_id, name, status_id)
values ('1', 'Giám đốc', '6'),
    ('2', 'Nhân viên sale-marketing', '5'),
    ('3', 'Nhân viên kế toán', '5'),
	('3', 'Trưởng phòng kế toán', '6'),
    ('4', 'Nhân viên thiết kế sản phẩm', '5'),
    ('4', 'Nhân viên sản xuất', '5'),
    ('4', 'Nhân viên kiểm tra chất lượng sản phẩm', '5'),
    ('5', 'Nhân viên tuyển dụng', '5'),
    ('5', 'Trưởng phòng nhân sự', '6'),
    ('6', 'Nhân viên kỹ thuật', '5');


insert into tbl_type_personnel(name, status_id)
values ('Nhân viên chính thức', '7'),
	('Nhân viên thời vụ', '7');


insert into tbl_gender(name)
values ('Nam'),('Nữ'),('Khác');


insert into tbl_staff (name, gender_id, date_of_birth, phone_number, address, citizen_identity, image, branch_id, jobPosition_id, typePersonnel_id, status_id)
values ('Nguyễn Văn Tùng', '1', '1994-06-01', '0966384256', 'Hà Nội', '010123456789', 'ảnh', '1', '1', '1', '9'),
    ('Nguyễn Thị Bảo Anh', '2', '1995-06-07', '0357264965', 'Hà Nội', '011123456789', 'ảnh', '1', '2', '1', '9'),
    ('Vũ Văn Quyết', '1', '1996-06-19', '0169258147', 'Hồ Chí Minh', '012123456789', 'ảnh', '2', '10', '1', '9'),
    ('Đào Thị Dung', '2', '1994-06-21', '0365789142', 'Hải Dương', '013123456789', 'ảnh', '4', '3', '1', '9'),
    ('Nguyễn Tuấn Khang', '1', '1993-06-09', '0365269396', 'Hà Nội', '014123456789', 'ảnh', '1', '6', '1', '9'),
    ('Hà Văn Quang', '1', '1998-05-04', '0365423983', 'Bắc Ninh', '015123456789', 'ảnh', '5', '8', '2', '9'),
    ('Phạm Quang Tiến', '1', '1995-05-09', '0398753621', 'Hải Dương', '016123456789', 'ảnh', '4', '10', '1', '9'),
    ('Kiều Văn Tuấn', '1', '1997-09-06', '0986564147', 'Ninh Bình', '017123456789', 'ảnh', '4', '5', '1', '9'),
    ('Lê Văn Tuấn', '1', '1997-05-07', '0321852149', 'Tuyên Quang', '018123465789', 'ảnh', '5', '7', '1', '9'),
    ('Hoàng Thị Phương', '2', '1998-12-03', '0987654123', 'Hà Nội', '016123456857', 'ảnh', '1', '6', '2', '10');


insert into tbl_academic_level (staff_id, major, school, graduation_year)
values ('1', 'Quản lý doanh nghiệp', 'Đại học Thương Mại', '2019'),
    ('2', 'Marketing', 'Học viên tài chính', '2021'),
    ('3', 'Công nghệ thông tin', 'Học viện bưu chính viễn thông', '2021'),
    ('7', 'Tự động hóa', 'Đại học bách khoa', '2020'),
    ('4', 'Kế toán', 'Học viện ngân hàng', '2018');

insert into tbl_insurance (staff_id, insurance_code, issue_date, place_of_issue, hospital, status_id)
values ('2', 'BH1', '2019-06-12', 'Hồ Chí Minh', 'Bệnh viện Hồ Chí Minh', '11'),
    ('3', 'BH2', '2018-09-12', 'Hà Nội', 'Bệnh viện Đa khoa Hà Nội', '11'),
    ('4', 'BH3', '2020-07-15', 'Hải Dương', 'Bệnh viện Hải Dương', '11'),
    ('5', 'BH4', '2018-08-12', 'Hà Nội', 'Bệnh viện Đa khoa Hà Nội', '11'),
    ('6', 'BH5', '2019-01-19', 'Bắc Ninh', 'Bệnh viện Bắc Ninh', '11'),
    ('7', 'BH6', '2018-07-20', 'Hải Dương', 'Bệnh viện Hải Dương', '11');

insert into tbl_contract (code, staff_id, time_start, time_end, content, signing_date, status_id)
values ('HD1', '2', '2018-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13'),
    ('HD2', '3', '2018-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13'),
    ('HD3', '4', '2018-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13'),
    ('HD4', '5', '2018-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13'),
    ('HD5', '6', '2018-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13'),
    ('HD6', '7', '2018-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13'),
    ('HD7', '8', '2019-06-11', '2025-06-11', 'Nội dung', '2018-06-01', '13');

insert into tbl_timesheets (staff_id, working_day, time_start, time_end, status_id)
values ('2', '2022-06-22', '07:30:04', '18:00:04', '15'),
    ('3', '2022-06-22', '07:35:04', '18:01:04', '15'),
    ('4', '2022-06-22', '07:40:04', '18:02:04', '15'),
    ('5', '2022-06-22', '07:15:04', '18:03:04', '15'),
    ('6', '2022-06-22', '07:20:04', '18:04:04', '15'),
    ('7', '2022-06-22', '07:26:04', '18:05:04', '15'),
    ('8', '2022-06-22', '07:05:04', '18:06:04', '15');

insert into tbl_overtime (staff_id, working_day, number_hours, status_id)
values ('2', '2022-04-22', '2', '17'),
    ('3', '2022-04-22', '2', '17'),
    ('4', '2022-04-22', '2', '17'),
    ('5', '2022-04-22', '2', '17'),
    ('6', '2022-04-22', '2', '17'),
    ('7', '2022-04-22', '2', '17'),
    ('8', '2022-04-22', '2', '17'),
    ('9', '2022-04-22', '2', '17');


insert into tbl_discipline_reward (type, staff_id, content, dayy, status_id)
values ('Khen thưởng', '4', 'Nhân viên xuất sắc tháng 6', '2021-06-15', '19'),
    ('Kỷ luật', '5', 'Đi làm muộn', '2021-07-15', '19'),
    ('Khen thưởng', '6', 'Nhân viên xuất sắc tháng 8', '2021-08-15', '19'),
    ('Khen thưởng', '8', 'Nhân viên xuất sắc tháng 9', '2021-09-15', '19'),
    ('Khen thưởng', '10', 'Nhân viên xuất sắc tháng 10', '2021-10-15', '19');

insert into tbl_salary (staff_id, monthh, yearr, salary_base, allowance, overtime, reward, discipline, tax, status_id)
values ('3', '10', '2020', '8000000', '500000', '700000', '200000', '0', '150000', '21'),
    ('4', '10', '2020', '10000000', '500000', '700000', '0', '0', '150000', '21'),
    ('5', '10', '2020', '12000000', '500000', '700000', '0', '100000', '150000', '21'),
    ('6', '10', '2020', '9000000', '500000', '700000', '200000', '0', '150000', '21'),
    ('7', '10', '2020', '10000000', '500000', '700000', '400000', '0', '150000', '21'),
    ('8', '10', '2020', '11000000', '500000', '700000', '200000', '200000', '150000', '21'),
    ('9', '10', '2020', '10000000', '500000', '700000', '200000', '100000', '150000', '21'),
    ('10', '10', '2020', '11000000', '500000', '700000', '500000', '0', '150000', '21');