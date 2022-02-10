show tables;

create table calendar (
	idx int not null auto_increment primary key, /* 고유번호 */
	mid varchar(30) ,									 /* 아이디 */
	cDate datetime not null,										 /* 예약일정을 잡을 날짜 / 시간 */
	part varchar(30) default '',								 /* 예약 목적 구분 시음예약 외의 탭을 선택 시 주류 코드와 값은 탭과 동일한 이름으로 저장 시킨다.*/
	itemCode  varchar(30) default '기타' not null,/* 주류 코드 분류 구분 */
	reitemName varchar(150) default '기타' not null,  /* 값이 저장 될 주류의 이름 */
	content text not null											 /* 일정 내역*/
);

desc calendar;
drop tables calendar;
select * from alcohol order by itemCode;
select * from calendar where date_format(cDate, '%Y-%m') order by cDate;

select * from calendar where date_format(cDate, '%Y-%m-%d')=date_format(2022-02-03, '%Y-%m-%d');
select * from calendar where date_format(cDate, '%Y-%m-%d')=date_format(#{cDate}, '%Y-%m-%d');
select * from calendar where date_format(cDate, '%Y-%m-%d')=date_format(2022-02-03, '%Y-%m-%d');
select date_format(cDate, '%Y-%m-%d') as cDate, count(*) as count from calendar group by date_format(cDate, '%Y-%m-%d') order by cDate asc;