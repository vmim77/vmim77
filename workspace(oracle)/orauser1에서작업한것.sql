show user;
-- USER이(가) "ORAUSER1"입니다.

select * 
from tab;

select *
from user_tables;
   
select * 
from HR.employees;
-- ORA-00942: table or view does not exist
-- HR.employees 테이블에 select 할 수 있는 권한이 없다라는 것이다.


select * 
from HR.employees;

update HR.employees set last_name = 'King'
where employee_id = 100;
-- SQL 오류: ORA-01031: insufficient privileges
-- HR 소유의 employees 테이블에서 select를 할 수 있는 권한만 있고, update를 할 수 있는 권한은 없는 것이다.


update HR.employees set last_name = 'King'
where employee_id = 100;
-- 1 행 이(가) 업데이트되었습니다.

commit;

delete from HR.employees
where department_id is null;
-- SQL 오류: ORA-01031: insufficient privileges
-- HR 소유의 employees 테이블에서 delete 할 권한이 없다라는 것이다.

delete from HR.employees
where department_id is null;
-- 1 행 이(가) 삭제되었습니다.

rollback;
-- 롤백 완료.


-----------------------------------------------------07월 27일 오전수업--------------------------------------------

create table tbl_emp
(empno      number(4)
,ename      varchar2(20)
);
-- Table TBL_EMP이(가) 생성되었습니다.

insert into tbl_emp(empno, ename) values(1001, '홍길동');

commit;

select *
from orauser1.tbl_emp;
-- 원래는 소유주명.테이블명 인데 소유주명을 생략하면 현재 오라클서버에 접속한 사용자 자기자신의 것으로 본다.

select *
from tbl_emp;

grant select on tbl_emp to hr;
-- Grant을(를) 성공했습니다.

---------------------------------------------------------------------------------
select *
from user_tables;

select *
from ALL_tables;  
