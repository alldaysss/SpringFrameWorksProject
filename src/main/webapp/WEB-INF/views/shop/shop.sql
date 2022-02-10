show tables;

/* 장바구니 테이블 */
create table cart (
	idx int not null auto_increment, /* 장바구니 고유번호 */
	mid varchar(20) not null,		 /* 유저 아이디 */
	itemIdx int not null,						 /* 상품 고유 번호 */
	itemName varchar(100) not null,
	quanTity int not null, 					 /* 구매 수량 */
	itemPrice int not null,
	pdImage  varchar(100) not null,
	primary key(idx),
	foreign key(itemIdx) references alcohol(idx) on update cascade,
	foreign key(mid) references user(mid) on update cascade on delete restrict
);

drop table cart;
select * from cart;

select *, sum(quanTity) as quanTitySum  from cart where mid='admin' group by itemIdx;

/* 주문 프로세스 테이블 */
create table  alOrderProcess (
	idx int not null auto_increment, /* 장바구니 고유 번호 */
	orderIdx varchar(50) not null,	 /* 주문번호(새롭게 컨트롤러를 이용하여 생성해 주어야 함 */
	itemIdx varchar(100) not null,						 /* 상품 고유 번호(배열저장) */
	pdImage varchar(1000) not null,/* 상품 이미지(배열저장) */
	itemName varchar(500) not null,  /* 상품 이름(배열저장) */
	itemPrice varchar(200) not null,					 /* 상품 가격(배열저장) */
	quanTitySum varchar(100) not null,					 /* 상품 수량(배열저장) */
	mid varchar(20) not null,				 /* 유저 아이디  */
	totCalcPrice int not null,			 /* 주문하는 상품의 총 가격(배송비 +- 됨) */
	orderDate datetime default now(),/* 주문하는 날짜 */
	/* 테이블 내 배송파트 */
	dvTel	varchar(15) not null,						/* 배송 시 연락처 */
	dvAddress varchar(100) not null,			/* 배송 시 주소 */
	dvName varchar(20) not null,					/* 수령자 명 */
	dvPayment varchar(20) not null,				/* 결제 방식 */
	dvPaymentNumber varchar(20) not null,	/* 결제 번호(카드번호 등)*/
	dvPayer varchar(20) not null,					/* 배송 시 연락처 */
	dvRequest varchar(200) not null,			/* 배송 시 요청 사항 */
	dvStatus varchar(20) default '결제완료',/* 배송 상태 */
	primary key(idx),
/* 	foreign key(itemIdx) references alcohol(idx) on update cascade on delete cascade, */
	foreign key(mid) references user(mid) on update cascade on delete cascade
);

drop table alOrderProcess;
select * from alOrderProcess;
select substring(now(),1,10) from alOrderProcess;
select subdate(now(), INTERVAL 1 day) from alOrderProcess;
select substring(orderDate,1,10) from alOrderProcess;
select * from alOrderProcess where mid='test' and date(orderDate) >= date(subdate(now(), INTERVAL 2 day)) and date(orderDate) <= date(now()) order by orderDate desc;
select date_format(orderDate, '%Y-%m-%d') as orderDate, sum(totCalcPrice) as todayAmount from alOrderProcess group by date_format(orderDate, '%Y-%m-%d') order by orderDate asc;