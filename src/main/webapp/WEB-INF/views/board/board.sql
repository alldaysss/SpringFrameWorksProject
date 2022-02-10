show tables;

create table board (
	idx int not null auto_increment, /* 게시글의 고유 번호 */
	nickName varchar(30) not null,   /* 게시글 등록자의 별명*/
	title varchar(100) not null,     /* 게시글 제목 */
	content text not null,           /* 글 내용 */
	wDate datetime default now(),    /* 글 작성일 */
	readNum int default 0,           /* 조회수 */
	hostIp varchar(30) not null,         /* 접속 IP 주소 */
	good int default 0,              /* 좋아요(추천) */
	mid varchar(30) not null,        /* 게시글 조회 시 회원 아이디를 따라서 간다 */
	
	/* 상품 데이터 당겨오는 칼럼 */
	itemName varchar(1000) not null,   /* 구매한 제품의 이름(게시판 미리보기에선 SubString을 활용하여 10 글자로 끊어준다 */
	pdImage varchar(1000) not null,     /* 상품의 사진 */
	primary key(idx)								 /* 기본 키 : 게시글 고유 번호 */
);
drop table board;
select * from board;
select count(*) from board;
create table boardReply (
	idx int not null auto_increment primary key, /* 댓글 고유 번호 */
	boardIdx int not null, 											 /* 원본글의 고유 번호(외래키 지정) */
	mid varchar(30) not null,										 /* 올린이의 아이디 */
	nickName varchar(30) not null,							 /* 올린이(별명) */
	wDate datetime default now(),								 /* 댓글이 기록되는 현재 시각(날짜) */
	content text not null,											 /* 댓글 내용 */
	replyGood int not null default 0,						 /* 댓글 추천 */
	level int not null default 0,								 /* 댓글의 레벨 부모댓글의 레벨은 '0'이다. */
	levelOrder int not null default 0,           /* 댓글의 순서 - 부모댓글의 levelOrder는 '0' 부터 시작 됨 ( 댓글이 달릴 수 록 계속 증가)*/
	foreign key(boardIdx) references board(idx) /* 게시판의 idx */
	on update cascade
	on delete restrict
);
update boardReply set replyGood = -1 where idx = 1;
select * from board where , cast(timestampdiff(minute, wDate, now(), INTERVAL -1 DAY) as diffTime from board order by idx desc;
update boardReply set levelOrder=levelOrder+1 where boardIdx= 1 and levelOrder > 0;
select count(*) from board where date_sub( now(), interval 7 day) < wDate;
/* drop table boardReply; */
desc boardReply;
select date_format(wDate, '%Y-%m-%d') as wDate, count(*) as count from board group by date_format(wDate, '%Y-%m-%d') order by wDate asc;
