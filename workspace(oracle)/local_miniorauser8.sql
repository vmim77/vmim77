show user;
-- USER이(가) "MINIORAUSER8"입니다.

select * from tab;

select * from tbl_book;

select * from tbl_lib;

select * from tbl_member;

select * from tbl_lend;

select * from lend_detail;

select * from tbl_yeonche;



--------------------------------------------------------------------------------

set hidden param parseThreshold = 150000;

show user;
-- USER이(가) "MINIORAUSER8"입니다.
----- Mini Project -----

create table tbl_country
(country_code   varchar2(5)
,country_name   varchar2(30)
,constraint PK_TBL_COUNTRY_COUNTRY_CODE primary key(country_code)
);
-- Table TBL_COUNTRY이(가) 생성되었습니다.

insert into tbl_country(country_code, country_name)
values(1, '한국');

insert into tbl_country(country_code, country_name)
values(2, '외국');

select *
from tbl_country;

commit;

create table tbl_genre
(genre_code         varchar2(5)
,fk_country_code    varchar2(5)
,genre_name         varchar2(50)
,constraint PK_TBL_GENRE_GENRE_CODE primary key(genre_code)
,constraint FK_TBL_GENRE_FK_COUNTRY_CODE foreign key(fk_country_code) references tbl_country(country_code)
);
-- Table TBL_GENRE이(가) 생성되었습니다.

insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('A', 1, '소설');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('B', 1, '에세이');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('C', 1, '사회과학');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('D', 1, '경제경영');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('E', 1, '자기계발');

insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('F', 2, '소설');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('G', 2, '인문/사회');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('H', 2, '자기계발');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('I', 2, '경제경영');
insert into tbl_genre(genre_code, fk_country_code, genre_name)
values('J', 2, '자연과학');

select *
from tbl_genre;

COMMIT;

create table tbl_sub_code
(sub_code       varchar2(10)
,fk_genre_code  varchar2(5)
,sub_name       varchar2(50)
,constraint PK_TBL_SUB_CODE_SUB_CODE primary key(sub_code)
,constraint FK_TBL_SUB_CODE_FK_GENRE_CODE foreign key(fk_genre_code) references tbl_genre(genre_code)
);
-- Table TBL_SUB_CODE이(가) 생성되었습니다.4

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('a01', 'A', '한국소설');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('a02', 'A', '한국 시');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('b01', 'B', '한국에세이');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('b02', 'B', '동물에세이');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('c01', 'C', '비평/칼럼');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('c02', 'C', '사회문제');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('d01', 'D', '경제학');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('d02', 'D', '마케팅');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('e01', 'E', '비평/칼럼');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('e02', 'E', '사회문제');
--
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('f01', 'F', '미국소설');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('f02', 'F', '가족소설');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('g01', 'G', '사회과학');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('g02', 'G', '심리학');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('h01', 'H', '감정');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('h02', 'H', '꿈');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('i01', 'I', '광고/PR');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('i02', 'I', '연구개발(R/D)');

insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('j01', 'J', '일반과학');
insert into tbl_sub_code(sub_code, fk_genre_code, sub_name)
values('j02', 'J', '자연과학');

select *
from tbl_sub_code;

COMMIT;

create table tbl_lib
(isbn           varchar2(50)
,fk_sub_code    varchar2(10)
,bookname       varchar2(100)
,writer         varchar2(100)
,publisher      varchar2(25)
,price          varchar2(10)
,constraint PK_TBL_LIB_ISBN primary key(isbn)
,constraint FK_TBL_LIB_SUB_CODE foreign key(fk_sub_code) references tbl_sub_code(sub_code)
);
-- Table TBL_LIB이(가) 생성되었습니다.

delete from tbl_lib;

commit;

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791167370280', 'a01', '완전한 행복', '정유정', '은행나무', '14220');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791165343729', 'a01', '달러구트 꿈 백화점2', '이미예', '팩토리나인', '12420');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9788936427337', 'a02', '여름 언덕에서 배운 것', '안희연', '창비', '8100');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9788932024622', 'a02', '수학자의 아침2', '김소연', '문학과지성사', '8100');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9788934985051', 'b01', '햇빛은 찬란하고 인생은 귀하니까요', '장명숙', '김영사', '13320');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9788968970870', 'b01', '아직 끝이 아니다', '김연경', '가연', '13320');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791196688363', 'b02', '노견일기 5', '정우열', '동그람이', '13500');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791165796396', 'b02', '아기 판다 푸바오', '에버랜드 동물원', '시공주니어', '16200');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791157845286', 'c01', '눈 떠보니 선진국', '박태웅', '한빛비즈', '14850');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791191825022', 'c01', '모두가 기분 나쁜 부동산의 시대', '김민규', '빅피시', '14850');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791164136452', 'c02', '공정하다는 착각', '마이크 샌델', '와이즈베리', '16200');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791197510601', 'c02', '나의 무섭고 애처로운 환자들', '차승민', '아몬드', '15300');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791191360196', 'd01', '미래의 부', '이지성', '차이정원', '15300');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791190977265', 'd01', '부의 시나리오', '오건영', '페이지2', '16200');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791190242868', 'd02', '메타버스 새로운 기회 ', '김상균', '베가북스', '15300');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791155811856', 'd02', '무기가 되는 스토리', '도널드 밀러', '윌북', '16200');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9788997396870', 'e01', '오은영의 화해', '오은영', '코리아닷컴', '14400');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791187142560', 'e01', '데일 카네기 인간관계론', '데일 카네기', '현대지성', '10350');

insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9788950994761', 'e02', '내 마음을 나도 모를 때', '양재진', '21세기북스', '14400');
insert into tbl_lib(isbn, fk_sub_code, bookname, writer, publisher, price)
values('9791158511982', 'e02', '멘탈의 연금술', '보도 섀퍼', '토네이도', '14400');

commit;

select *
from tbl_lib;



create table tbl_book
(bookno         varchar2(50)
,fk_isbn        varchar2(50) not null
,status         varchar2(5) default 0
,constraint PK_TBL_BOOK_BOOKNO  primary key(bookno)
,constraint FK_TBL_BOOK_FK_ISBN foreign key(fk_isbn) references tbl_lib(isbn) on delete cascade
,constraint UQ_TBL_BOOK_FK_ISBN unique(fk_isbn)
);
-- Table TBL_BOOK이(가) 생성되었습니다.


create sequence seq_tbl_book
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



commit;

select *
from tbl_book;

create table tbl_admin
(admin_id       varchar2(50)
,passwd         varchar2(50)
,admin_name     varchar2(30)
,constraint PK_TBL_ADMIN_ADMIN_ID   primary key(admin_id)
);
-- Table TBL_ADMIN이(가) 생성되었습니다.

select *
from tbl_admin;
alter table tbl_admin rename column admin_id to adminid;

create table tbl_member
(user_id        varchar2(50)
,passwd         varchar2(50)
,name           varchar2(30)
,birthdate      date
,mobile         varchar2(50)
,address        varchar2(100)
,constraint PK_TBL_MEMBER_USER_ID primary key(user_id)
);
-- Table TBL_MEMBER이(가) 생성되었습니다.

select *
from tbl_member;

select *
from tbl_admin;




alter table tbl_member 
add email varchar2(50);

alter table tbl_member add constraint UQ_TBL_MEMBER_EMAIL unique(email);
alter table tbl_member modify email not null;
alter table tbl_member rename column user_id to userid;


select *
from tbl_member;

insert into tbl_member(userid, paawd, brithdate, mobile, address, email)
values('seokj', '1234', '95/10/01', '010-9999-8888', '서울시 마포구', 'seokj@naver.com'); 

select *
from user_constraints
where table_name = 'TBL_MEMBER';

create table tbl_lend
(lend_code      number
,fk_user_id     varchar2(50)
,fk_admin_id    varchar2(50)
,lend_date      date
,constraint PK_TBL_LEND_LEND_CODE primary key(lend_code)
,constraint FK_TBL_LEND_FK_USER_ID foreign key(fk_user_id) references tbl_member(user_id) on delete cascade
,constraint FK_TBL_LEND_FK_ADMIN_ID foreign key(fk_admin_id) references tbl_admin(admin_id)
);
-- Table TBL_LEND이(가) 생성되었습니다.

ALTER TABLE tbl_lend DROP CONSTRAINT FK_TBL_LEND_FK_USER_ID;
alter table tbl_lend add constraint FK_TBL_LEND_FK_USER_ID foreign key(fk_user_id) references tbl_member(userid) on delete cascade;


create sequence seq_lend
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


select * 
from tbl_lend;

select * 
from lend_detail;








select *
from tab;

desc lend_detail;


create table lend_detail
(lend_d_code        number
,fk_lend_code       number
,fk_isbn            varchar2(50) 
,return_date        date default sysdate + 7
,constraint PK_LEND_DETAIL_LEND_D_CODE primary key(lend_d_code)
,constraint FK_LEND_DETAIL_FK_LEND_C foreign key(fk_lend_code) references tbl_lend(lend_code)
,constraint FK_LEND_DETAIL_FK_ISBN foreign key(fk_isbn) references tbl_book(fk_isbn) on delete cascade
);

select *
from tab;

select *
from tbl_lend;

ALTER TABLE lend_detail DROP CONSTRAINT FK_LEND_DETAIL_FK_ISBN;
alter table lend_detail add constraint FK_LEND_DETAIL_FK_ISBN foreign key(fk_isbn) references tbl_book(fk_isbn) on delete cascade;

select *
from lend_detail



-- Table LEND_DETAIL이(가) 생성되었습니다.
create sequence seq_lend_d
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select * 
from lend_detail;

update lend_detail set return_date = sysdate + 7;
commit;


create table tbl_yeonche
(yc_code        varchar2(50)
,yc_date        varchar2(100)
,yc_fee         number
,fk_userid      varchar2(100)
,fk_lend_d_code number
,constraint PK_TBL_YEONCHE_YC_CODE primary key(yc_code)
,constraint FK_TBL_YEONCHE_FK_USER_ID foreign key(fk_userid) references tbl_member(userid)
,constraint FK_TBL_YEONCHE_FK_LEND_D_ID foreign key(fk_lend_d_code) references lend_detail_history(lend_d_code)
);
-- Table TBL_YEONCHE이(가) 생성되었습니다.


ALTER TABLE tbl_yeonche DROP CONSTRAINT FK_TBL_YEONCHE_FK_USER_ID;
alter table tbl_yeonche add constraint FK_TBL_YEONCHE_FK_LEND_D_ID foreign key(fk_lend_d_code) references lend_detail_history(lend_d_code);



drop table tbl_yeonche purge;

create sequence seq_yeonche
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


create table tbl_lend_history
(lend_code      number
,fk_user_id     varchar2(50)
,fk_admin_id    varchar2(50)
,lend_date      date
);
-- Table TBL_LEND이(가) 생성되었습니다.

drop table tbl_lend_history purge;
-- Table TBL_LEND_HISTORY이(가) 삭제되었습니다.


create table lend_detail_history
(lend_d_code        number
,fk_lend_code       number
,isbn               varchar2(50)
,return_date        date
);
-- Table LEND_DETAIL_HISTORY이(가) 생성되었습니다.
alter table lend_detail_history add constraint PK_LEND_DETAIL_HISTORY PRIMARY KEY(LEND_D_CODE);

drop table lend_detail_history purge;

rollback;
commit;


select *
from tbl_lend A JOIN lend_detail B
on A.lend_code = B.fk_lend_code

update lend_detail set return_date ='21/08/10'
where fk_lend_code = 55;

commit;


select *
from tbl_lend;

select * 
from lend_detail;

commit;


select lend_code, userid, lend_date, isbn, return_date, bookname
from 
(
select A.lend_code AS lend_code
, A.fk_user_id AS userid
, A.lend_date AS lend_date
, B.fk_isbn AS isbn
, B.return_date AS return_date
, C.bookname AS bookname
from tbl_lend A
join lend_detail B
on A.lend_code = B.fk_lend_code
join tbl_lib C
on B.fk_isbn = C.isbn
) D
where userid = 'eomjh';

commit;

select *
from lend_detail


select * 
from tbl_lend;

select a.sid, a.serial#
from v$session a, v$lock b, dba_objects c
where a.sid=b.sid and b.id1=c.object_id and b.type='TM' and c.owner='MINIORAUSER8' and  c.object_name='LEND_DETAIL';  


select fk_user_id, return_date, count(*)
from tbl_lend A JOIN lend_detail B
on A.lend_code = B.fk_lend_code
where 
group by fk_user_id, return_date 


commit;
select  *
from tbl_lend;

select lend_code, userid, lend_date, isbn, return_date, current_date
, case when current_date - return_date > 0 then 0 else 1 end AS yeonche
from
(
    select A.lend_code AS lend_code
         , A.fk_user_id AS userid
         , A.lend_date AS lend_date
         , B.fk_isbn AS isbn
         , to_date(to_char(B.return_date, 'yyyy-mm-dd')) AS return_date
         , to_date(to_char(sysdate, 'yyyy-mm-dd')) AS current_date
    from tbl_lend A JOIN lend_detail B
    on A.lend_code = B.fk_lend_code
) D
where isbn = ?


select * 
from tbl_yeonche;

desc tbl_book;


select *
from
(
    select A.lend_code AS lend_code
         , A.fk_user_id AS userid
         , A.lend_date AS lend_date
         , B.fk_isbn AS isbn
         , to_char(B.return_date, 'yyyy-mm-dd') AS return_date
         , to_char(sysdate, 'yyyy-mm-dd') AS current_date
         , B.lend_d_code as lend_d_code
    from tbl_lend A JOIN lend_detail B
    on A.lend_code = B.fk_lend_code
) D
where userid = 'leess';

select *
from tbl_lend
where fk_user_id = 'leess';


select * 
from tbl_lend;

select * 
from lend_detail;


select *
from lend_detail;

commit;

select *
from tbl_yeonche;

select * 
from lend_detail;

select *
from tbl_lend;

update lend_detail set return_date = '21/08/01';

commit;

select * 
from tbl_lend A LEFT JOIN lend_detail B
on A.lend_code = B.fk_lend_code
where fk_user_id = 'leess'
order by 1 asc;
    
select * 
from tbl_lib;




commit;



select * from tbl_book;

update tbl_book set status = 0;
commit;


select * from tbl_book;


select * from tbl_lend;


commit


select * from lend_detail;




select * from tbl_yeonche;

delete from tbl_yeonche;
commit;


select *
from user_constraints
where table_name = 'LEND_DETAIL_HISTORY';