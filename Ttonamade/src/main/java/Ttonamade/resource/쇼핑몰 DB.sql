drop table customer_info cascade constraints;
drop table product_info cascade constraints;
drop table cart_info cascade constraints;
drop table order_info cascade constraints;
drop table order_detail cascade constraints;
drop table product_choice cascade constraints;
drop table product_review cascade constraints;
drop table goods_category cascade constraints;
drop table qna cascade constraints;

drop sequence cust_id_seq;
drop sequence prod_id_seq;
drop sequence cart_id_seq;
drop sequence order_detail_seq;
drop sequence tbl_goods_seq;
drop sequence qna_seq;
drop sequence seq_child_level;

create table customer_info(
cust_id varchar2(50) not null,
cust_name varchar2(50) not null,
cust_password varchar2(100) not null,
cust_sex varchar2(50),
cust_telephone varchar(20),
cust_birthday varchar2(20),
cust_manager char(2),
cust_date date default sysdate,
constraint cust_id_pk primary key(cust_id)
);
 
create sequence cust_id_seq;

create table product_info(
prod_id number NOT NULL,
prod_name varchar2(50)NOT NULL,
prod_price number,
prod_count int,
prod_desc varchar2(4000),
prod_imgsrc varchar2(100),
prod_rating number(2,1) DEFAULT 0,
prod_date date default sysdate,
cateCode varchar2(30),
constraint prod_id_pk primary key(prod_id)
);

create sequence prod_id_seq;

create table cart_Info(
cart_id number not null,
cust_id varchar(50) not null,
prod_id number not null,
prod_name varchar2(50),
prod_count int default 1,
prod_price number default 0, 
constraint cart_id_pk primary key(cart_id),
constraint prod_id1_fk foreign key(prod_id) references Product_Info(prod_id),
constraint cust_id1_fk foreign key(cust_id) references Customer_Info(cust_id)
);

create sequence cart_id_seq;

create table order_info (
order_id varchar2(50) NOT NULL,
cust_id varchar(50) NOT NULL,
order_totalAmount number,
order_zipcode varchar(10),
order_add1 varchar(100),
order_add2 varchar(100),
order_telephone varchar(20),
order_status char(2),
order_date date default sysdate,
reservation_date date,
send_date date,
reservation_memo varchar(4000),
constraint order_id_pk primary key(order_id),
constraint cust_id_fk foreign key(cust_id) references Customer_Info(cust_id)
);

create table Order_Detail( 
order_seq number not null, 
order_id varchar2(50) not null,
prod_id number not null, 
prod_name varchar2(50) not null,
prod_price number default 0,
order_count int default 1,
constraint order_seq_pk primary key (order_seq),
constraint order_id_fk foreign key(order_id) references Order_Info(order_id),
constraint prod_id_fk foreign key(prod_id) references Product_Info(prod_id)
);

create sequence order_detail_seq;

insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '빅토리아 케이크🍓' , 45000, 10, '빅토리아 여왕이 즐겨먹었다는 스펀지 케이크로 속에 생크림과 직접 만든 라즈베리 필링, 그리고 생딸기를 넣어서 맛과 향이 더 그득합니다.', 'img/빅토리아 케이크.jpg', 4.8, '21/09/07', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '블루베리 크림치즈 크럼블', 5200, 10, '이름 그대로 보슬보슬한 크럼블 아래 수제 블루베리 콩포드와 블루베리 그리고 크림치즈가 들어가 있어 새콤달콤한 블루베리크림치즈크럼블 입니다 =)', 'img/fe9957e1-9323-46d5-bbac-be06e10283f3_블루베리크림치즈크럼블.jpg', 4.2, '21/09/08', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '엠앤엠 초코케이크(1)', 34000, 10, '바닐라 시트와 초코 시트 중 선택 가능하며 시트 사이사이에 초코 크림과 초코 크런치볼이 들어가 있어 바삭바삭한 식감을 더 했습니다.', 'img/b3fe2d8a-f6d8-42f3-a1b6-c207f90e5cb1_엠엔엔 초코케이크.jpg', 4.2, '21/09/08', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '아몬드 초코 크림치즈 구겔호프', 26000, 10, '초코 반죽 안에 크림치즈가 들어가 있어서 단짠단짠의 찰떡궁합이며,  초코 후레이키 과자를 데코로 올려서 더 초코초코하고 크런키한 맛을 주는 구겔호프 입니다.', 'img/아몬드초코크림치즈구겔호프.jpg', 4.5, '21/09/07', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '구겔호프(핑크/레몬)', 19000, 10, '두 가지 구겔호프 모두 기본 오리지날 시트로 만들어졌으면 핑크 구겔호프는 핑크 커버춰와 스프링클로 데코해 사랑스러운 느낌을 주고 레몬구겔호프는 무난한 것을 좋아하시는 분들이 많이 찾아주시며 그만큼 호불호가 안갈리는 구겔호프로 레몬글레이즈와 레몬이 사용되었습니다.', 'img/구겔호프.jpg', 4.3, '21/09/07', 500);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '특별한 케이크 ', 42000, 10, '초코시트 가운데에는 크림치즈 크림으로, 나머지 부분은 초코 크림과 아몬드 크런치볼로 데코하여 특별한 날에 함께하면 좋을 특별한 케이크 입니다.', 'img/초코크림치즈케이크2.jpg', 5, '21/09/07', 6);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '오레오 쿠키 아이스박스🎈', 22000, 10 , '오레오아이스박스는 따로 시트가 들어가지 않아 부담없이 드실수 있으며 오레오를 좋아하시는 분들이라면 누구나 좋아할 만한 오레오 쿠키 아이스박스로, 생일케이크로도 많이 찾아주시며 초코볼로 위에 숫자 레터링 가능합니다 =)', 'img/생일 아이스박스케이크.jpg', 4.2, '21/09/07', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '파운드 케이크', 17000, 10, '바닐라빈을 듬뿍 넣어 풍부한 바닐라 향과 더불어 호두를 넣어 좀 더 고소하게 접할 수 있으며 가장 기본이 되는 파운드케이크로 남녀노소가 모두 좋아해서 선물하기에도 좋습니다.', 'img/파운드케이크.jpg', 4.7, '21/09/07', 7);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '미니 파운드 세트', 24800, 10, '얼그레이, 초코, 쑥인절미, 바닐라 각 2개씩 총 8개로 구성되어 있으며 다양한 맛을 원하시는 분들에게 강력 추천해 드리며 알록달록 선물하기에도 좋은 미니 파운드 세트입니다.', 'img/미니큐브파운드.jpg', 4.6, '21/09/07', 7);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '밤 마들렌 🌰 (개당)', 3400, 10, '밤모양의 마들렌으로 속에 군밤과 밤 페이스트가 들어있어요! 밤 러버들이라면 다들 반할 맛 =)', 'img/밤 마들렌.jpg', 4, '21/09/07', 400);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '엠앤엠 초코케이크(2)', 34000, 10, '바닐라 시트와 초코 시트 중 선택 가능하며 시트 사이사이에 초코 크림과 초코 크런치볼이 들어가 있어 바삭바삭한 식감이 더해져 있습니다.', 'img/f85d6d38-0575-4153-8633-f3e3199be614_핑크초코케이크.jpg', 4.3, '21/09/08', 8);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '생크림 카스테라', 15000, 10, '푹신하면서도 촉촉하고 부드러운  생크림 카스테라 입니다 =)', 'img/ee07d328-9762-4d1c-8762-9c966cf2bd34_생크림 카스테라.jpg', 4, '21/09/08', 400);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '핑키 초코 케이크', 32000, 10, '생크림케이크에 초코크림과 땅콩을 넣은 초코시럽으로 글레이징 해주고 핑크로 포인트를 준 귀염뽀짝한 케이크입니다.', 'img/2211ae8b-5903-456e-831f-86b0be71afe5_초코생크림케이크.jpg', 4, '21/09/08', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '베리 생크림 케이크(1)', 38000, 10, '베리 생크림케이크는 파운드시트가 사용되어 기본 생크림케이크와는 달리 좀 더 묵직하며 맛의 무게감이 있고 직접 만든 블루베리 콩포트가 사용되어 달지 않은 케이크를 좋아하시는 분들에게 추천해드립니다.', 'img/ba96b246-9545-44d4-8cc3-0683ca46455d_생크림 케이크.jpg', 4.5, '21/09/08', 100);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '너트와 브라우니', 28000, 10, '호두와 마카다미아 그리고 초코칩이 더해져 겉은 바삭하면서도 속은 쫀득쫀득한 식감인 브라우니 입니다 =)', 'img/35b7bcba-ddd4-43ab-8b96-690e4f3753e8_브라우니.jpg', 4.3, '21/09/08', 400);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '초코 도넛(개당)', 3800, 10, '무난한 초코도넛은 식상하시다구요~? 다양한 토핑들이 올라가있어 고르는 재미도 있는 초코도우넛과 함께 달달구리한 도넛하세요 =)', 'img/d025360b-f8e8-4ba8-859f-074b7542ea54_촉촉한 초코도넛.jpg', 4.2, '21/09/08', 400);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '딸기잼 도넛(개당)', 3600, 10, '바닐라빈 그득한 플레인 도우넛에 직접 만든 딸기잼으로 채워 입안 가득 딸기향 머금게 해주는 딸기잼도우넛입니다 =)', 'img/딸기잼도우넛.jpg', 4.3,  '21/09/08', 400);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '마들렌 세트(4개입)', 11900, 10, '상큼한 맛의 레몬, 고소한 맛의 쑥, 단짠단짠의 맛인 크림치즈 당근, 커피 시럽 박힌 더티 티라미수 총 4개입으로 다양하게 구성되어있습니다 =)', 'img/ccaec036-42f0-4a8d-be81-aed835850a3e_마들렌.jpg', 4.8, '21/09/08', 500);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '얼그레이 초코 도넛(개당)', 3900, 10, '얼그레이와 초코는 믿고 먹는 조합이쥬! 얼그레이를 좋아하신다면 모두 얼그레이 초코 도넛 앞으로 집합!!', 'img/71a6ce9c-b079-4b1e-a564-b0bcd4eb77d4_초코얼그레이도우넛.jpg', 4.8, '21/09/08', 400);
insert into product_info(prod_id, prod_name, prod_price, prod_count, prod_desc, prod_imgsrc, prod_rating, prod_date, catecode) values(prod_id_seq.nextval, '초코칩 왕창 박힌 스콘', 3400, 10, '초코칩이 그냥도 아니고 이름처럼 왕창 박혀있어 초코칩을 씹는건지 스콘을 먹는건지 헷갈릴 수 있지만 적당한 고소함과 달달함이 만나 최상의 고소달달한 스콘입니다 =)', 'img/b0b066ae-e6fe-40d7-9d98-08997e78ce4d_초코칩 왕창 박힌 스콘.jpg', 4, '21/09/08', 500);

insert into customer_info values('test', '홍길동', '$2a$10$2mmqE7qbFzCMk58RwMMIiesZJs70dw/cG8qVZjwrQ2f5vQMGQldYi', 'M', '010-0000-0000', '00/01/01', 'M', sysdate);

create table goods_category (
cateName varchar2(100) not null,
cateCode varchar2(30) not null,
cateCodeRef varchar2(30) null,
primary key(cateCode),
foreign key(cateCodeRef) references goods_category(cateCode)
);

create sequence tbl_goods_seq;

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('케익', 100, null);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('쿠키', 200, null);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('샌드위치', 300, null);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('빵', 400, null);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('디저트', 500, null);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('아이스', 600, null);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('마카롱', 700, null); 

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('초코케익', 1, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('고구마케익', 2, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('치즈케익', 3, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('빅토리아케이크', 4, 100);
insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('엠엔엔초코케이크', 5, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('특별한케이크', 6, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('파운드케이크', 7, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('핑키초코케이크', 8, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('베리생크림케이크', 9, 100);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('오레오', 10, 200);

insert into goods_category( CATENAME, CATECODE, CATECODEREF)
values ('초코쿠키', 11, 300);

create table product_review(
order_seq number not null,
prod_id int not null,
cust_id varchar2(50), 
prod_review varchar2(4000),
prod_rating int, 
review_imgsrc varchar2(200),
review_date date
);

create table qna(
qna_id number,
child_level number not null,
parent_level number, 
title varchar2(100),
content varchar2(1000),
cust_id varchar(100),
writerDate date,
privateFlag char(2),
password varchar2(50),
constraint qna_id_pk primary key(qna_id)
);

create sequence qna_seq;
create sequence seq_child_level;

create table product_choice(
cust_id varchar(50),
prod_id int
);

commit;
