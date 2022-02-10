/* 상품 분류 테이블 */
create table alcohol (
	idx int not null auto_increment, 		/* 고유 번호 */
	itemCode varchar(20) not null,			/* 상품분류 코드(분류 코드(예 와인 = W, 위스키 =S)) */
	itemName varchar(50) not null,			/* 상품명(제품명) */
	shortCont	varchar(100) not null,		/* 상품 초기 간단 설명 */
	itemPrice int not null,							/* 상품 기본 가격 */
	/* fName varchar(100) not null,				 상품 기본사진(1장만 처리)- 필수 입력 한다.*/
	fName varchar(100) not null,				/* 서버에 저장될 상품의 고유이름 */
	content text not null,							/* 상품의 상세 설명 - ckeditor를 이용하여 이미지 처리한다. */
	primary key(idx)
);

show tables;
drop table alcohol;
select * from alcohol;

select * from alOrderProcess where dvStatus = '결제완료' order by orderDate desc limit 0, 5;