show tables;

create table user (
	idx int not null auto_increment, 						/* 회원 고유번호 */
	photo varchar(100) default 'noimage.jpg',		/* 회원 사진 */
	mid varchar(20) not null,										/* 회원 아이디 */
	pwd varchar(100) not null,									/* 회원 비밀번호 */
	nickName varchar(20) not null,							/* 회원 별명 */
	tel varchar(15) not null,										/* 회원 전화번호 */
	name varchar(20) not null,									/* 회원 이름 */
	birthday datetime default now(),						/* 생년월일 */
	gender varchar(10) default '남자',						/* 성별 */
	address varchar(50),												/* 주소 */
	email varchar(50) not null,									/* 이메일 */
	userDel varchar(5) default 'NO',						/* 회원 탈퇴 신청 여부 기본값 'NO'(가입중인 회원) 'OK' 탈퇴 신청한 회원*/
	point int default 1000,											/* 포인트(최초가입시 1000, 구매시 3% 포인트 적립)*/
	level int default 4,												/* 회원등급 1:특별회원, 2:우수회원, 3:정회원, 4:준회원, 0:관리자 등급별 할인률 적용*/
	primary key(idx, mid)														/* 기본키 : 고유번호, 아이디*/
);
desc user;

/* drop table user; */
insert into user values (default, 'default', 'admin', '1234', '관리자', '010-4435-1883', '관리자', '1992-02-16', '남자', '충북 청주시 흥덕구','my188cm@naver.com',default,default, 0);

select * from user;