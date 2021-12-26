show user;
-- USER이(가) "HR"입니다.

select * from dba_users;
-- ORA-00942: table or view does not exist
-- dba_users 은 관리자만 조회할 수 있는 것이지 일반 사용자인 hr 은 조회가 불가하다는 말이다.


-- *** ORACLE 은 관계형 데이터베이스(Relation DataBase) 관리 시스템(Management System) 이다. ***
--               RDBMS(Relation DataBase Management System)
--     관계형 데이터베이스는 데이터를 열(Column, Field) 과 행(Row, Record, tuple) 으로 이루어진 테이블(Table, entity, 개체) 형태로 저장한다. 


-- ** 현재 오라클 서버에 접속되어진 사용자(지금은 hr)가 만든(소유의) 테이블(Table) 목록을 조회하겠다.

select * 
from tab;

/*
    TNAME            TABTYPE   
    ------------------------
    COUNTRIES	      TABLE	
    DEPARTMENTS	      TABLE	
    EMPLOYEES	      TABLE	
    EMP_DETAILS_VIEW  VIEW    (VIEW는 테이블은 아니지만 select 되어진 결과물을 마치 테이블 처럼 보는 것)	
    JOBS	          TABLE	
    JOB_HISTORY	      TABLE	
    LOCATIONS	      TABLE	
    REGIONS	          TABLE	
*/

select *
from DEPARTMENTS;   -- sql 명령어는 대, 소문자를 구분하지 않습니다.

SELECT *
FROM DEPARTMENTS;

SelECT *
FrOM DEPARTMENTS;

        -- 컬럼명과 테이블명도 대, 소문자를 구분하지 않습니다.

select department_id, department_name, manager_id, location_id        
from departments;

select DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID        
from departments;

select depaRtment_id, department_name, maNAGer_id, locaTION_ID        
from departments;

select * 
from departments  -- 저장되어진 데이터값 만큼은 반드시 대, 소문자를 구분합니다.!!!
where department_name = 'Sales';

select * 
from departments  -- 저장되어진 데이터값 만큼은 반드시 대, 소문자를 구분합니다.!!!
where department_name = 'SALES';

select * 
from departments  -- 저장되어진 데이터값 만큼은 반드시 대, 소문자를 구분합니다.!!!
where department_name = 'sales';

-------------------------------------------------------------------------------------------------

select * 
from departments; -- "부서" 테이블

describe departments; -- departments 테이블의 컬럼(column)의 정보를 알려주는 것이다.
-- 또는 
desc departments;

/*
이름                                   널?                                                                             유형           
---------------                     --------                                                                      ------------ 
DEPARTMENT_ID (부서번호)              NOT NULL ==> NOT NULL 은 반드시 데이터를 입력해야 한다는 뜻이다.                        NUMBER(4)     ==> 숫자타입 NUMBER(4)은  -9999~9999                                                  
DEPARTMENT_NAME(부서명)               NOT NULL                                                                       VARCHAR2(30)   ==> 문자열타입 최대 30byte 까지 입력가능함.
MANAGER_ID     (부서장의 사원번호)               ==> 없는 것이나 NULL 은 같은것인데 데이터를 입력하든 입력하지 않든 모두 허용한다.    NUMBER(6)    ==>   NUMBER(6)은 -999999 ~ 999999  NUMBER(6,2) 전체가 6자리 중에, 소수가 2자리 ==> -9999.99
LOCATION_ID     (부서위치ID)                                                                                           NUMBER(4)    ==> NUMBER(4) 은 -9999~9999
*/

select *
from EMPLOYEES; -- "사원" 테이블

desc employees;

/*
이름                                             널?             유형           
--------------                                 -------- ------------ 
EMPLOYEE_ID     (사원번호)                      NOT NULL         NUMBER(6)    
FIRST_NAME      (이름)                                         VARCHAR2(20) 
LAST_NAME       (성)                           NOT NULL        VARCHAR2(25) 
EMAIL           (이메일)                        NOT NULL        VARCHAR2(25) 
PHONE_NUMBER    (연락처)                                        VARCHAR2(20) 
HIRE_DATE       (입사일자)                       NOT NULL        DATE         
JOB_ID          (직종ID)                        NOT NULL        VARCHAR2(10) 
SALARY          (기본급여)                                      NUMBER(8,2)   -999999.99 ~ 999999.99
COMMISSION_PCT  (커미션[수당]퍼센티지)                             NUMBER(2,2)  -0.99 ~ 0.99
MANAGER_ID      (직속상관[사수]의 사원번호)                         NUMBER(6)    
DEPARTMENT_ID   (해당사원이 근무하는 부서번호)                       NUMBER(4) 
*/


select * 
from LOCATIONS;     --부서의 위치정보를 알려주는 테이블

select *
from COUNTRIES;     -- 국가정보를 알려주는 테이블

select * 
from REGIONS;       -- 대륙정보를 알려주는 테이블

---------------------------------------------------------------------------------------------------

/*
    === 아주아주아주아주아주아주아주아주아주아주아주아주아주아주아주 중요 !!!!!!!!! ===
    === !!!!!! 필수 암기 !!!!!! ===
    
    === 어떠한 테이블(또는 뷰)에서 데이터 정보를 꺼내와 보는 명령어인 select 의 처리 순서 ===
    
    select 컬럼명, 컬럼명          -- 5 컬럼명 대신에 *(아스테리크, asterisk) 을 쓰면 모든 컬럼을 뜻하는 것이다.
    from 테이블명(또는 뷰명)        -- 1 
    where 조건절                  -- 2 where 조건절이 뜻하는 것은 해당 테이블명(또는 뷰명)에서 조건에 만족하는 행(row)을 메모리(RAM)에 로딩(올리는것)해주는 것이다. 
    group by 절                  -- 3 
    having 그룹함수조건절           -- 4
    order by 절                  -- 6
    
    
*/



------------------------------------------------------------------------------------------

---- *** NULL 을 처리해주는 함수 *** ----
---- NULL 은 존재하지 않는 것이므로 4칙연산(+ - * /)에 NULL 이 포함되어지면 그 결과는 무조건 NULL 이 된다.


1. NVL

    select '안녕하세요'
    from dual;  -- dual 은 select 다음에 나오는 값들을 화면에 보여주기 위한 용도로 쓰이는 가상테이블이다.
    
    select 1+2, 1+null, 3*0, null*0, 2-1, 2-null, 5/2, 5/null
    from dual;
    
    select nvl(7,3), nvl(null,3),
           nvl('이순신','거북선'), nvl(null, '거북선')
    from dual;


2. NVL2

    select nvl2(7,3,2), nvl2(null,3,2),
           nvl2('이순신','거북선','구국영웅'), nvl2(null, '거북선','구국영웅')
    from dual;
    
    
    
    select employee_id, first_name, last_name, job_id, salary, commission_pct, department_id
    from employees
    where department_id = 60;

    select * -- * 이므로 모든 컬럼들을 추출(select)해라는 말이다.
    from employees; -- where 절이 없으므로 employees 테이블에 저장되어져 있던 모든 행들을 메모리(RAM)에 퍼올린다.(Loading)

    select employee_id, first_name, last_name -- employee_id, first_name, last_name 컬럼들만 추출(Select)해라는 말이다.
    from employees; -- where 절이 없으므로 employees 테이블에 저장되어져 있던 모든 행들을 메모리(RAM)에 퍼올린다.(Loading)
    
    -- 월급은 기본급여(salary) + 수당( salary * commssion_pct )
    -- commission_pct 컬럼의 값이 null 이라면 수당이 없다는 말이고, commission_pct 컬럼의 값이 0.3 이라함은 기본급여(salary) * 0.3 이 실제 수당금액이다.
    
    select employee_id, first_name, last_name,salary,commission_pct,
            salary+(salary * commission_pct),
            NVL( salary +(salary * commission_pct), salary ),
            NVL2(commission_pct, salary +(salary * commission_pct), salary )
    from employees; 
    -- 107명을 모두 가져온다.
    -- 그냥 salary+(salary*commission_pct)를 하면 
    -- 중간중간에 사원들마다 커미션에 null이 있어서, null인 커미션 과 월급을 사칙연산을 하면 null값으로 되기때문에
    -- 월급들이 null로 변한다.
    

    select  employee_id AS "사원번호" -- 별칭(별명) alias
    , first_name "이름" -- 별칭(별명) alias 에서 as 는 생략이 가능하다.
    , last_name 성 -- 별칭(별명) alias 에서 "" 는 생략이 가능하다.
    , salary "기본 급여" -- 별칭(별명) alias 에서 공백을 주려면 반드시 "" 을 해야한다.
    , commission_pct 커미션퍼센티지
    , NVL( salary +(salary * commission_pct), salary ) 월급
    , NVL2(commission_pct, salary +(salary * commission_pct), salary ) 월급2
    from employees; 
    
    
    -------------- **** 비교연산자 **** --------------
    1. 같다                   =
    2. 같지않다                !=   <>   ^=
    3. 크다. 작다.             >     <
    4. 같거나크다, 같거나작다     >=      <=
    5. NULL 은 존재하지 않는 것이므로 비교대상이 될 수가 없다.
       그러므로 비교연산 ( = != <> ^= > < >= <= ) 을 할 수가 없다.
       그래서 비교연산을 하려면 nvl()함수, nvl2()함수를 사용하여 처리한다.
       
       
    -- employees 테이블에서 부서번호가 30번에 근무하는 사원들만
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요
    
    select employee_id 사원번호, first_name 이름, last_name 성, nvl( salary + ( salary * commission_pct ), salary ) 월급, department_id 부서번호
    from employees
    where DEPARTMENT_ID = 30;
    
    -- 오라클에서 컬럼들을 붙일때(연결할때)는 문자 타입이든 숫자 타입이든 날짜 타입이든 관계없이 || 를 쓰면 된다.
    select '대한민국' || '서울시' || 123 || sysdate
    from dual;
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명  
         , nvl( salary + ( salary * commission_pct ), salary ) as 월급
         , department_id as 부서번호 
    from employees
    where DEPARTMENT_ID = 30;
    
    
    -- employees 테이블에서 부서번호가 null인 사원들만
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명  
         , nvl( salary + ( salary * commission_pct ), salary ) as 월급
         , department_id as 부서번호 
    from employees
    where department_id = null;
    --> 데이터가 출력되지 않는다.
    --> 왜냐하면 null 은 존재하지 않는 것이므로 비교대상이 될 수 없다!!!
    
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호
    , nvl(department_id, -9999) as 부서번호
    from employees;
    
    
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호 
    from employees
    where nvl(department_id, -9999) = -9999;
    
    
    -- 또는
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호 
    from employees
    where department_id is null; -- NULL 은 is 연산자를 사용하여 구한다.
                                 -- department_id 컬럼의 값이 null 인 행들만 RAM(메모리)에 퍼올린다.
                                 
                                 
                                 
    -- employees 테이블에서 부서번호가 30번이 아닌 사원들만
    -- 사원번호, 사원명, 월급, 부서번호를 나타내세요
    --> 허나, 이렇게하면 부서번호가 null인 값은 나오지 않고있다.
    --> 따지고 보면, Kimberely Grant도 부서번호가 30이 아니여서 나와야 한다.
    
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호 
    from employees
    where department_id != 30;
--  where department_id <> 30;
--  where department_id ^= 30;

    desc employees;

   -- employees 테이블에서 부서번호가 30번이 아닌 사원들만
   -- 사원번호, 사원명, 월급, 부서번호를 나타내세요
   --> 부서번호가 null인 Kimberely Grant도 나온다.

    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호
    from employees
    where nvl(department_id, -9999) != 30;
    
    
    -- 또는
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호
    from employees
    where not nvl(department_id, -9999) = 30;
    
    
   -- employees 테이블에서 부서번호가 Null이 아닌 사원들만
   -- 사원번호, 사원명, 월급, 부서번호를 나타내세요
   
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호
   from employees
   where nvl(department_id, -9999) != -9999;
   
   -- 또는
    select employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명  
    , nvl( salary + ( salary * commission_pct ), salary ) as 월급
    , department_id as 부서번호
   from employees
   where not department_id is null;
   -- where department_id is not null;
   -- where nvl(department_id, -9999) != -9999;
    
    ----------------- ***** select 되어져 나온 데이터를 정렬(오름차순정렬, 내림차순정렬)하여 보여주기 ***** -----------
    
    -- salary 컬럼의 값을 오름차순 정렬하여 보여라
    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by salary asc;
    
    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by salary; -- asc 은 생략가능하다.
    
    -- salary 컬럼의 값을 내림차순 정렬하여 보여라
    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by salary desc; --- desc 은 생략불가능이다. 안 쓰면 오름차순이다.
    
    -- 월급의 오름차순으로 나타내세요.
    select employee_id, first_name, last_name
    , nvl( salary + ( salary * commission_pct), salary) AS 월급
    , department_id
    from employees
--  order by nvl( salary + ( salary * commission_pct), salary) asc;
--  order by 월급 asc;
    order by 4 asc;
    
    -- 월급의 오름차순으로 나타내세요.
    select employee_id, first_name, last_name
    , nvl( salary + ( salary * commission_pct), salary) AS 월급
    , department_id
    from employees
--  order by nvl( salary + ( salary * commission_pct), salary) desc;
--  order by 월급 desc;
    order by 4 desc;

    
    -- NULL 값이 있는 필드는 어떻게 정렬하는가?
    -- 정렬(오름차순정렬, 내림차순정렬)을 할때 null 은 존재하지 않는 것이므로
    -- 오라클에서는 NULL을 가장 큰것으로 간주를 해주고,  마이크로소프트사의 MS-SQL 에서는 반대로 NULL을 가장 작은것으로 간주한다.
    -- department_id 컬럼의 값을 오름차순 정렬하여 보이세요.
    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by 5 asc;
    -- 가장 큰 게 null이라고 나온다. ( null은 존재하지 않는 값이기 때문에 , 오라클은 null을 정렬식에서 가장 큰 것으로 본다.)
    
    
    -- department_id 컬럼의 값을 내림차순 정렬하여 보이세요.
    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by 5 desc;
    -- 가장 큰 게 null이라고 나온다. ( null은 존재하지 않는 값이기 때문에 , 오라클은 null을 정렬식에서 가장 큰 것으로 본다.)
    
    
    
    ------------------------- **** 1차정렬, 2차정렬에 대해서 알아봅니다. **** -------------------------
    
    -- employees 테이블에서 부서번호별 오름차순 정렬을 한 후에 동일한 부서번호내에서는 
    -- 월급의 내림차순으로 정렬하여 사원번호, 사원명 월급, 부서번호를 나타내세요
    
    select employee_id as 사원번호
        ,  first_name || ' ' || last_name as 사원명
        , nvl( salary + (salary * commission_pct), salary ) as 월급
        , department_id as 부서번호
    from employees
    order by 4 asc, 3 desc;     -- asc 은 생략가능함.
    --   1차정렬,  2차정렬
    
    select employee_id as 사원번호
        ,  first_name || ' ' || last_name as 사원명
        , nvl( salary + (salary * commission_pct), salary ) as 월급
        , department_id as 부서번호
    from employees
    order by 4, 3 desc;     -- asc 은 생략가능함.
     -- 1차정렬,  2차정렬 
     
  -- employees 테이블에서 수당퍼센티지가 null 인 사원들만 
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  
  select employee_id as 사원번호
  , first_name || ' ' || last_name as 사원명
  , nvl(salary + (salary * commission_pct), salary) as 월급
  , department_id as 부서번호
  from employees
  where commission_pct is null
  order by 4, 3 desc;
  
  -- employees 테이블에서 수당퍼센티지가 null 이 아닌 사원들만 
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  
  select employee_id as 사원번호
  , first_name || ' ' || last_name as 사원명
  , nvl(salary + (salary * commission_pct), salary) as 월급
  , department_id as 부서번호
  from employees
  where commission_pct is not null
  order by 4, 3 desc;
  
   -- employees 테이블에서 월급(기본급여+수당금여)이 10000 보다 큰 사람들만
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  
  select employee_id as 사원번호
  , first_name || ' ' || last_name as 사원명
  , nvl(salary + (salary * commission_pct), salary) as 월급
  , department_id as 부서번호
  from employees
  where nvl(salary + (salary * commission_pct), salary)>10000
  order by 4, 3 desc;
  
  -- employees 테이블에서 부서번호가 50번 부서가 아닌 사원들만
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  
  select employee_id as 사원번호
  , first_name || ' ' || last_name as 사원명
  , nvl(salary + (salary * commission_pct), salary) as 월급
  , department_id as 부서번호
  from employees
  where nvl(department_id, -9999) <> 50
  order by 4, 3 desc;
  
  --------------- ****** AND    OR  IN()    NOT 연산자 ****** ---------------
  
  --- employees 테이블에서 80번 부서에 근무하는 사원들중에 기본급여가 10000 이상인 사월들만
  --- 사원번호, 사원명,기본급여, 부서번호를 나타내세요.
  
  select employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 기본급여
      , department_id as 부서번호
  from employees
  where department_id = 80 and salary >= 10000;
  
  --- employees 테이블에서 30번, 60번, 80번 부서에 근무하는 사원들만
  --- 사원번호, 사원명,기본급여, 부서번호를 나타내세요.
  
  select employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 기본급여
      , department_id as 부서번호
  from employees
  where department_id = 30 or department_id = 60 or department_id = 80
  order by department_id asc;
  
  -- 또는
  
  select employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 기본급여
      , department_id as 부서번호
  from employees
  where department_id IN(30, 60, 80)
  order by department_id asc;
  
  --- employees 테이블에서 30번, 60번, 80번 부서에 근무하지 않는 사원들만
  --- 사원번호, 사원명,기본급여, 부서번호를 나타내세요.
  
  select employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 기본급여
      , department_id as 부서번호
  from employees
  where NVL(department_id, -9999) != 30 and NVL(department_id, -9999) != 60 and NVL(department_id, -9999) != 80
  order by department_id asc;
  
  -- 또는
  
  select employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 기본급여
      , department_id as 부서번호
  from employees
  where NVL(department_id, -9999) not in(30,60,80)
  order by department_id asc;
  
  -- 또는
  
  select employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 기본급여
      , department_id as 부서번호
  from employees
  where not NVL(department_id, -9999) in(30,60,80)
  order by department_id asc;
  
  
  -- employees 테이블에서 부서번호가 30, 50, 60번 부서에 근무하는 사원들중 
  -- 연봉(월급 * 12)이 20000 이상 60000 이하인 사원들만
  -- 사원번호, 사원명, 연봉(월급*12), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 연봉(월급*12)의 내림차순으로 나타내세요.
  
  select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , nvl(salary + (commission_pct * salary), salary) * 12 AS 연봉 
    , department_id AS 부서번호 
  from employees
  where department_id = 30 OR department_id = 50 OR department_id = 60 AND
          20000 <= nvl(salary + (commission_pct * salary), salary) * 12 AND 
          60000 >= nvl(salary + (commission_pct * salary), salary) * 12
  order by 4, 3 desc; --- 틀린 풀이이다.!!!!
  
  
  ---- **** !!!! AND 와 OR 가 혼용되어지면 우선순위 AND 가 먼저 실행된다. !!!! **** ----
  ----      !!!! 연산자에 있어서 가장 최우선은 괄호( ) 가 제일 우선한다.   !!!! **** ----
  
 select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , nvl(salary + (commission_pct * salary), salary) * 12 AS 연봉 
    , department_id AS 부서번호 
  from employees
  where (department_id = 30 OR department_id = 50 OR department_id = 60) AND
          20000 <= nvl(salary + (commission_pct * salary), salary) * 12 AND 
          60000 >= nvl(salary + (commission_pct * salary), salary) * 12
  order by 4, 3 desc; --- 올바른 풀이이다.!!!!

 -- 또는
  
  select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , nvl(salary + (commission_pct * salary), salary) * 12 AS 연봉 
    , department_id AS 부서번호 
  from employees
  where department_id in(30,50,60) AND
          20000 <= nvl(salary + (commission_pct * salary), salary) * 12 AND 
          60000 >= nvl(salary + (commission_pct * salary), salary) * 12
  order by 4, 3 desc; --> 올바른 풀이이다.!!!!
                      --> IN( ) 은 괄호가 있는 OR 이다.
  
  ------ ***** 범위를 나타낼때는 >= AND =< 를 사용할 수 있는데, 또한 between A and B 를 사용하여 나타낼 수 있다.
  ------ ***** 컬럼명 between A and B 은 컬럼명값이 A 이상 B 이하 까지를 뜻하는 것이다.
  select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , nvl(salary + (commission_pct * salary), salary) * 12 AS 연봉 
    , department_id AS 부서번호 
  from employees
  where department_id in(30,50,60) AND
         nvl(salary + (commission_pct * salary), salary) * 12 between 20000 and 60000
  order by 4, 3 desc; --> 올바른 풀이이다.!!!!
                      --> IN( ) 은 괄호가 있는 OR 이다.
                      
  /*                    
    대용량 데이터베이스인 경우 IN 연산자 보다는 OR 를 사용하기를 권장하고,
    대용량 데이터베이스인 경우 between A and B 보다는 >= AND =< 를 사용하기를 권장한다.
    왜냐하면 IN 연산자는 내부적으로 OR 로 변경된 후 실행되고, 
    between A and B 도 내부적으로 >= AND <= 으로 변경된 후 실행되기 때문이다.
    >> 데이터 처리속도가 배로 든다.
    
    --- 대용량 데이터베이스의 기준은 어떤 테이블의 행의 개수가 100만건을 넘을 경우를 말한다.
    --- 소규모 데이터베이스의 기준은 어떤 테이블의 행의 개수가 1만건 미만인 경우를 말한다.
                      
  */  
  
  
  
  /*
      employees 테이블에서 부서번호가 50, 80번 부서에 근무하지 않는 사원들중에 
      월급이 4000 이상인 사원들만 사원번호, 사원명, 월급, 부서번호를 나타내되
      부서번호의 오름차순으로 정렬한 후, 월급의 내림차순으로 정렬하여 출력하세요.
   */
   
   select employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , NVL(salary + (salary * commission_pct), salary) AS 월급
        , department_id AS 부서번호
   from employees
   where nvl(department_id, -9999) not in(50,80) and -- Kimberely grant 는 부서번호가 null이니 유의하자!!
        NVL(salary + (salary * commission_pct), salary) >= 4000
   order by 4, 3 desc;
   
   -- 또는
   
   select employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , NVL(salary + (salary * commission_pct), salary) AS 월급
        , department_id AS 부서번호
   from employees
   where nvl(department_id, -9999) != 50 and
         nvl(department_id, -9999) != 80 and
         NVL(salary + ( salary * commission_pct), salary) >= 4000
   order by 4, 3 desc;
   
   
   ----- ***** ===== 범위 연산자 ===== ***** -----
   --   >   <   >=  <=  between A and B
   
   --   범위 연산자에 사용되는 데이터는 숫자 뿐만 아니라 문자, 날짜 까지 모두 사용된다.
   
   --- *** === 현재 시각을 알려주는 것 === *** ---
   select sysdate, current_date, localtimestamp, current_timestamp, systimestamp
   from dual;
   -- 21/07/15	21/07/15    21/07/15 16:14:27.000000000 21/07/15 16:14:48.000000000 ASIA/SEOUL 21/07/15 16:15:08.821000000 +09:00
   
   /*
    날짜타입은 date 이다.
    date 타입의 기본적인 표현방식은 'RR/MM/DD' 으로 나타내어진다.
    RR 은 년도의 2자리만 나타내어주는데 50 ~ 99 는 1950 ~ 1999 을 말하는 것이다.
    RR 은 년도의 2자리만 나타내어주는데 00 ~ 49 는 2000 ~ 2049 을 말하는 것이다.
    MM 은 월이고, DD 는 일이다.
   */
   
   select sysdate
       , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')
       , to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss')
       , to_char(sysdate, 'yyyy-mm-dd pm hh:mi:ss')
   from dual;
   
   -- 21/07/15	2021-07-15 16:21:19	2021-07-15 오후 04:21:19	2021-07-15 오후 04:21:19
   
   desc employees;      -- HIRE_DATE      DATE(날짜)
   
   select employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , hire_date AS 입사일자
   from employees;
   
   
   update employees set hire_date = to_date('2006-12-31 09:00:00','yyyy-mm-dd hh24:mi:ss')
   where employee_id = 154;
   
   commit;
   
   -- employees 테이블에서 입사일자가 2005년 1월 1일 부터 2006년 12월 31일 까지 입사한 사원들만 
   -- 사원번호, 사원명, 입사일자를 나타내세요

   select employee_id AS 사원번호
        ,first_name || ' ' || last_name AS 사원명
        , hire_date AS 입사일자
   from employees
   where '05/01/01' <= hire_date AND hire_date <= '06/12/31'
   order by 3; -- 틀린 풀이 !!!!
   --- !!!! 중요 !!!! 날짜를 나타낼때 시,분,초가 없는 년,월,일만 나타내어주면 자동적으로 0시0분0초가 된다. ---
   --- 즉, 자정(그날의 시작)을 뜻한다.
   
   -- 년 / 월 / 일이 나오면 00시 00분 00초이다. 
   -- 우리는 12월 31일까지 모두 포함해야하는데 위처럼 쓰면 06/12/31/ 00:00:00이니 31일이 포함된거라 할 수 없다.
   
   
    select employee_id AS 사원번호
        ,first_name || ' ' || last_name AS 사원명
        , hire_date AS 입사일자
   from employees
   where '05/01/01' <= hire_date AND hire_date <= '07/01/01'
   order by 3; -- 올바른 풀이 !!!!
   
   
   
   
   'A' --> 65
   'a' --> 97
   '0' --> 48
   ' ' --> 32
   select ascii('A') , ascii('a'), ascii('0'), ascii(' ')
   from dual;
   --           65	          97	      48	      32


    select chr(65),  chr(97), chr(48), chr(32)
    from dual;   
    --          A	      a	       0       ' '	 
    
    -- employees 테이블에서 first_name 컬럼의 값이 'Elj' 부터 'I' 까지인 데이터를 가지는 사원들만 first_name 을 출력하세요
    
    select first_name
    from employees
    where 'Elj' <= first_name and first_name <= 'I'
    order by 1;
    
    -- 또는
    
    select first_name
    from employees
    where first_name between 'Elj' and 'I'
    order by 1;
    
    
    ------------------------- 07월 15일 퀴즈 복습 ----------------------------
    
    
    
    -- employees 테이블에서 부서번호별 오름차순 정렬을 한 후에 동일한 부서번호내에서는 
    -- 월급의 내림차순으로 정렬하여 사원번호, 사원명 월급, 부서번호를 나타내세요
    select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , nvl(salary + (salary * commission_pct), salary) AS 월급
    , department_id AS 부서번호
    from employees
    order by 4, 3 desc;
    
  -- employees 테이블에서 수당퍼센티지가 null 인 사원들만 
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  
  select employee_id AS 사원번호
  , first_name || ' ' || last_name AS 사원명
  , nvl(salary + (salary * commission_pct), salary) AS 월급
  , department_id AS 부서번호
  from employees
  where commission_pct is null
  order by 4, 3 desc;
  
  -- employees 테이블에서 수당퍼센티지가 null 이 아닌 사원들만 
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  
  select employee_id AS 사원번호
  , first_name || ' ' || last_name AS 사원명
  , nvl(salary + (salary * commission_pct), salary) AS 월급
  , department_id AS 부서번호 
  from employees 
  where commission_pct is not null
  order by 4, 3 desc;
  
  
  -- employees 테이블에서 월급(기본급여+수당금여)이 10000 보다 큰 사람들만
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
  select employee_id AS 사원번호
  , first_name || ' ' || last_name AS 사원명
  , nvl(salary + (salary * commission_pct), salary) AS 월급
  , department_id AS 부서번호
  from employees
  where nvl(salary + (salary * commission_pct), salary) > 10000
  order by 4, 3 desc;
  
  -- employees 테이블에서 부서번호가 50번 부서가 아닌 사원들만
  -- 사원번호, 사원명, 월급(기본급여+수당금액), 부서번호를 나타내되 
  -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 월급의 내림차순으로 나타내세요.
    select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , nvl(salary + (salary * commission_pct), salary) AS 월급
    , department_id AS 부서번호
    from employees
    where nvl(department_id, -9999) != 50
    order by 4, 3 desc; 
    
    -------------------------------------------------------------------------------------
    -- 07월 16일
    
    
    -- 어떤 테이블에 존재하는 행의 컬럼의 값을 변경하려고 할 때는 update 명령어를 사용해서 변경해준다.
    
    select *
    from employees
    where employee_id = 100; 
    -- 'Steven King'
    
    update employees  set first_name = '성현', last_name = '박'
    where employee_id = 100; --> 메모리(RAM)상에서 변경된 것이다.
    -- employees 테이블에서 사원번호가 100번인 행의 first_name 과 last_name을 변경해라
    -- 1 행 이(가) 업데이트되었습니다.
    
    select employee_id, first_name, last_name
    from employees
    where employee_id = 100; 
    -- '성현 박'
    
    commit; --> commit 을 해야만 메모리(RAM)상에 변경되어진 것을 실제 디스크(DISK) 파일에 적용시켜주는 것이다.
    -- 커밋 완료.
    
    update employees  set first_name = 'Steven', last_name = 'King'
    where employee_id = 100; --> 메모리(RAM)상에서 변경된 것이다.
    -- 원상복구
    -- 1 행 이(가) 업데이트되었습니다.
    
    select employee_id, first_name, last_name
    from employees
    where employee_id = 100; 
    -- 'Steven King'
    
    rollback; --> 메모리(RAM)상에 변경되어진 정보를 삭제해주는 것이다. 즉, 위에서 실행한 update 명령을 한 결과를 취소하겠다는 말이다.
    -- 롤백 완료.
    -- 메모리(RAM)에 올라간 변경되어진 정보 'Steven King' 을 삭제해준다.
    -- 다시 DISK의 파일에 저장된 '성현 박'을 출력한다.
    
    commit;
    
    select employee_id, first_name, last_name
    from employees
    where employee_id = 100;    
    -- '성현 박'
    
    update employees  set first_name = 'Steven', last_name = 'King'
    where employee_id = 100;
    
    commit;
    
    select employee_id, first_name, last_name
    from employees
    where employee_id = 100;   
    -- Steven King
    
    
    --- *** employees 테이블에 jubun(주민번호) 이라는 컬럼을 추가해봅니다. *** ---
    
    /*
        jubun(주민번호) 컬럼의 값을 입력할때는 '-' 는 빼고 숫자로만 입력할 것입니다.
        jubun(주민번호) 컬럼의 값을 입력할 때 맨 처음 첫자리에 0 이 들어올 수 있다.
        number 타입이 아니라 varchar2 타입으로 해야 한다.
        왜냐하면 number 타입으로 해주면 맨 앞에 입력한 값이 0 일때는 0이 생략되어지기 때문이다.
        맨 앞의 0 도 나오게 하려면 컬럼의 데이터 타입은 varchar2 가 되어야 한다.
    */
    
    alter table employees 
    add jubun varchar2(13); -- 컬럼추가하기
    -- Table EMPLOYEES이(가) 변경되었습니다.
    
    
    desc employees;
    -- JUBUN                   VARCHAR2(13)  
    -- MAX 13 byte
    -- 2000년생은 00 으로 주민번호가 시작되기 때문에 NUMBER 타입을 쓸 수 없다.
    
    
    select *
    from employees;
    
    update employees set jubun = '0107161234567'
    where employee_id = 100;
    
    commit;
    
    select employee_id, jubun
    from employees
    where employee_id = 100;
    -- 100	0107161234567
    
    alter table employees
    drop column jubun; -- jubun 이라는 컬럼을 삭제하기
    -- Table EMPLOYEES이(가) 변경되었습니다.
    
    select *
    from employees;
    
    alter table employees 
    add jubun number(13); -- 컬럼추가하기
    -- Table EMPLOYEES이(가) 변경되었습니다.
    
    desc employees;
    -- JUBUN                   NUMBER(13)  
    
    update employees set jubun = 0107161234567
    where employee_id = 100;
    
    select employee_id, jubun
    from employees
    where employee_id = 100;
    -- 100	107161234567
    -- NUMBER 는 맨 앞에 0이 오면 생략해버린다.
    
    rollback;
    
    alter table employees
    drop column jubun;
    -- jubun 컬럼 삭제
    
    alter table employees 
    add jubun varchar2(13);
    -- jubun 컬럼 추가
    
    select * 
    from employees;
    
    update employees set jubun = '6010151234567'  
    where employee_id = 100;

    update employees set jubun = '8510151234567'
    where employee_id = 101;
    
    update employees set jubun = '6510152234567'
    where employee_id = 102;
    
    update employees set jubun = '7510151234567'
    where employee_id = 103;
    
    update employees set jubun = '6110152234567'
    where employee_id = 104;
    
    update employees set jubun = '6510151234567'
    where employee_id = 105;
    
    update employees set jubun = '6009201234567'
    where employee_id = 106;
    
    update employees set jubun = '0803153234567'
    where employee_id = 107;
    
    update employees set jubun = '0712154234567'
    where employee_id = 108;
    
    update employees set jubun = '8810151234567'
    where employee_id = 109;
    
    update employees set jubun = '8908152234567'
    where employee_id = 110;
    
    update employees set jubun = '9005052234567'
    where employee_id = 111;
    
    update employees set jubun = '6610151234567'
    where employee_id = 112;
    
    update employees set jubun = '6710151234567'
    where employee_id = 113;
    
    update employees set jubun = '6709152234567'
    where employee_id = 114;
    
    update employees set jubun = '6110151234567'
    where employee_id = 115;
    
    update employees set jubun = '6009301234567'
    where employee_id = 116;
    
    update employees set jubun = '6110152234567'
    where employee_id = 117;
    
    update employees set jubun = '7810151234567'
    where employee_id = 118;
    
    update employees set jubun = '7909151234567'
    where employee_id = 119;
    
    update employees set jubun = '7702152234567'
    where employee_id = 120;
    
    update employees set jubun = '7009151234567'
    where employee_id = 121;
    
    update employees set jubun = '7111011234567'
    where employee_id = 122;
    
    update employees set jubun = '8010131234567'
    where employee_id = 123;
    
    update employees set jubun = '8110191234567'
    where employee_id = 124;
    
    update employees set jubun = '9012132234567'
    where employee_id = 125;
    
    update employees set jubun = '9406251234567'
    where employee_id = 126;
    
    update employees set jubun = '9408252234567'
    where employee_id = 127;
    
    update employees set jubun = '9204152234567'
    where employee_id = 128;
    
    update employees set jubun = '8507251234567'
    where employee_id = 129;
    
    update employees set jubun = '6511111234567'
    where employee_id = 130;
    
    update employees set jubun = '0010153234567'
    where employee_id = 131;
    
    update employees set jubun = '0005254234567'
    where employee_id = 132;
    
    update employees set jubun = '0110194234567'
    where employee_id = 133;
    
    update employees set jubun = '0412154234567'
    where employee_id = 134;
    
    update employees set jubun = '0503253234567'
    where employee_id = 135;
    
    update employees set jubun = '9510012234567'
    where employee_id = 136;
    
    update employees set jubun = '9510021234567'
    where employee_id = 137;
    
    update employees set jubun = '9610041234567'
    where employee_id = 138;
    
    update employees set jubun = '9610052234567'
    where employee_id = 139;
    
    update employees set jubun = '7310011234567'
    where employee_id = 140;
    
    update employees set jubun = '7310092234567'
    where employee_id = 141;
    
    update employees set jubun = '7510121234567'
    where employee_id = 142;
    
    update employees set jubun = '7612012234567'
    where employee_id = 143;
    
    update employees set jubun = '7710061234567'
    where employee_id = 144;
    
    update employees set jubun = '7810052234567'
    where employee_id = 145;
    
    update employees set jubun = '6810251234567'
    where employee_id = 146;
    
    update employees set jubun = '6811062234567'
    where employee_id = 147;
    
    update employees set jubun = '6712052234567'
    where employee_id = 148;
    
    update employees set jubun = '6011251234567'
    where employee_id = 149;
    
    update employees set jubun = '6210062234567'
    where employee_id = 150;
    
    update employees set jubun = '6110191234567'
    where employee_id = 151;
    
    update employees set jubun = '5712062234567'
    where employee_id = 152;
    
    update employees set jubun = '5810231234567'
    where employee_id = 153;
    
    update employees set jubun = '6311051234567'
    where employee_id = 154;
    
    update employees set jubun = '6010182234567'
    where employee_id = 155;
    
    update employees set jubun = '6110191234567'
    where employee_id = 156;
    
    update employees set jubun = '6210112234567'
    where employee_id = 157;
    
    update employees set jubun = '6311132234567'
    where employee_id = 158;
    
    update employees set jubun = '8511112234567'
    where employee_id = 159;
    
    update employees set jubun = '8710131234567'
    where employee_id = 160;
    
    update employees set jubun = '8710072234567'
    where employee_id = 161;
    
    update employees set jubun = '9010171234567'
    where employee_id = 162;
    
    update employees set jubun = '9112072234567'
    where employee_id = 163;
    
    update employees set jubun = '9110241234567'
    where employee_id = 164;
    
    update employees set jubun = '9212251234567'
    where employee_id = 165;
    
    update employees set jubun = '9310232234567'
    where employee_id = 166;
    
    update employees set jubun = '9811151234567'
    where employee_id = 167;
    
    update employees set jubun = '9810252234567'
    where employee_id = 168;
    
    update employees set jubun = '9910301234567'
    where employee_id = 169;
    
    update employees set jubun = '0910153234567'
    where employee_id = 170;
    
    update employees set jubun = '1011153234567'
    where employee_id = 171;
    
    update employees set jubun = '1006153234567'
    where employee_id = 172;
    
    update employees set jubun = '1111154234567'
    where employee_id = 173;
    
    update employees set jubun = '1209103234567'
    where employee_id = 174;
    
    update employees set jubun = '1207154234567'
    where employee_id = 175;
    
    update employees set jubun = '0906153234567'
    where employee_id = 176;
    
    update employees set jubun = '0812113234567'
    where employee_id = 177;
    
    update employees set jubun = '9810132234567'
    where employee_id = 178;
    
    update employees set jubun = '8712111234567'
    where employee_id = 179;
    
    update employees set jubun = '8310012234567'
    where employee_id = 180;
    
    update employees set jubun = '6510191234567'
    where employee_id = 181;
    
    update employees set jubun = '6510221234567'
    where employee_id = 182;
    
    update employees set jubun = '6510232234567'
    where employee_id = 183;
    
    update employees set jubun = '8512131234567'
    where employee_id = 184;
    
    update employees set jubun = '8510182234567'
    where employee_id = 185;
    
    update employees set jubun = '7510192234567'
    where employee_id = 186;
    
    update employees set jubun = '8512192234567'
    where employee_id = 187;
    
    update employees set jubun = '9511151234567'
    where employee_id = 188;
    
    update employees set jubun = '7509302234567'
    where employee_id = 189;
    
    update employees set jubun = '8510161234567'
    where employee_id = 190;
    
    update employees set jubun = '9510192234567'
    where employee_id = 191;
    
    update employees set jubun = '0510133234567'
    where employee_id = 192;
    
    update employees set jubun = '0810194234567'
    where employee_id = 193;
    
    update employees set jubun = '0910183234567'
    where employee_id = 194;
    
    update employees set jubun = '1010134234567'
    where employee_id = 195;
    
    update employees set jubun = '9510032234567'
    where employee_id = 196;
    
    update employees set jubun = '9710181234567'
    where employee_id = 197;
    
    update employees set jubun = '9810162234567'
    where employee_id = 198;
    
    update employees set jubun = '7511171234567'
    where employee_id = 199;
    
    update employees set jubun = '7810172234567'
    where employee_id = 200;
    
    update employees set jubun = '7912172234567'
    where employee_id = 201;
    
    update employees set jubun = '8611192234567'
    where employee_id = 202;
    
    update employees set jubun = '7810252234567'
    where employee_id = 203;
    
    update employees set jubun = '7803251234567'
    where employee_id = 204;
    
    update employees set jubun = '7910232234567'
    where employee_id = 205;
    
    update employees set jubun = '8010172234567'
    where employee_id = 206;
    
    commit;

    select *
    from employees;
    
    ---------------------------------------------------------------------------
    
    ------ ****** ====== like 연산자 ====== ****** ------
    
    select *
    from employees
    where department_id = 30;
    
    select *
    from employees
    where department_id like 30;
    
    
    /*
        like 연산자와 함께 사용되어지는 % 와 _ 를 wild character 라고 부른다.
        like 연산자와 함께 사용되어지는 % 의 뜻은 글자수와는 관계없이 글자가 있든지 없든지 관계없다라는 말이다.
        like 연산자와 함께 사용되어지는 _ 의 뜻은 반드시 아무글자 1개만을 뜻하는 것이다.
    */
    
    -- employees 테이블에서 여자 1990년생과 남자 1991년생의 사원들만 사원번호, 사원명, 주민번호를 나타내세요
    
    select employee_id as 사원번호
        , first_name || ' ' || last_name AS 사원명
        , jubun AS 주민번호
    from employees
    where jubun like '90____2%' OR jubun like '91____1%';
    
   -- employees 테이블에서 first_name 컬럼의 값이 'J'로 시작하는 사원들만
   -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
   
   select employee_id as 사원번호
        , first_name as 이름
        , last_name as 성
        , salary as 기본급여
   from employees
   where first_name like 'J%'; -- 뒤에 몇글자가 있던 상관없이, 반드시 J 로 시작하는 것들
    
    
   -- employees 테이블에서 first_name 컬럼의 값이 's'로 끝나느 사원들만
   -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
   
   select employee_id, first_name || ' ' || last_name, salary
   from employees
   where first_name like '%s'; -- 앞에 몇글자가 있던 상관없지만, 반드시 s 로 끝나는 것들
   

   -- employees 테이블에서 first_name 컬럼의 값중에 'ee' 라는 글자가 들어있는 사원들만
   -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
    
    select employee_id, first_name || ' ' || last_name, salary
    from employees
    where first_name like '%ee%'; -- ee 가 맨 앞, 중간, 맨 뒤에 나오든 상관없이 포함된 것
    
    
   -- employees 테이블에서 first_name 컬럼의 값중에 'e' 가 2개이상 들어있는 사원들만
   -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
    
    select employee_id, first_name || ' ' || last_name, salary
    from employees
    where first_name like '%e%e%'; -- 붙은 ee 든지, 떨어진 ee 든지 상관없이 e가 최소한 2개 이상인 것
    
    
  -- employees 테이블에서 last_name 컬럼의 값이 첫글자는 'F' 이고 두번째 글자는 아무거나 이고
  -- 세번째 글자는 소문자 'e' 이며 4번째 부터는 글자가 있든지 없든지 상관없는 사원들만 
  -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
  
  select employee_id, first_name, last_name, salary
  from employees
  where last_name like 'F_e%';
  
  --- *** like 연산자와 함께 사용되어지는 % 와 _인 wild character 의 escape(탈출) 시키기 *** ---
  
  create table tbl_watch
  (-- watchname varchar2(10)   -- varchar2(10) 은 최대 10 byte 까지만 허용. '쌍용교육센터' 는 12 byte라 입력불가, 'oracle' 는 6 byte 라 입력가능
  watchname Nvarchar2(10)      -- Nvarchar2(10) 은 최대 글자수 10 글자까지만 허용 '쌍용교육센터' 'oracle' 모두 입력가능
  , bigo    Nvarchar2(100)
  );
  -- Table TBL_WATCH이(가) 생성되었습니다.
  
  -- 어떤 테이블에 데이터(행) 입력할때는 insert 라는 명령어를 사용한다.
  
  select *
  from tbl_watch;
  
  insert into tbl_watch(watchname, bigo) values('금시계','순금 99.99% 함유 고급시계');
  -- 1 행 이(가) 삽입되었습니다.

  insert into tbl_watch(watchname, bigo) values('은시계','고객만족도 99.99점 획득한 고급시계');
  -- 1 행 이(가) 삽입되었습니다.
  
  -- rollback;
  
  select * 
  from tbl_watch;
  
  commit;
  -- 커밋 완료.
  
  
  
  -- tbl_watch 테이블에서 bigo 컬럼에 99.99% 라는 글자가 들어있는 행만 추출하세요. --
  
  select *
  from tbl_watch
  where bigo like '%99.99%%';
  -- like 와 함께 쓰이는 % 는 반드시 wild character 로 인식한다.
  -- & 라는 글자 자체를 원한다면 escape를 써야한다.
  
  
  select *
  from tbl_watch
  where bigo like '%99.99\%%' escape '\';
  -- escape 문자로 '\'을 주었으므로 '\' 다음에 나오는 % 1개만 wild character 기능에서 탈출시켜 버리므로 % 는 진짜 글자 퍼센트(%)로 된다.
  
  select *
  from tbl_watch
  where bigo like '%99.992%%' escape '2';
  -- escape 문자로 '2'을 주었으므로 '2' 다음에 나오는 % 1개만 wild character 기능에서 탈출시켜 버리므로 % 는 진짜 글자 퍼센트(%)로 된다.
  
  select *
  from tbl_watch
  where bigo like '%99.99a%%' escape 'a';
  -- escape 문자로 'a'을 주었으므로 'a' 다음에 나오는 % 1개만 wild character 기능에서 탈출시켜 버리므로 % 는 진짜 글자 퍼센트(%)로 된다.
  
  
  ------------------------------------------------------------------------------------
                ----- >> 단일행 함수 << ------
  
  /*
    ※ 단일행 함수의 종류
    
    1. 문자 함수
    2. 숫자 함수
    3. 날짜 함수
    4. 변환 함수
    5. 기타 함수
  */
  
    ---------- >> 1. 문자 함수 << -----------
                
    -- 1.1 upper('문자열') ==> '문자열'을 모두 대문자로 변환시켜주는 것이다.
    
    select 'kOreA SEoul', upper('kOreA SEoul')
    from dual;
    --      kOreA SEoul	        KOREA SEOUL
    
    -- 1.2 lower('문자열') ==> '문자열'을 모두 소문자로 변환시켜주는 것이다.
    select 'kOreA SEoul', lower('kOreA SEoul')
    from dual;
    --      kOreA SEoul	        korea seoul
    
    -- 1.3 initcap('문자열') ==> '문자열'을 단어별(구분자 공백) 첫글자만 대문자, 나머지는 모두 소문자로 변환시켜주는 것.
    select 'kOreA SEoul', initcap('kOreA SEoul')
    from dual;
    --      kOreA SEoul	            Korea Seoul
    
    
    select *
    from employees
    where last_name = 'King';
    
    select *
    from employees
    where initcap(last_name) = initcap('king');
    
    select last_name
    from employees
    where lower(last_name) = lower('KINg');
    
    select *
    from employees
    where upper(last_name) = upper('KING');
    
    
    -- 1.4 substr('문자열',시작글자번호,뽑아야할글자길이)
    --      ==> '문자열' 중에 문자열의 특정 일부분을 선택해올 때 사용한다.
    select '쌍용교육센터'
            ,substr('쌍용교육센터',2,3) -- '쌍용교육센터' 에서 2번째 글자인 '용'부터 3글자를 뽑는다.
            ,substr('쌍용교육센터',2) -- '쌍용교육센터' 에서 2번째 글자인 '용'부터 끝까지 뽑는다.
    from dual;
    -- 오라클은 index가 1부터 시작한다.
    -- 자바는 indext가 0부터 시작한다.
    
    -- 쌍용교육센터	용교육	용교육센터
    
    
    --- *** substr()함수를 사용하여 employees 테이블에서 성별이 '여자'인 사원들만 
    --      사원번호, 사원명, 주민번호를 나타내세요
    
    select employee_id AS 사원번호
        ,first_name || ' ' || last_name AS 사원명
        ,jubun AS 주민번호    
    from employees
    where substr(jubun, 7, 1) in ('2','4');
    -- 주민번호는 문자열이니 홑따옴표 필수
    
    --- *** substr()함수를 사용하여 employees 테이블에서 1990년 ~ 1995년에 태어난 사원들중
    --      성별이 '남자'인 사원들만
    --      사원번호, 사원명, 주민번호를 나타내세요
    
    select employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , jubun AS 주민번호
    from employees
    where  substr(jubun, 1, 2) between '90' and '95' AND 
           substr(jubun, 7, 1) = '1';
    -- 주민번호는 문자열이니 홑따옴표 필수
    
    
    -- 1.5 instr : 어떤 문자열에서 명명된 문자열의 위치를 알려주는 것
    select '쌍용교육센터 서울교육대학교 교육문화원'
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 1)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 2)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 1 번째 부터 2 번째로 나오는 '교육'의 위치를 찾는 것이다.
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4, 1)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 4 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4, 3)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 4 번째 부터 3 번째로 나오는 '교육'의 위치를 찾는 것이다.
           -- 그러한 값이 없다라면 0 이 나온다.
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
           -- 출발점만 나오면 뒤에 ,1 이 생략된 것이다.
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 4 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
           -- 출발점만 나오면 뒤에 ,1 이 생략된 것이다. 
    from dual;
    -- 없으면 0 을 출력한다. (자바는 -1 을 출력)
    -- 몇번째 글자를 찾을지 안 적어주면 자동으로 1 이다.
    
    
    -- 1.6 reverse : 어떤 문자열을 거꾸로 보여주는 것이다. **** ----
    select 'ORACLE', reverse('ORACLE')
           ,'대한민국', reverse('대한민국'), reverse(reverse('대한민국'))
           -- 한글은 reverse 를 사용하면 깨져 나온다.
           -- reverse했던 한글을 다시 reverse 하면 제대로 나온다.
    from dual;
    
    
    ------ [Quiz] -----
    create table tbl_files
    (fileno         number(3)
    ,filepath       varchar2(200)
    );
    
    insert into tbl_files(fileno, filepath) values(1, 'c:\myDocuments\resume.hwp');
    insert into tbl_files(fileno, filepath) values(2, 'd:\mymusic.mp3');
    insert into tbl_files(fileno, filepath) values(3, 'c:\myphoto\2021\07\face.jpg');
    
    commit;
    
    select fileno, filepath
    from tbl_files;
    
    
    --- 아래와 같이 나오도록 하세요. ---
    /*
    -------------------------------
    파일번호            파일명
    -------------------------------
    1	resume.hwp
    2	mymusic.mp3
    3	face.jpg
    -------------------------------
    */
    
    
    select fileno AS 파일번호
        , reverse(substr(reverse(filepath),1,instr(reverse(filepath),'\',1,1)-1)) AS 파일명
    from tbl_files;
    -- 거꾸로 만들고   reverse
    -- 첫번째 '\'까지 위치값 구하고 instr
    -- 거꾸로 만든 경로에서 첫번째부터 '\'의 앞의 위치까지 뽑고 substr
    -- 거꾸로인 상태에서 왼쪽이니 -1 pwh.emuser\
    -- 다시 거꾸로 reverse
    
    select fileno, filepath, reverse(filepath)
            , instr(reverse(filepath),'\',1)
            , substr(reverse(filepath),1,instr(reverse(filepath),'\',1)-1)
            , reverse(substr(reverse(filepath),1,instr(reverse(filepath),'\',1)-1))
    from tbl_files;
    
    
        select '쌍용교육센터 서울교육대학교 교육문화원'
        
           ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 1)
           -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
           -- 출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
           
            ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -1, 1)
            -- 교육문화원의 '원' 부터 출발 -- 16
            -- 출발점이 역순으로 1 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
            
            ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -5, 1)
            -- 교육문화원의 '교' 부터 출발 -- 16
            -- 출발점이 역순으로 5 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
            
            ,instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 2)
            -- 교육문화원의 '교' 부터 출발 -- 3
            -- 출발점이 역순으로 6 번째 부터 1 번째로 나오는 '교육'의 위치를 찾는 것이다.
            
        from dual;
        
        select fileno AS 파일번호
        , substr(filepath, instr(filepath, '\', -1)+1) AS 파일명
        -- substr( filepath, filepath에서 마지막으로 나오는 \의 위치값 + 1 )
        -- '\' 다음부터이니 instr()+1을 해준다.
        -- 원래 상태에서 오른쪽으로이니깐 +1 \resume.hwp
        from tbl_files;
        
        
        -- 1.7 lpad : 왼쪽부터 문자를 자리채움 *** -----
        -- 1.8 rpad : 오른쪽부터 문자를 자리채움 *** -----
        select lpad('교육센터',20,'*') -- 20 byte를 확보해서 거기에 '교육센터'를 넣는다. 넣은 후 빈공간(12byte)이 있으면 왼쪽부터 '*'로 채운다.
        -- ************교육센터
                                         
        , rpad('교육센터',20,'*') -- 20 byte를 확보해서 거기에 '교육센터'를 넣는다. 넣은 후 빈공간(12byte)이 있으면 오른쪽부터 '*'로 채운다.
        -- 교육센터************
        from dual;
        
        -- 1.9 ltrim : 왼쪽부터 문자를 제거한다. *** -----
        -- 1.10 rtrim : 오른쪽부터 문자를 제거한다. *** -----
        -- 1.11 trim:  왼쪽,오른쪽부터 공백문자를 제거한다. *** -----
        
        select ltrim('TabaacccdddSSS', 'abcd')
            ,rtrim('Tabaacccddd', 'abcd')
            ,rtrim( ltrim('abcdabdddaaTabaacccddd', 'abcd'), 'abcd')
        from dual;
        -- T는 abcd 중에 없기 때문에 T를 만나고 멈춘 다음에 그 이후 값을 모두 출력한다.
        -- 도중에 지울 문자가 아닌 문자가 나오면 작동을 멈춘다.
        -- 그냥 trim은 공백만 지우기 때문에, 특정문자를 못 쓴다. 'abcd'
        
        
        
        select '쌍용' || '                         교육                   센터'
                ,'쌍용' || ltrim('                          교육                   센터')
                -- 쌍용교육                   센터
                
        from dual;
        
        select '쌍용                    ' || '교육                   센터'
            , rtrim('쌍용                    ' )|| '교육                   센터'
            -- 쌍용교육                   센터
        from dual;
        -- ltrim 과 rtrim은 제거해야할 문자가 없으면, 각각 방향쪽부터 공백을 없앤다.
        
        
        select '쌍용' || '                 교육                  '|| '센터'
                , '쌍용' ||trim( '                 교육                  ')|| '센터'
        from dual;
        
        -- ltrim 은 제거할 문자가 없으면, 왼쪽 공백을 없앤다.
        -- rtrim 은 제거할 문자가 없으면, 오른쪽 공백을 없앤다.
        -- trim 은 제거할 문자가 들어와선 안되며, 양쪽 공백을 없앤다.
        
        -- 1.12 translate *** -------
        
        select translate('010-3456-7890'
                        ,'0123456789'
                        , '영일이삼사오육칠팔구')
        from dual;
        
        
        -- 1.13 replace *** -------
        
        select replace('쌍용교육센터 서울교육대학교 교육문화원'
                        ,'교육'
                        ,'education')
        from dual;
        
        
        select replace('대한민국만세 대한교육대학교 대한문화원'
	     ,'대한'
	     ,'大韓')
        from dual;
        
        -- 1.14 length ==> 문자열의 길이를 알려주는 것 *** ------
        select length('쌍용center')
        from dual;
        -- 8 글자
        
        select length('대한민국만세')
        from dual;
        
        
        
        ---------- >> 2. 숫자 함수 << -----------     
        
        -- 2.1 mod : 나머지를 구해주는 것 
        select 5/2, mod(5, 2), trunc(5/2)
        from dual;
        -- 5를 2로 나누었을 때의 나머지 : 1
        --     2.5       1       2
        -- 2.5에서 소수부를 절삭하면 몫이 된다.
        
        
        -- 2.2 round : 반올림을 해주는 것.
        select 94.547
            , round(94.547)     -- 95
            , round(94.547, 0)  -- 95     0 은 정수 1자리까지만 나타내어준다.
            , round(94.547, 1)  -- 94.5   1 은 소수 첫째자리까지만 나타내어준다.
            , round(94.547, 2)  -- 94.55  2 은 소수 둘째자리까지만 나타내어준다.
            , round(94.547, -1) -- 90    -1 은 정수 십의자리까지만 나타내어준다.
            , round(94.547, -2) -- 100   -2 은 정수 백의자리까지만 나타내어준다.
        from dual;
        
        
        -- 2.3 trunc : 절삭을 해주는 것.
        select 94.547
            , trunc(94.547)     -- 94
            , trunc(94.547, 0)  -- 94     0 은 정수 1자리까지만 나타내어준다.
            , trunc(94.547, 1)  -- 94.5   1 은 소수 첫째자리까지만 나타내어준다.
            , trunc(94.547, 2)  -- 94.54  2 은 소수 둘째자리까지만 나타내어준다.
            , trunc(94.547, -1) -- 90    -1 은 정수 십의자리까지만 나타내어준다.
            , trunc(94.547, -2) -- 0     -2 은 정수 백의자리까지만 나타내어준다.
        from dual;
        
        -- *** [성적처리] *** --
        create table tbl_sungjuk 
        (hakbun         varchar2(20)
        ,name           varchar2(20)
        ,kor            number(3)
        ,eng            number(3)
        ,math           number(3)
        );
        
        select *
        from tbl_sungjuk;
        
        -- *** 데이터 입력하기 *** --
        
        insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist001','한석규',90,92,93);
        insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist002','두석규',100,100,100);
        insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist003','셋석규',71,72,73);
        insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist004','넷석규',89,87,81);
        insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist005','오석규',60,50,40);
        insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist006','육석규',80,81,87);

        -- insert 는 commit 이나 rollback 을 해야한다.
        commit;
        
        ----------------------------------------------------------------------------------------------------------------------------------------------------------
        학번      성명      국어      영어      수학      총점      평균(소수부 첫째자리까지 나타내되 반올림) 학점(평균이 90 이상이면 'A', 80 이상이면 'B', ...... , 60 미만이면 'F')
        ----------------------------------------------------------------------------------------------------------------------------------------------------------
        
        select hakbun AS 학번
            , name AS 성명
            , kor AS 국어
            , eng AS 영어
            , math AS 수학
            , (kor+eng+math) AS 총점
            , round((kor+eng+math)/3, 1) AS 평균1
            , to_char( round((kor+eng+math)/3, 1), '999.0' ) AS 평균2
            , case trunc(round((kor+eng+math)/3, 1),-1)
              when 100 then 'A'
              when 90  then 'A'
              when 80  then 'B'
              when 70  then 'C'
              when 60  then 'D'
              else          'F'
              end AS 학점1
              
            , decode(trunc(round((kor+eng+math)/3, 1),-1), 100, 'A'
                                                         ,  90, 'A'
                                                         ,  80, 'B'
                                                         ,  70, 'C'
                                                         ,  60, 'D'
                                                         ,      'F') AS 학점2
        from tbl_sungjuk;
        
        -- 2.4 power : 거듭제곱
        select 2*2*2*2*2, power(2, 5)   -- 2의 5승
        from dual;
        
        -- 2.5 sqrt : 제곱근
        select sqrt(4), sqrt(16), sqrt(2), sqrt(3)
        from dual;
        
        -- 2.6 sin, cos, tan, asin, acos, atan
        select sin(90), cos(90), tan(90), asin(0.3), acos(0.3), atan(0.3)
        from dual;
        
        -- 2.7 log
        select log(10, 100)
        from dual;
        
        -- 2.8 sign ==> 결과값이 양수이라면 1, 결과값이 0 이라면, 결과값이 음수이라면 -1
        select sign(5-2), sign(5-5), sign(2-5)
        from dual;
        
        -- 2.9 ceil(실수) ==> 입력되어진 실수 보다 큰 최소의 정수를 나타내어준다.
        --     ceil(정수) ==> 입력되어진 정수를 그대로 나타내어준다.
        select ceil(10.1), ceil(-10.1), ceil(10), ceil(-10)
        from dual;
        --          11	        -10	         10	        -10
        
        -- 2.10 floor(실수) ==> 입력되어진 실수 보다 작은 최대의 정수를 나타내어준다.
        --      floor(정수) ==> 입력되어진 정수를 그대로 나타내어준다.
        select floor(10.1), floor(-10.1), floor(10), floor(-10)
        from dual;
        --           10	          -11	        10	       -10
        
        -- 2.11 ascii, chr
        select ascii('A'), ascii('a'), ascii(0), ascii(' ')
        from dual;
        --           65	         97	        48	       32
        
        select chr(65), chr(97), chr(48), chr(32)
        from dual;
        --         A	     a	      0	      ' '
        
        
        ---------- >> 3. 날짜 함수 << -----------
        
        /*
            날짜1 + 숫자 = 날짜2  ==> 날짜1 에서 숫자(일수)만큼 더한 값이 날짜2 가 된다.
            날짜1 - 숫자 = 날짜2  ==> 날짜1 에서 숫자(일수)만큼 뺀   값이 날짜2 가 된다.
            
            ※ 여기서 중요한 것은 숫자의 단위는 일수 이다.
        */
        
        select   sysdate - 1, to_char(sysdate-1, 'yyyy-mm-dd hh24:mi:ss') AS 어제시각
            , sysdate, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각
            , sysdate + 1, to_char(sysdate+1, 'yyyy-mm-dd hh24:mi:ss') AS 내일시각
        from dual;
        
        --- 단위환산 ---
        /*
            1 kg = 1000 g
            1 g = 1/1000 kg
            1 일 = 24 시간
            1 시간 = 1/24 일
            1 시간 = 60 분
            1 분 = 1/60 시간
            1 분 = 60 초
            1 초 = 1/60 분
        */
        
        --- *** 현재시각으로 부터 1일 2시간 3분 4초 뒤를 나타내세요 *** ---
        select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각
            ,  to_char(sysdate+1+(2/24)+(3/1440)+(4/86400), 'yyyy-mm-dd hh24:mi:ss') AS "1일 2시간 3분 4초뒤"
        from dual;
        -- 2021-07-19 10:22:59	2021-07-20 12:26:03
        
        -- 3.1 add_months(날짜, 숫자)
        /*
               ==> 콤마(,) 다음에 나오는 숫자가 양수이면 날짜에서 숫자 개월수 만큼 더해준 날짜를 나타낸다.
               ==> 콤마(,) 다음에 나오는 숫자가 음수이면 날짜에서 숫자 개월수 만큼 뺀    날짜를 나타낸다.
               
               ※ 여기서 숫자의 단위는 개월수 이다.
        */
        
        
        select to_char(add_months(sysdate, -2), 'yyyy-mm-dd hh24:mi:ss') AS "2개월 전 시각"
            ,  to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각
            ,  to_char(add_months(sysdate, 2), 'yyyy-mm-dd hh24:mi:ss')  AS "2개월 후 시각"
        from dual;
        
        ---- *** 내일 홍길동이 군대에 입대를 한다. 복무기간이 18개월 이라면 제대일자(년-월-일)를 구하세요
        select to_char(add_months(sysdate+1, 18), 'yyyy-mm-dd') AS 제대일자
        from dual;
        
        
        -- 3.2 months_between(날짜1, 날짜2)
        /*
            날짜1 에서 날짜2 를 뺀 값으로 그 결과는 숫자가 나오는데 결과물 숫자의 단위는 개월수 이다.
            즉, 두 날짜의 개월차이를 구할 때 사용한다.
        */
        
        select months_between( add_months(sysdate, 3), sysdate )
        from dual;
        
        -- **** 날짜1 - 날짜2  = 숫자 ==> 날짜1 에서 날짜2 를 뺀 값으로 숫자가 나오는데 결과물 숫자의 단위는 일수 이다.
        -- 즉, 두 날짜의 일수 차이를 구할 때 사용한다.
        select sysdate + 3 - sysdate
        from dual;
        -- 3 일 차이
        
        select add_months(sysdate, 1) - sysdate
        from dual;
        -- 31 일 차이
        
        -- 3.3 last_day(특정날짜)
        --    ==> 특정날짜가 포함된 달력에서 맨 마지막날짜를 알려주는 것이다.
        select last_day(sysdate)
        from dual;
        
        select add_months(sysdate,-1), last_day(add_months(sysdate,-1))
        from dual;
        
        select to_date('2021-02-10', 'yyyy-mm-dd') + 1
        from dual;
        
        
        select to_date('2020-02-10', 'yyyy-mm-dd'), last_day(to_date('2020-02-10', 'yyyy-mm-dd'))
            ,  to_date('2021-02-10', 'yyyy-mm-dd'), last_day(to_date('2021-02-10', 'yyyy-mm-dd'))
        from dual;
        
        -- 3.4 next_day(특정날짜, '일')      '일'~'토'
        -- ==> 특정날짜로 부터 다음번에 돌아오는 가장 빠른 '일'~'토'의 날짜를 알려주는 것이다.
        
        select sysdate
            ,  next_day(sysdate, '금') -- 가장 빠른 금요일은? 이번주 금요일 23일
            ,  next_day(sysdate, '월') -- 가장 빠른 월요일은? 다음주 월요일 26일
        from dual;
        -- 21/07/19	   21/07/23	  21/07/26
        
        
        
        -- 3.5 extract ==> 날짜에서 년, 월, 일을 숫자형태로 추출해주는 것이다.
        select sysdate
              , to_char(sysdate, 'yyyy'), extract(year from sysdate)
              , to_char(sysdate, 'mm'), extract(month from sysdate)
              , to_char(sysdate, 'dd'), extract(day from sysdate)
        from dual;
        -- to_char는 문자열로 바꿔서 왼쪽 정렬 / extract는 숫자여서 오른쪽 정렬됨
        -- 21/07/19	2021	2021	07	7	19	19
        
        
        
        -- 3.6 to_yminterval, to_dsininterval
        /*
            to_yminterval 은 년 과 월을 나타내어 연산자가 + 이면 날짜에서 더해주는 것이고,
            to_dsinterval 은 일 시간 분 초를 나타내어 연산자가 + 이면 날짜에서 더해주는 것이다.
            연산자가 - 를 쓰면 날짜를 빼주는 것이다.
        */
        --  현재일로 부터 1년 2개월 3일 4시간 5분 6초 뒤를 나타내세요.
        
        select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') AS 현재시각
            ,  sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06')
            , to_char(sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'),'yyyy-mm-dd hh24:mi:ss') AS "1년2개월3일4시간5분6초"
        from dual;
        
        
        
        
        
        ---------- >> 4. 변환 함수 << -----------
        
        -- 4.1 to_char(날짜, '형태') ==> 날짜를 '형태' 모양으로 문자형태로 변환시켜준다.
        --     to_char(숫자, '형태') ==> 숫자를 '형태' 모양으로 문자형태로 변환시켜준다.
        
        -- 날짜를 문자형태로 변환하기 ---
        
        select to_char(sysdate, 'yyyy') AS 년도
            ,  to_char(sysdate, 'mm') AS 월
            ,  to_char(sysdate, 'dd') AS 일
            ,  to_char(sysdate, 'hh24') AS "24시간"
            ,  to_char(sysdate, 'am hh') AS "12시간"
            ,  to_char(sysdate, 'pm hh') AS "12시간"
            ,  to_char(sysdate, 'mi') AS 분
            ,  to_char(sysdate, 'ss') AS 초
            ,  to_char(sysdate, 'q') AS 분기 -- 1월 ~ 3월 => 1,  4월 ~ 6월 => 2, 7월 ~ 9월 => 3, 10월 ~ 12월 => 4
            ,  to_char(sysdate, 'day') AS 요일명 -- 월요일(Windows), Monday(Linux)
            ,  to_char(sysdate, 'dy') AS 줄인요일명 -- 월(Windows), Mon(Linux)
        from dual;
        
        select to_char(sysdate, 'd') -- sysdate 의 주의 일요일 부터(지금은 2021년 7월 18일) sysdate(지금은 2021년 7월 19일)까지가 며칠째 인지 알려준다.
                                     --  1(일요일) 2(월요일) 3(화요일) ~ 7(토요일)
        
        from dual;
        -- 2 => 월요일
        
        
        select case to_char(sysdate, 'd')
               when '1' then '일'
               when '2' then '월'
               when '3' then '화'
               when '4' then '수'
               when '5' then '목'
               when '6' then '금'
               when '7' then '토'
               end AS 오늘의요일명
               
               , decode( to_char(sysdate, 'd'), '1', '일'
                        , '2', '월'
                        , '3', '화'
                        , '4', '수'
                        , '5', '목'
                        , '6', '금'
                        , '7', '토'
                        ) AS 오늘의요일명2                             
        from dual;
        
        
        select to_char(sysdate, 'dd') -- -- sysdate 의 월 1일 부터(지금은 2021년 7월 1일) sysdate(지금은 2021년 7월 19일)까지가 며칠째 인지 알려준다.
        from dual;
        
        select to_char(sysdate, 'ddd') -- -- sysdate 의 년도 1월 1일 부터(지금은 2021년 7월 1일) sysdate(지금은 2021년 7월 19일)까지가 며칠째 인지 알려준다.
        from dual;.
        
        select to_char(sysdate, 'sssss') -- sysdate 의 0시 0분 0초(자정) 부터 sysdate(현재가 2021년 7월 19일 오후 12:04:15)
                                         -- 0시 0분 0초 부터 오후 12시 4분 40초 까지 흘러간 초를 말한다.
        from dual;
        
        
        --- 숫자를 문자형태로 변환하기 ---
        select 1234567890
                , to_char(1234567890, '9,999,999,999') -- 전체 자릿수가 10개면, 10개를 다 적어줘야 한다.
                , to_char(1234567890, '$9,999,999,999')
                , to_char(1234567890, 'L9,999,999,999') -- L 은 그 나라의 화폐기호 이다.
        from dual;
        -- 1234567890	 1,234,567,890	 $1,234,567,890	        ￦1,234,567,890
        
        select 100, to_char(100,'999.0')
                ,95.7, to_char(95.7,'999.0')
        from dual;
        -- 100	 100.0	95.7	  95.7
        -- 뒤에 소수부가 존재하면 그대로 출력, 없으면 .0 출력
        
        
        -- 4.2 to_date(문자, '형태') ==> 문자를 '형태' 모양으로 날짜형태로 변환시켜주는 것이다.
        
        select '2021-07-19' + 1
        from dual;
        -- ORA-01722: invalid number
        
        select to_date('2021-07-19', 'yyyy-mm-dd') + 1
             , to_date('2021/07/19', 'yyyy/mm/dd') + 1
             , to_date('20210719', 'yyyymmdd') + 1             
        from dual;
        -- 21/07/20	21/07/20	21/07/20
        
        
        select to_date('2021-02-29', 'yyyy-mm-dd') + 1      -- 2021-02-29 은 달력에 없으므로 오류!!!       
        from dual;        
        -- ORA-01839: date not valid for month specified
        -- 올해 2월에는 29일이 없습니다!!
        
        select to_date('2020-02-29', 'yyyy-mm-dd') + 1      -- 2020-02-29 은 달력에 있으므로 O.K!!     
        from dual;        
        -- 20/03/01
        
        
        
        
        -- 4.3 to_number(문자) ==> 숫자모양을 가지는 문자를 실제 숫자로 변환시켜주는 것이다.
        select '12345', to_number('12345')
        from dual;
        
        select to_number('50') + 10
                , '50' + 10 -- 자동형변환이 되어짐.
        from dual;
        
        select to_number('홍길동')
        from dual;
        -- ORA-01722: invalid number
        
        ---------- >> 5. 기타 함수 << -----------
        
        -- 5.1 case when then else end ==> !!! 암기
        select case 5-2 --조건식 
               when 4 then '5-2=4 입니다.' -- 조건식의 결과물과 when의 값과 비교해서 같으면 then을 출력
               when 1 then '5-2=1 입니다.' -- 아니면 얘랑 같으면 얘를 출력
               when 0 then '5-2=0 입니다.'
               else '나는 수학을 몰라요ㅠㅠ' -- 이도 저도 아니면 얘를 출력
               end AS 결과
        
        from dual;
        
        select case 
               when 4 > 5 then '4는 5보다 크다.'
               when 5 > 7 then '5는 7보다 크다.'
               when 3 > 2 then '3은 2보다 크다.'
               else '나는 수학을 몰라요ㅠㅠ'
               end as 결과
               
        from dual;
        
        select case 
               when 1 = 2 then '1은 2이다.'
               when 1 = 3 then '1은 3이다.'
               when 1 = 1 then '1은 1이다.'
               else '나는 수학을 몰라요ㅠㅠ'
               end as 결과
               
        from dual;
        
        -- 5.2 decode ==> !!! 암기
        select case 5-2 --조건식 
               when 4 then '5-2=4 입니다.' -- 조건식의 결과물과 when의 값과 비교해서 같으면 then을 출력
               when 1 then '5-2=1 입니다.' -- 아니면 얘랑 같으면 얘를 출력
               when 0 then '5-2=0 입니다.'
               else '나는 수학을 몰라요ㅠㅠ' -- 이도 저도 아니면 얘를 출력
               end AS 결과1
        ,
            decode(5-2, 4, '5-2=4 입니다'   -- 조건식 값이, 이거면, 이거출력
                    ,   1, '5-2=1 입니다'   -- 조건식 값이, 이거면, 이거출력
                    ,   3, '5-2=3 입니다'
                    ,  '나는 수학을 몰라요ㅠㅠ') AS 결과2 -- , 이도저도아니면 이거출력
        
        from dual;
        
        -- 5.3 greatest, least
        select greatest(10, 90, 100, 80) -- 나열되어진것들 중에 제일 큰값을 알려주는 것
            ,  least(10, 90, 100, 80) -- 나열되어진것들 중에 제일 작은값을 알려주는 것
        from dual;
        -- 100  10
        
        select greatest('김유신', '허준', '고수', '엄정화')
             , least('김유신', '허준', '고수', '엄정화')
        from dual;
        -- 허준	고수
        

        
        -- 5.4 rank ==> 등수(석차)구하기 , dense_rank ==> 서열구하기
        select employee_id AS 사원번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  nvl(salary + (salary * commission_pct), salary) AS 월급
            ,  rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 월급등수
            ,  dense_rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 월급서열
        from employees;
        
        select department_id AS 부서번호
            ,  employee_id AS 사원번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  nvl(salary + (salary * commission_pct), salary) AS 월급
            ,  rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 전체월급등수
            ,  rank() over(partition by department_id 
                           order by nvl(salary + (salary * commission_pct), salary) desc) AS 부서내월급등수
        from employees
        order by 1;
        
        
       select department_id AS 부서번호
            ,  employee_id AS 사원번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  nvl(salary + (salary * commission_pct), salary) AS 월급
            ,  dense_rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 전체월급서열
            ,  dense_rank() over(partition by department_id 
                           order by nvl(salary + (salary * commission_pct), salary) desc) AS 부서내월급서열
        from employees
        order by 1;       
        
        
        -- 5.5 lag , lead 함수 ==> web 게시판에서 특정글을 조회할때 많이 사용합니다. ****** //
        
        create table tbl_board
        (boardno     number                -- 글번호, 사이즈가 없으면 무한대이다.
        ,subject     varchar2(4000)        -- 글제목, varchar2의 최대 크기는 4,000byte 까지 가능하다. 넘을 시 오류발생!!!
        ,content     nvarchar2(2000)       -- 글내용, nvarchar2의 최대 크기는 2,000 이다.
        ,userid      varchar2(40)          -- 글쓴이의 ID
        ,registerday  date default sysdate -- 작성일자, default sysdate 은 데이터 입력시 registerday 컬럼의 값을 생략하면 기본적으로 sysdate 가 입력된다.
        ,readcount   number(10)            -- 조회수
        );
        

        
        insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
        values(1, '안녕하세요', '글쓰기 연습입니다.', 'leess',sysdate, 0);
        
        insert into tbl_board
        values(2, '반갑습니다', '모두 취업대박 나십시오', 'eomjh',sysdate, 0);
        
        insert into tbl_board(subject,boardno, content, userid, registerday, readcount)
        values('건강하세요', 3, '로또 1등을 기원합니다..', 'youks',sysdate, 0);
        
        insert into tbl_board
        values(4, '기쁘고 감사함이 넘치는 좋은 하루되세요', '늘 행복하세요.', 'leess', default, 0);
        
        insert into tbl_board(boardno, subject, content, userid, readcount)
        values(5, '오늘도 좋은 하루되세요', '늘 감사합니다.', 'kimys', 0);
        
        commit;
        
        select *
        from tbl_board;
        
        
        
        select boardno, subject, content
        from tbl_board;   

    
        /*
        
        ----------------------------------------------------------------------------------------------------------------------
         이전글번호      이전글제목                            글번호      글제목          글내용                  다음글번호    다음글제목
        ----------------------------------------------------------------------------------------------------------------------
            null        null                              1	    안녕하세요	글쓰기 연습입니다.                   2       반갑습니다
            1           안녕하세요                          2	    반갑습니다	모두 취업대박 나십시오                3	      건강하세요
            2           반갑습니다                          3	    건강하세요	로또 1등을 기원합니다..               4	      기쁘고 감사함이 넘치는
            3           건강하세요                          4	    기쁘고 감사함이 넘치는 좋은 하루되세요	늘 행복하세요.	   5       오늘도 좋은 하루되세요
            4           기쁘고감사함이 넘치는 좋은 하루되세요    5	    오늘도 좋은 하루되세요	늘 감사합니다.	               null       null
        
        */
        
        select lag(boardno, 1) over(order by boardno asc)       AS 이전글번호
            -- boardno(글번호)의 오름차순으로 정렬했을때 위쪽으로 1칸 올라간 행에서 boardno 컬럼의 값을 가져온다. 
    
        ,      lag(subject, 1) over(order by boardno asc)       AS 이전글제목
            -- boardno(글번호)의 오름차순으로 정렬했을때 위쪽으로 1칸 올라간 행에서 subject 컬럼의 값을 가져온다. 
        
        ,      boardno AS 글번호
        ,      subject AS 글제목
        ,      content AS 글내용
        ,      lead(boardno,1) over(order by boardno asc)        AS 다음글번호
            -- boardno(글번호)의 오름차순으로 정렬했을때 아래쪽으로 1칸 내려간 행에서 boardno 컬럼의 값을 가져온다. 
            
        ,      lead(subject,1) over(order by boardno asc)        AS 다음글제목
            -- boardno(글번호)의 오름차순으로 정렬했을때 아래쪽으로 1칸 내려간 행에서 subject 컬럼의 값을 가져온다. 
        from tbl_board;
        
        
        
        
        
        select lag(boardno, 2) over(order by boardno asc)       AS 이전글번호
        -- boardno(글번호)의 오름차순으로 정렬했을때 위쪽으로 2칸 올라간 행에서 boardno 컬럼의 값을 가져온다.
        ,      lag(subject, 2) over(order by boardno asc)       AS 이전글제목
        -- boardno(글번호)의 오름차순으로 정렬했을때 위쪽으로 2칸 올라간 행에서 subject 컬럼의 값을 가져온다. 
        ,      boardno AS 글번호
        ,      subject AS 글제목
        ,      content AS 글내용
        ,      lead(boardno, 2) over(order by boardno asc)        AS 다음글번호
        -- boardno(글번호)의 오름차순으로 정렬했을때 아래쪽으로 2칸 내려간 행에서 boardno 컬럼의 값을 가져온다.
        ,      lead(subject, 2) over(order by boardno asc)        AS 다음글제목
        -- boardno(글번호)의 오름차순으로 정렬했을때 아래쪽으로 2칸 내려간 행에서 subject 컬럼의 값을 가져온다. 
        from tbl_board;
        
        
        select lag(boardno) over(order by boardno asc)       AS 이전글번호
               -- 숫자가 없으면 1 이 생략된 것이다.
        ,      lag(subject) over(order by boardno asc)       AS 이전글제목
               -- 숫자가 없으면 1 이 생략된 것이다.
        ,      boardno AS 글번호
        ,      subject AS 글제목
        ,      content AS 글내용
        ,      lead(boardno) over(order by boardno asc)        AS 다음글번호
               -- 숫자가 없으면 1 이 생략된 것이다.
        ,      lead(subject) over(order by boardno asc)        AS 다음글제목
               -- 숫자가 없으면 1 이 생략된 것이다.
        from tbl_board;
        
        select boardno, subject
        from tbl_board;   
        
        --- [퀴즈] --- subject 컬럼의 값이 길이가 16 보다 크면 subject 컬럼의 값 중 16글자만 보여주고 뒤에 ... 을 붙여서 나타내세요.
        
        select boardno, subject, length(subject)
        ,      case when length(subject) > 16 then substr(subject, 1, 16) || '...' 
                    else subject
               end AS 글제목
        from tbl_board
        order by boardno desc;
        
        create table tbl_members
        (userid    varchar2(20)
        ,passwd    varchar2(20)
        ,name      varchar2(20)
        ,addr      varchar2(100)
        );
        
        insert into tbl_members(userid, passwd, name, addr)
        values('kimys','abcd','김유신','서울');
        
        insert into tbl_members(userid, passwd, name, addr)
        values('young2','abcd','이영이','서울');
        
        insert into tbl_members(userid, passwd, name, addr)
        values('leesa','abcd','이에리사','서울');
        
        insert into tbl_members(userid, passwd, name, addr)
        values('park','abcd','박이남','서울');
        
        insert into tbl_members(userid, passwd, name, addr)
        values('leebon','abcd','이본','서울');
        
        commit; 
        
        
        select *
        from tbl_members;
        
        
        
        select count(*)
        from tbl_members; -- select 되어져 나온 결과물의 행의 개수 => 5개 행
        
        
        select *
        from tbl_members
        where userid = 'kimys' and passwd = 'abcd';
        
        select count(*)
        from tbl_members
        where userid = 'kimys' and passwd = 'abcd'; -- select 되어져 나온 결과물의 행의 개수 => 1개 행
        
        
        select *
        from tbl_members
        where userid = 'kimys' and passwd = 'qwer1234';
        
        select count(*)
        from tbl_members
        where userid = 'kimys' and passwd = 'qwer1234'; -- select 되어져 나온 결과물의 행의 개수 => 0개 행      
        
        select *
        from tbl_members
        where userid = 'superman' and passwd = 'abcd';
        
        select count(*)
        from tbl_members
        where userid = 'superman' and passwd = 'abcd'; -- select 되어져 나온 결과물의 행의 개수 => 0개 행
        
        
        /*
           -- [퀴즈] --
           tbl_members 테이블에서
           userid 및 passwd 가 모두 올바르면 '로그인성공' 을 보여주고,
           userid 는 올바르지만 passwd 가 틀리면 '암호가 틀립니다' 을 보여주고,
           userid 가 존재하지 않으면 '아이디가 존재하지 않습니다' 을 보여주려고 한다.
        */        
        
        

        select case ( select count(*)
                      from tbl_members
                      where userid = 'kimys' and passwd = 'qwer' )
               when 1 then '로그인성공'
               else ( case (select count(*)
                            from tbl_members
                            where userid = 'kimys')
                      when 1 then '암호가 틀립니다'
                      else '아이디가 존재하지 않습니다'      
                      end      )
               end AS 로그인결과
        from dual;
        
        ----------------------------------------------------------------------------------
        --- [퀴즈]  employees 테이블에서 월급등수가 1등 부터 10등까지 사원들만 
        --          사원번호     사원명     월급     월급등수 을 나타내세요.
        select employee_id AS 사원번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  nvl(salary + (salary * commission_pct), salary) AS 월급
            ,  rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 월급등수
        from employees
        where rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 월급등수 <= 10;
        --- !!! 오류 !!!
        --- rank() 함수는 where 절에 바로 쓸수가 없다. !!!!
        
        
        select V.*
        from
        (
            select employee_id AS 사원번호
                ,  first_name || ' ' || last_name AS 사원명
                ,  nvl(salary + (salary * commission_pct), salary) AS 월급
                ,  rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 월급등수
            from employees
        ) V -- V 는 괄호()속의 select 되어져 나온 결과물을 V 라는 이름을 가지는 테이블로 간주해 버린다.
        where V.월급등수 <= 10;
        
        ---- **** !!!! ★★★★ 아주 중요하다 ★★★★ !!!! **** ----
        -- View(뷰)란? 테이블은 아니지만 select 되어진 결과물을 마치 테이블 처럼 보는것(간주하는 것)이다.
        
        -- View(뷰) 는 2가지 종류가 있다. 
        -- 첫번째로 inline view  가 있고, 두번째로 stored view 가 있다.
        -- inline view 는 바로 위의 예제에 보이는 V 이다. 즉, select 구문을 괄호( )를 쳐서 별칭(예 : V)을 부여한 것을 말한다.
        -- stored view 는 복잡한 SQL(Structured Query Language == 정형화된 질의어)을 저장하여 select 문을 간단하게 사용하고자 할 때 쓴다.
        --- 그래서 Inline view 는 1회성이고, stored view 는 언제든지 불러내서 재사용이 가능하다.
        
        
        --- *** Stored view (저장된 뷰) 생성하기 *** --- 
        /*
            create or replace view 뷰명 --> 뷰명 으로 되어진 view 가 없으면 create(생성) 하고, 만약에 뷰명 으로 되어진 view 가 이미 존재하면 이전에 정의해둔 view를 없애버리고 select 문장 으로 replace(수정)해라는 말이다.
            as
            select 문장;
            
            >> select 되어진 문장을 ~~한 이름의 뷰로써 보겠다.
        */
        
        create or replace view view_employeerank
        as
        select employee_id AS 사원번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  nvl(salary + (salary * commission_pct), salary) AS 월급
            ,  rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS 월급등수
        from employees;
        -- View VIEW_EMPLOYEERANK이(가) 생성되었습니다.
        
        select *
        from view_employeerank;
        
        select *
        from view_employeerank
        where 월급등수 <= 10;
        
        
        select * from tab;

        desc view_employeerank;
        
        create or replace view view_employeerank
        as
        select employee_id AS EMPLOYEE_ID
            ,  department_id AS DEPARTMENT_ID
            ,  first_name || ' ' || last_name AS ENAME
            ,  nvl(salary + (salary * commission_pct), salary) AS MONTHSAL
            ,  rank() over(order by nvl(salary + (salary * commission_pct), salary) desc) AS MONTHSAL_RANKING
        from employees;
        
        -- View VIEW_EMPLOYEERANK이(가) 생성되었습니다.
        
        desc view_employeerank;
        desc employees;
               
        SELECT * 
        FROM VIEW_EMPLOYEERANK
        WHERE MONTHSAL_RANKING <= 10;
        
        /*
            --- [퀴즈] ---
            employees 테이블에서 모든 사원들에 대해 
            사원번호, 사원명, 주민번호, 성별, 현재나이, 월급, 입사일자, 정년퇴직일, 정년까지근무개월수, 예상퇴직금 를 나타내세요.
            
            여기서 정년퇴직일이라 함은 
            해당 사원의 생월이 3월에서 8월에 태어난 사람은 
            해당사원의 나이(한국나이)가 63세가 되는 년도의 8월 31일로 하고,
            해당사원의 생월이 9월에서 2월에 태어난 사람은 
            해당사원의 나이(한국나이)가 63세가 되는 년도의 2월말일(2월28일 또는 2월29일)로 한다.
           
            정년까지근무개월수 ==> 입사일자로 부터 정년퇴직일 까지 개월차이 
            months_between(정년퇴직일, 입사일자)
            
            퇴직금 => 근무년수 * 월급            26개월 ==> 2년 2개월 ==> 2년*월급
            months_between(sysdate, 입사일자) ==> 근무일자 ==> extract(year from 근무일자)
        */
        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      jubun AS 주민번호
        ,      case 
               when substr(jubun, 7, 1) in('1','3') then '남'
               else '여'
               end AS 성별
        ,      extract(year from sysdate) - (  substr(jubun, 1, 2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end) + 1 || '세' AS 현재나이
        ,      nvl(salary + (salary * commission_pct), salary) AS 월급
        ,      hire_date AS 입사일자
        from employees;
        
        
        
        -- 어떤 사원의 현재 나이가 62 세 ==> 63세가 되는 년도     add_months(sysdate, (63-62)년)   add_months(sysdate, (1)년)  add_months(sysdate, (1*12)년)      to_char(add_months(sysdate, (63-사원의나이)*12), 'yyyy')
        -- 어떤 사원의 현재 나이가 37 세 ==> 63세가 되는 년도     add_months(sysdate, (63-37)년)   add_months(sysdate, (26)년) add_months(sysdate, (26*12)년)     to_char(add_months(sysdate, (63-사원의나이)*12), 'yyyy')
        -- 어떤 사원의 현재 나이가 57 세 ==> 63세가 되는 년도     add_months(sysdate, (63-57)년)   add_months(sysdate, (6)년)  add_months(sysdate, (6*12)년)      to_char(add_months(sysdate, (63-사원의나이)*12), 'yyyy')
        
        select V.사원번호, V.사원명, V.주민번호, V.성별, V.현재나이, V.월급, V.입사일자,
              to_char(last_day(to_date(to_char(add_months(sysdate, (63-V.현재나이)*12), 'yyyy') ||
              case when to_number( substr(V.주민번호, 3, 2) ) between 3 and 8 then '-08-01'  
              else '-02-01' end, 'yyyy-mm-dd')), 'yyyy-mm-dd') AS 정년퇴직일
              
              
        from
        (
            select employee_id AS 사원번호
            ,      first_name || ' ' || last_name AS 사원명
            ,      jubun AS 주민번호
            ,      case when substr(jubun, 7, 1) in('1','3') then '남'
                   else '여' end AS 성별
            ,      extract(year from sysdate) - (  substr(jubun, 1, 2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end) + 1  AS 현재나이
            ,      nvl(salary + (salary * commission_pct), salary) AS 월급
            ,      hire_date AS 입사일자
            from employees
        ) V;
        
        
        
        
        
        
        -- V는 생략 가능하다. --
         select 사원번호, 사원명, 주민번호, 성별, 현재나이, 월급, 입사일자,
              to_char(last_day(to_date(to_char(add_months(sysdate, (63-현재나이)*12), 'yyyy') ||
              case when to_number( substr(주민번호, 3, 2) ) between 3 and 8 then '-08-01'  
              else '-02-01' end, 'yyyy-mm-dd')), 'yyyy-mm-dd') AS 정년퇴직일,
              
              trunc(months_between(last_day(to_date(to_char(add_months(sysdate, (63-현재나이)*12), 'yyyy') ||
              case when to_number( substr(주민번호, 3, 2) ) between 3 and 8 then '-08-01'  
              else '-02-01' end, 'yyyy-mm-dd')), 입사일자)) AS 정년까지근무개월수
              -- 답은 나오지만, 가독성이 떨어지기 때문에 좋지 않다.
              -- 정년퇴직일까지 view 로 처리해서 깔끔하게 만들어야 한다.
              
              
        from
        (
            select employee_id AS 사원번호
            ,      first_name || ' ' || last_name AS 사원명
            ,      jubun AS 주민번호
            ,      case when substr(jubun, 7, 1) in('1','3') then '남'
                   else '여' end AS 성별
            ,      extract(year from sysdate) - (  substr(jubun, 1, 2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end) + 1  AS 현재나이
            ,      nvl(salary + (salary * commission_pct), salary) AS 월급
            ,      hire_date AS 입사일자
            from employees
        ) V; -- 이만큼을 테이블로 간주하니(view) 정년퇴직일을 구할 때 현재나이와 주민번호를 가져올 수 있다.
        
        
        --- 또는 ---
        
        select 사원번호, 사원명, 주민번호, 성별, 현재나이, 
        to_char(월급, '999,999') AS 월급,
        to_char(입사일자,'yyyy-mm-dd') AS 입사일자, 
        to_char(정년퇴직일,'yyyy-mm-dd') AS 정년퇴직일,
        trunc(months_between(정년퇴직일, 입사일자)) AS 정년까지근무개월수,
        to_char(trunc(trunc(months_between(정년퇴직일, 입사일자)) / 12 ) * 월급, '9,999,999') AS 퇴직금
        
        
        
        from
        (
            select 사원번호, 사원명, 주민번호, 성별, 현재나이, 월급, 입사일자,
                  last_day(to_date(to_char(add_months(sysdate, (63-현재나이)*12), 'yyyy') ||
                  case when to_number( substr(주민번호, 3, 2) ) between 3 and 8 then '-08-01'  
                  else '-02-01' end, 'yyyy-mm-dd')) AS 정년퇴직일
                  
            from
            (
                select employee_id AS 사원번호
                ,      first_name || ' ' || last_name AS 사원명
                ,      jubun AS 주민번호
                ,      case when substr(jubun, 7, 1) in('1','3') then '남'
                       else '여' end AS 성별
                ,      extract(year from sysdate) - (  substr(jubun, 1, 2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end) + 1  AS 현재나이
                ,      nvl(salary + (salary * commission_pct), salary) AS 월급
                ,      hire_date AS 입사일자
                from employees
            ) V
        ) T; -- 이만큼을 또 하나의 테이블로 간주하니(view) 정년퇴직일 컬럼을 select에서 호출할 수 있다.
        
        
        
        --------------- [Quiz] ---------------
        
        create table tbl_loan 
        (gejanum        varchar2(10)    -- 통장번호
        ,loanmoney      number          -- 대출금
        ,interestrate   number(2,2)     -- 이자율      number(2,2) ==> -0.99 ~ 0.99
        ,paymentdate    varchar2(2)     -- 이자를 내는 날짜    '01', '10', '20', '25', 매월말일 '00'
        );
        
        insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate) 
        values('10-1234-01', 5000, 0.03, '01');
  
        insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate) 
        values('10-1234-02', 5000, 0.03, '10');      

        insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate) 
        values('10-1234-03', 5000, 0.03, '20');   
        
        insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate) 
        values('10-1234-04', 5000, 0.03, '25');
        
        insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate) 
        values('10-1234-05', 5000, 0.03, '00');
        
        commit;
        
        select *
        from tbl_loan;
        
        
        /*
            이자납부일이 만약에 '토요일' 이라면 다음주 '월요일'에 납부하도록 한다. ==> '10'일 납부자
            이자납부일이 만약에 '일요일' 이라면 다음주 '월요일'에 납부하도록 한다. ==> '25'일 납부자
            납부금액은 대출금 * 이자율 이다.
        */
        
        
        select gejanum AS 통장번호
              , loanmoney AS 대출금
              , interestrate AS 이자율
              , decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                            , paymentdate ) AS 이자납부일
              , to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ) AS 이번달이자납부일
              
        from tbl_loan;        
        
        
        select sysdate, to_char(sysdate, 'd'),
               decode( to_char(sysdate, 'd'), '1', '일'
                                            , '2', '월'
                                            , '3', '화'
                                            , '4', '수'
                                            , '5', '목'
                                            , '6', '금'
                                            , '7', '토'
                      ) AS 오늘의요일명
        from dual;
        
        
        
        select gejanum AS 통장번호
              , loanmoney AS 대출금
              , interestrate AS 이자율
              , decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                            , paymentdate ) AS 이자납부일
              , to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ) AS 이번달이자납부일
              , to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ), 'yyyy-mm-dd') AS 날짜형납부일
              , to_char( to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ), 'yyyy-mm-dd'), 'd' ) AS 납부일요일명
              /*
              , decode( '요일명에해당하는숫자','7' ,이번달이자납부일+2
                                          ,'1' ,이번달이자납부일+1
                                               ,이번달이자납부일) AS 실제이자납부일
              */
              
              , decode( to_char( to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ), 'yyyy-mm-dd'), 'd' ),'7' ,to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ), 'yyyy-mm-dd')+2
                                          ,'1' ,to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ), 'yyyy-mm-dd')+1
                                               ,to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                            , paymentdate ), 'yyyy-mm-dd')) AS 실제이자납부일
              
        from tbl_loan;



        
        ------ ****** 위처럼 하지 말고 inline view 를 사용하여 가독성을 높이도록 한다. ****** ------
        
        
        
        select 통장번호, 대출금, 이자율, 실제이번달이자납부일, 실제지난달이자납부일,
        (실제이번달이자납부일 - 실제지난달이자납부일) * 대출금  * 이자율 * 0.1 AS 이번달이자금액 
        from
        (
            select 통장번호, 대출금, 이자율,
                   decode( to_char(이번달이자납부일, 'd'),  '7' ,이번달이자납부일+2
                                                       , '1' ,이번달이자납부일+1
                                                             ,이번달이자납부일) AS 실제이번달이자납부일
                                                             
                ,  decode( to_char(지난달이자납부일, 'd'),  '7' ,지난달이자납부일+2
                                                       , '1' ,지난달이자납부일+1
                                                             ,지난달이자납부일) AS 실제지난달이자납부일
            from
            (
                select gejanum AS 통장번호
                      , loanmoney AS 대출금
                      , interestrate AS 이자율
                      , to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                                    , paymentdate ), 'yyyy-mm-dd') AS 이번달이자납부일
                                                                                    
                      , to_date(to_char( add_months(sysdate,-1), 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day( add_months(sysdate,-1) ), 'dd')
                                                                                    , paymentdate ), 'yyyy-mm-dd') AS 지난달이자납부일
                from tbl_loan
            ) V
        ) T;
        
        
        
        ------ ****** SQL 문을 Stored View(저장된 뷰)로 만들기 ****** ------
        
        create or replace view view_loan
        as
        select 통장번호, 대출금, 이자율, 실제이번달이자납부일, 실제지난달이자납부일,
        (실제이번달이자납부일 - 실제지난달이자납부일) * 대출금  * 이자율 * 0.1 AS 이번달이자금액 
        from
        (
            select 통장번호, 대출금, 이자율,
                   decode( to_char(이번달이자납부일, 'd'),  '7' ,이번달이자납부일+2
                                                       , '1' ,이번달이자납부일+1
                                                             ,이번달이자납부일) AS 실제이번달이자납부일
                                                             
                ,  decode( to_char(지난달이자납부일, 'd'),  '7' ,지난달이자납부일+2
                                                       , '1' ,지난달이자납부일+1
                                                             ,지난달이자납부일) AS 실제지난달이자납부일
            from
            (
                select gejanum AS 통장번호
                      , loanmoney AS 대출금
                      , interestrate AS 이자율
                      , to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                                    , paymentdate ), 'yyyy-mm-dd') AS 이번달이자납부일
                                                                                    
                      , to_date(to_char( add_months(sysdate,-1), 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day( add_months(sysdate,-1) ), 'dd')
                                                                                    , paymentdate ), 'yyyy-mm-dd') AS 지난달이자납부일
                from tbl_loan
            ) V
        ) T;
        
        
        select *
        from view_loan;
        
    
        select *
        from view_loan
        where 통장번호 = '10-1234-03';
        
        select 실제이번달이자납부일, 이번달이자금액
        from view_loan
        where 통장번호 = '10-1234-03';
        
        
        select *
        from tab;
        
        
        --- *** 생성된 Stored View(저장된 뷰) 조회하기 *** ---
        select *
        from user_views;
        
        --- *** 생성된 Stored View(저장된 뷰) 중 뷰이름이 VIEW_LOAN 인 뷰소스 보기 *** ---
        
        select text
        from user_views
        where view_name = 'VIEW_LOAN';
        
        /*
        "select 통장번호, 대출금, 이자율, 실제이번달이자납부일, 실제지난달이자납부일,
        (실제이번달이자납부일 - 실제지난달이자납부일) * 대출금  * 이자율 * 0.1 AS 이번달이자금액 
        from
        (
            select 통장번호, 대출금, 이자율,
                   decode( to_char(이번달이자납부일, 'd'),  '7' ,이번달이자납부일+2
                                                       , '1' ,이번달이자납부일+1
                                                             ,이번달이자납부일) AS 실제이번달이자납부일
                                                             
                ,  decode( to_char(지난달이자납부일, 'd'),  '7' ,지난달이자납부일+2
                                                       , '1' ,지난달이자납부일+1
                                                             ,지난달이자납부일) AS 실제지난달이자납부일
            from
            (
                select gejanum AS 통장번호
                      , loanmoney AS 대출금
                      , interestrate AS 이자율
                      , to_date(to_char( sysdate, 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day(sysdate), 'dd')
                                                                                    , paymentdate ), 'yyyy-mm-dd') AS 이번달이자납부일
                                                                                    
                      , to_date(to_char( add_months(sysdate,-1), 'yyyy-mm-' ) || decode( paymentdate, '00', to_char(last_day( add_months(sysdate,-1) ), 'dd')
                                                                                    , paymentdate ), 'yyyy-mm-dd') AS 지난달이자납부일
                from tbl_loan
            ) V
        ) T"
        
        
        */
        
        --- *** 생성된 Stored View(저장된 뷰) 중 뷰이름이 VIEW_LOAN 인 뷰 삭제하기 *** ---
        
        drop view view_loan;
        -- View VIEW_LOAN이(가) 삭제되었습니다.
        
        select *
        from view_loan;
        -- ORA-00942: table or view does not exist

        
        /*
        ----------- [Quiz] 아래와 같이 나오도록 하세요 --------------------------------------------------
      이전글번호  이전글제목   글번호   글제목      글내용            다음글번호        다음글제목
         2	    반갑습니다	3	  건강하세요	로또 1등을 기원합니다..	4	기쁘고 감사함이 넘치는 좋은 하루되세요
        --------------------------------------------------------------------------------------------
        */
        
        
        --- [ 틀린풀이 ] ---
        
        select lag(boardno) over(order by boardno asc)       AS 이전글번호
        ,        lag(subject) over(order by boardno asc)       AS 이전글제목

        ,        boardno AS 글번호
        ,        subject AS 글제목
        ,        content AS 글내용
        
        ,        lead(boardno) over(order by boardno asc)        AS 다음글번호
        ,        lead(subject) over(order by boardno asc)        AS 다음글제목
        from tbl_board
        where boardno = 3;
        -- 이렇게하면 메모리(RAM)에 3번글만 올라가져서, 이전글번호 / 다음글번호를 호출할 수 없다.
        -- 일단 모든 게시글을 다 올린 다음에 거기에서 추출해서 뽑아와야 한다.
        -- 		3	건강하세요	로또 1등을 기원합니다..		
        
        
        --- [ 올바른풀이 ] ---
        
        select *
        from
        (
        select lag(boardno) over(order by boardno asc)       AS 이전글번호
        ,        lag(subject) over(order by boardno asc)       AS 이전글제목

        ,        boardno AS 글번호
        ,        subject AS 글제목
        ,        content AS 글내용
        
        ,        lead(boardno) over(order by boardno asc)        AS 다음글번호
        ,        lead(subject) over(order by boardno asc)        AS 다음글제목
        from tbl_board
        ) V
        where 글번호 = 3;
        
        -- 이렇게하면 메모리(RAM)에 5개의 글을 먼저 올린 다음에, 거기에서 글번호가 3번인 것만 추출해온다.
        -- 일단 글을 모두 다 올리고 / inline view 로 감싸고 / 거기에서 글번호 3번만 추출
        -- 2	반갑습니다	3	건강하세요	로또 1등을 기원합니다..	4	기쁘고 감사함이 넘치는 좋은 하루되세요
        
        
     
        -------------------------------------------------------------------------------
        /*
        [문제 1]
        employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
        부서번호, 사원명, 주민번호, 성별을 나타내세요.
        성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.

       ------------------------------------------------------------
       부서번호        사원명             주민번호            성별
       ------------------------------------------------------------
        30           Den Raphaely       670915*******   여
        30           Alexander Khoo       611015*******   남
        30           Shelli Baida       600930*******   남
        30           Sigal Tobias       611015*******   여
        30           Guy Himuro           781015*******   남
        30           Karen Colmenares    790915*******   남
        50           Matthew Weiss       770215*******   여
        50           Adam Fripp           700915*******   남
        50           Payam Kaufling       711101*******   남
        50           Shanta Vollman       801013*******   남
        50           Kevin Mourgos       811019*******   남
        50           Julia Nayer           901213*******   여
        50           Irene Mikkilineni   940625*******   남
        50           James Landry       940825*******   여
        50           Steven Markle       920415*******   여
        50           Laura Bissot       850725*******   남
        50           Mozhe Atkinson       651111*******   남
        50           James Marlow       001015*******   남
        50           TJ Olson           000525*******   여
        50           Jason Mallin       011019*******   여
        50           Michael Rogers       041215*******   여
        50           Ki Gee               050325*******   남
        50           Hazel Philtanker    951001*******   여
        50           Renske Ladwig       951002*******   남
        50           Stephen Stiles       961004*******   남
        50           John Seo           961005*******   여
        50           Joshua Patel       731001*******   남
        50           Trenna Rajs           731009*******   여
        50           Curtis Davies       751012*******   남
        50           Randall Matos       761201*******   여
        50           Peter Vargas       771006*******   남
        50           Winston Taylor       831001*******   여
        50           Jean Fleaur           651019*******   남
        50           Martha Sullivan       651022*******   남
        50           Girard Geoni       651023*******   여
        50           Nandita Sarchand    851213*******   남
        50           Alexis Bull           851018*******   여
        50           Julia Dellinger       751019*******   여
        50           Anthony Cabrio       851219*******   여
        50           Kelly Chung           951115*******   남
        50           Jennifer Dilly       750930*******   여
        50           Timothy Gates       851016*******   남
        50           Randall Perkins       951019*******   여
        50           Sarah Bell           051013*******   남
        50           Britney Everett       081019*******   여
        50           Samuel McCain       091018*******   남
        50           Vance Jones           101013*******   여
        50           Alana Walsh           951003*******   여
        50           Kevin Feeney       971018*******   남
        50           Donald OConnell       981016*******   여
        50           Douglas Grant       751117*******   남
       */
       
       
       
       
       
       /*
       [문제 2]
        employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
        사원명, 공개연락처, 비공개연락처를 나타내세요.
        여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.

        ---------------------------------------------
        사원명          공개연락처      비공개연락처
        ---------------------------------------------
        Steven King       515.123.4567   515.***.4567
        Neena Kochhar   515.123.4568   515.***.4568
        Lex De Haan       515.123.4569   515.***.4569
       
       */
       
       
       /*
       [문제 3]
       employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
       사원명, 공개연락처, 비공개연락처를 나타내세요.
       여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

        ---------------------------------------------------------------
        사원명               공개연락처               비공개연락처
        ---------------------------------------------------------------
        John Russell       011.44.1344.429268       011.**.1344.******
        Karen Partners       011.44.1344.467268       011.**.1344.******
        Alberto Errazuriz   011.44.1344.429278       011.**.1344.******
        Gerald Cambrault    011.44.1344.619268       011.**.1344.******
        Eleni Zlotkey       011.44.1344.429018       011.**.1344.******
        Peter Tucker       011.44.1344.129268       011.**.1344.******
        David Bernstein       011.44.1344.345268       011.**.1344.******
        Peter Hall           011.44.1344.478968       011.**.1344.******
        Christopher Olsen   011.44.1344.498718       011.**.1344.******
        Nanette Cambrault   011.44.1344.987668       011.**.1344.******
        Oliver Tuvault       011.44.1344.486508       011.**.1344.******
        Janette King       011.44.1345.429268       011.**.1345.******
        Patrick Sully       011.44.1345.929268       011.**.1345.******
        Allan McEwen       011.44.1345.829268       011.**.1345.******
        Lindsey Smith       011.44.1345.729268       011.**.1345.******
        Louise Doran       011.44.1345.629268       011.**.1345.******
        Sarath Sewall       011.44.1345.529268       011.**.1345.******
        Clara Vishney       011.44.1346.129268       011.**.1346.******
        Danielle Greene     011.44.1346.229268       011.**.1346.******
        Mattea Marvins       011.44.1346.329268       011.**.1346.******
        David Lee           011.44.1346.529268       011.**.1346.******
        Sundar Ande           011.44.1346.629268       011.**.1346.******
        Amit Banda           011.44.1346.729268       011.**.1346.******
        Lisa Ozer           011.44.1343.929268       011.**.1343.******
        Harrison Bloom       011.44.1343.829268       011.**.1343.******
        Tayler Fox           011.44.1343.729268       011.**.1343.******
        William Smith       011.44.1343.629268       011.**.1343.******
        Elizabeth Bates       011.44.1343.529268       011.**.1343.******
        Sundita Kumar       011.44.1343.329268       011.**.1343.******
        Ellen Abel           011.44.1644.429267       011.**.1644.******
        Alyssa Hutton       011.44.1644.429266       011.**.1644.******
        Jonathon Taylor       011.44.1644.429265       011.**.1644.******
        Jack Livingston       011.44.1644.429264       011.**.1644.******
        Charles Johnson       011.44.1644.429262       011.**.1644.******
       
       
       
       */
       
       
       
       
       /*
        [문제 4]
        employees 테이블에서 80번, 90번 부서에 근무하는 사원들만 아래와 같이
        부서번호, 사원명, 공개연락처, 비공개연락처를 나타내세요.
        여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

        ------------------------------------------------------------------------------
        부서번호        사원명              공개연락처               비공개연락처
        ------------------------------------------------------------------------------  
        80           John Russell       011.44.1344.429268       011.**.1344.******
        80           Karen Partners       011.44.1344.467268       011.**.1344.******
        80           Alberto Errazuriz   011.44.1344.429278       011.**.1344.******
        80           Gerald Cambrault    011.44.1344.619268       011.**.1344.******
        80           Eleni Zlotkey       011.44.1344.429018       011.**.1344.******
        80           Peter Tucker       011.44.1344.129268       011.**.1344.******
        80           David Bernstein       011.44.1344.345268       011.**.1344.******
        80           Peter Hall           011.44.1344.478968       011.**.1344.******
        80           Christopher Olsen   011.44.1344.498718       011.**.1344.******
        80           Nanette Cambrault   011.44.1344.987668       011.**.1344.******
        80           Oliver Tuvault       011.44.1344.486508       011.**.1344.******
        80           Janette King       011.44.1345.429268       011.**.1345.******
        80           Patrick Sully       011.44.1345.929268       011.**.1345.******
        80           Allan McEwen       011.44.1345.829268       011.**.1345.******
        80           Lindsey Smith       011.44.1345.729268       011.**.1345.******
        80           Louise Doran       011.44.1345.629268       011.**.1345.******
        80           Sarath Sewall       011.44.1345.529268       011.**.1345.******
        80           Clara Vishney       011.44.1346.129268       011.**.1346.******
        80           Danielle Greene       011.44.1346.229268       011.**.1346.******
        80           Mattea Marvins       011.44.1346.329268       011.**.1346.******
        80           David Lee           011.44.1346.529268       011.**.1346.******
        80           Sundar Ande           011.44.1346.629268       011.**.1346.******
        80           Amit Banda           011.44.1346.729268       011.**.1346.******
        80           Lisa Ozer           011.44.1343.929268       011.**.1343.******
        80           Harrison Bloom       011.44.1343.829268       011.**.1343.******
        80           Tayler Fox           011.44.1343.729268       011.**.1343.******
        80           William Smith       011.44.1343.629268       011.**.1343.******
        80           Elizabeth Bates       011.44.1343.529268       011.**.1343.******
        80           Sundita Kumar       011.44.1343.329268       011.**.1343.******
        80           Ellen Abel           011.44.1644.429267       011.**.1644.******
        80           Alyssa Hutton       011.44.1644.429266       011.**.1644.******
        80           Jonathon Taylor       011.44.1644.429265       011.**.1644.******
        80           Jack Livingston       011.44.1644.429264       011.**.1644.******
        80           Charles Johnson       011.44.1644.429262       011.**.1644.******
        90           Steven King           515.123.4567       515.***.****
        90           Neena Kochhar       515.123.4568       515.***.****
        90           Lex De Haan           515.123.4569       515.***.****
       
       */
       
       
       -- email : tjdudgkr0959@naver.com
       -- 메일제목 : SQL과제_1_자기이름
       -- 첨부파일 : SQL과제_1_자기이름.txt
       -- 기한 : 내일
       
       -- [문제 1]
       -- employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
       -- 부서번호, 사원명, 주민번호, 성별을 나타내세요.
       -- 성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.
       
       
 
       
       select department_id AS 부서번호
             ,first_name || ' ' || last_name AS 사원명
             ,substr(jubun,1,6) || '*******' AS 주민번호
             ,case when substr(jubun, 7, 1) in ('1', '3') then '남'
              else '여'
              end AS 성별
              
       from employees
       where department_id = 30 or department_id = 50;
       
        -- [문제 2]
        -- employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
        -- 사원명, 공개연락처, 비공개연락처를 나타내세요.
        -- 여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.
        
        select first_name || ' ' || last_name AS 사원명
        ,      phone_number AS 공개연락처
        ,      substr(phone_number, 1, instr(phone_number, '.', 1)) || '***' || substr(phone_number, instr(phone_number, '.', -1, 1))
        from employees
        where department_id = 90;


        select first_name || ' ' || last_name AS 사원명
             , phone_number AS 공개연락처
             , substr(phone_number, 1, instr(phone_number,'.',1,1)) || '***' || substr(phone_number, instr(phone_number,'.',1,2)) AS 비공개연락처
        from employees
        where department_id = 90;
        
       
        -- [문제 3]
        -- employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
        -- 사원명, 공개연락처, 비공개연락처를 나타내세요.
        -- 여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.
        
        
        select first_name || ' ' || last_name AS 성명
            ,  phone_number AS 공개연락처
            ,  substr(phone_number, 1, instr(phone_number,'.',1,1)) || '**' || rtrim(substr(phone_number, instr(phone_number,'.',1,2)), '1234567890') || '******' AS 비공개연락처
        from employees
        where department_id = 80;
        
        
        select first_name || ' ' || last_name AS 사원명
             , phone_number AS 공개연락처
             , substr(phone_number, 1, instr(phone_number,'.',1,1)) || '**' || substr( phone_number ,instr(phone_number,'.',1,2), 6) || '******' AS 비공개연락처
        from employees
        where department_id = 80;
        
        
       -- [문제 4]
       -- employees 테이블에서 80번, 90번 부서에 근무하는 사원들만 아래와 같이
       -- 부서번호, 사원명, 공개연락처, 비공개연락처를 나타내세요.
       -- 여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.
       
       
       select 부서번호, 사원명, 공개연락처, 첫자리 || 첫번째국번 || 중간자리 || 마지막자리
       from
       (
           select department_id AS 부서번호
           ,      first_name || ' ' || last_name AS 사원명
           ,      phone_number AS 공개연락처
           ,      substr(phone_number, 1, instr(phone_number, '.', 1)) AS 첫자리
           ,      substr(translate(ltrim(rtrim(ltrim(phone_number, '1234567890'),'1234567890'),'.'),'1234567890','**********'), 1, instr(translate(ltrim(rtrim(ltrim(phone_number, '1234567890'),'1234567890'),'.'),'1234567890','**********'), '.', 1)-1) AS 첫번째국번
           ,      substr(rtrim(ltrim(phone_number, '1234567890'),'1234567890'), instr(rtrim(ltrim(phone_number, '1234567890'),'1234567890'), '.', 1, 2)) AS 중간자리
           ,      translate(substr(phone_number, instr(phone_number, '.', -1)+1),'1234567890','**********') AS 마지막자리
           from employees
           where department_id in (80, 90)
       ) V;
       
        
        select 부서번호, 사원명, 공개연락처
        ,  앞번호 || 첫번째국번 || 중간번호 || 마지막개별번호 as 비공개연락처
        from 
        (
            select department_id AS 부서번호
            , first_name || ' ' || last_name AS 사원명
            , phone_number AS 공개연락처
            
            , substr(phone_number, 1, instr(phone_number,'.',1,1)-1) AS 앞번호
            
            , case when length( rtrim( rtrim( substr(phone_number, instr(phone_number,'.',1,1) ),'1234567890' ),'.') ) > 4 
                   then translate( rtrim( rtrim( rtrim( substr(phone_number, instr(phone_number,'.',1,1) ),'1234567890' ),'.' ),'1234567890' ),'1234567890','**********' )
                   else translate(rtrim(substr(phone_number, instr(phone_number,'.',1,1)),'1234567890'),'1234567890','**********') 
                   end  AS 첫번째국번
                   
            , case when length(substr(phone_number,instr(phone_number,'.',1,2))) > 5 
                   then rtrim(substr(phone_number,instr(phone_number,'.',1,2)+1),'1234567890')
                   else rtrim(substr(phone_number,instr(phone_number,'.',1,2)),'1234567890.') 
                   end AS 중간번호  
                   
            , translate(substr(phone_number, instr(phone_number,'.',-1,1)+1),'1234567890','**********') AS 마지막개별번호
    
            from employees
            where department_id = 80 or department_id = 90
        ) V
        order by 부서번호 asc; 
        
        
        
        -----------------------------------------------------------------------------------------------------------------
       

        ---------- >> 그룹함수(집계함수) << -----------
        
        /*
            1. sum          -- 합계
            2. avg          -- 평균
            3. max          -- 최대값
            4. min          -- 최소값
            5. count        -- select 되어서 나온 결과물의 행의 개수
            6. variance     -- 분산
            7. stddev       -- 표준편차
            
            분산 : 분산의 제곱근이 표준편차 (평균에서 떨어진 정도)
            표준편차 : 표준편차의 제곱승이 분산 (평균과의 차액)
            
            
            >>> 주식투자 <<<
            50  60  40  50  55  45  52  48   평균 50  편차가 적음  -- 안정투자
            10  90  20  60  30  70  90  10   평균 50  편차가 큼    -- 투기성투자(위험을 안고서 투자함)
            
            
            분산과 표준편차는 어떤 의사결정시 도움이 되는 지표이다.
        */
        
        
        select sum(salary)      -- 결과값은 1개행만 나온다.
        from employees;
        
        select substr(jubun, 7, 1)  -- 단일행함수는 결과값이 메모리에 로드되어진 행의 개수만큼 동일한 개수로 나온다.
        from employees;
        
        ----- !!!!! 중요중요중요 !!!!! -----
        --      그룹함수(집계함수)에서는 null 이 있으면 무조건 null 은 제외시킨 후 연산을 한다.
        --      그룹함수(집계함수)를 사용하면 1개의 결과값을 가진다.
        select 20 + 57 + 178 + 43 + null + 109
        from dual;
        
        select 20 + 57 + 178 + 43 + 109
        from dual;
        
        select salary
        from employees;
        
        select sum(salary), avg(salary), max(salary), min(salary), count(salary), variance(salary), stddev(salary)
        from employees;
        -- 691416	6461.831775700934579439252336448598130841	24000	2100	107	15284813.66954681713983424440134015164874	3909.579730552481921059198878167256201202
        
        select sum(salary * commission_pct), avg(salary * commission_pct)
        , max(salary * commission_pct), min(salary * commission_pct)
        , count(salary * commission_pct), variance(salary * commission_pct), stddev(salary * commission_pct)
        from employees;
        -- 73690	2105.428571428571428571428571428571428571	5600	610	35	1354447.60504201680672268907563025210085	1163.807374543578326917875190458887616995
        -- commission_pct 가 null 이 아닌 사람만 포함해서 갯수를 측정해서 35 이다.
        
        
        
        select count(*) AS 모든인원수
        ,count(department_id)       --AS 부서번호가NULL이아닌개수
        ,count(commission_pct)      --AS 커미션이NULL이아닌개수
        ,count(salary)              --AS 기본급여가NULL이아닌개수
        from employees;
        -- 107  106  35  107
        
        
        
        ---- **** avg(평균)을 구하실때는 주의를 요한다. **** ----
        
        -- employees 테이블에서 기본급여(salary)의 평균치를 구하세요..
        select sum(salary), count(salary)   -- 691416     107
                , sum(salary) / count(salary) -- 691416 / 107     6461.831775700934579439252336448598130841
                , avg(salary)                  -- 6461.831775700934579439252336448598130841
        from employees;
        
        
        -- employees 테이블에서 수당(salary * commission_pct)이 null이 아닌 사원들만의 수당(salary * commission_pct)의 평균치를 구하세요..
        select sum(salary*commission_pct), count(salary*commission_pct)   -- 73690	35
                , sum(salary*commission_pct) / count(salary*commission_pct) -- 73690 / 35   2105.428571428571428571428571428571428571
                , avg(salary*commission_pct)                  -- 2105.428571428571428571428571428571428571
        from employees;
        
        
        
        -- employees 테이블에서 모든 직원들의 수당(salary * commission_pct)의 평균치를 구하시오..
        select 20 + 57 + 178 + 43 + null + 109
             , 20 + 57 + 178 + 43 + nvl(null, 0) + 109
             , 20 + 57 + 178 + 43 + 109
        from dual;
        
        select sum( nvl( salary*commission_pct, 0) ), count( nvl( salary*commission_pct, 0) )   -- 73690 107
                , sum( nvl( salary*commission_pct, 0) ) / count( nvl( salary*commission_pct, 0) )  -- 73690 / 107   688.691588785046728971962616822429906542
                , avg( nvl( salary*commission_pct, 0) )                  -- 688.691588785046728971962616822429906542
        from employees;



        ---------- >> 그룹함수와 함께 사용되어지는 group by 절 에 대해서 알아봅니다. << -----------
        
        
        ---- employees 테이블에서 부서번호별 인원수를 나타내세요 ----
        

        select department_id AS 부서번호
              ,count(*) AS 인원수
        from employees
        group by department_id  -- department_id 컬럼의 값이 같은것 끼리 그룹을 짓는다.
        order by 1;
        
        
        ---- employees 테이블에서 성별로 인원수를 나타내세요. ----
        select 성별, count(*) as 인원수
        from
        (
        select case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS 성별
        from employees
        ) V
        group by 성별
        order by 1;
        
        
        
        ---- [Quiz] ----
        ---- employees 테이블에서 연령대별로 인원수를 나타내세요. ----
        /*
            -----------------------------
            연령대                 인원수
            -----------------------------
            0
            10
            20
            30
            40
            50
            60
        */
        
        -- 나이   나이   나이 
        -- 21     25    29 ===> 20
        -- trunc(21, -1), trunc(25, -1), trunc(29, -1)
        -- 
        
        
        select AGELINE AS 연령대
             , count(*) AS 인원수 
        from
        (
            select trunc(extract(year from sysdate) - ( to_number(substr(jubun, 1, 2) ) + case when substr(jubun, 7, 1) in ('1','2') then 1900 else 2000 end) + 1, -1) AS AGELINE
            -- extract(year from sysdate) - ( 태어난년도 ) + 1 AS 나이
            -- extract(year from sysdate) - ( to_number(substr(jubun, 1, 2) ) + case when substr(jubun, 7, 1) in ('1', '2') then 1900 else 2000 end + 1 AS 나이
            -- trunc(나이, -1) ==> 연령대(AGELINE)
            from employees
        ) V
        group by AGELINE
        order by 1;
        
        
        
        ---- employees 테이블에서 부서번호별, 성별 인원수를 나타내세요.. ----
        
        /* 
            ----------------------------------
            부서번호        성별         인원수
            ----------------------------------
              ...          ...
              50           남         
              50           여
              60           남
              60           여
              ...          ...
        */
        
        select department_id AS 부서번호, GENDER AS 성별, count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by department_id, GENDER
        order by 1;
        
        
       
       ------ ****** 1차 그룹, 2차 그룹 짓기 ****** -------
        ---- [Quiz] ----
        ---- employees 테이블에서 연령대별, 성별로 인원수를 나타내세요. ----
        /*
            -----------------------------
            연령대        성별         인원수
            -----------------------------
            10
            20
            30
            40
            50
            60
        */
            
        select AGELINE AS 연령대, GENDER AS 성별, count(*) AS 인원수
        from
        (
            select trunc(extract(year from sysdate) - ( to_number(substr(jubun, 1, 2) ) + case when substr(jubun, 7, 1) in ('1','2') then 1900 else 2000 end) + 1, -1) AS AGELINE
                ,  case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
            from employees
        ) V
        group by AGELINE, GENDER
        order by 1;
            
        
        ---- rollup, cube, grouping sets, grouping 에 대해서 알아봅니다. ----
        
        ---- employees 테이블에서 부서번호별로 인원수를 나타내면서 동시에 전체 인원수도 나타내세요. ----
        select department_id AS 부서번호
              ,count(*) AS 인원수
        from employees
        group by rollup (department_id);
        --  (null)     1  << 부서번호가 없는 사람끼리 그룹을지어서 1명
        --  (null)    107 << 그룹을 안 짓고, 전체 인원이 107명
        
        
        
        select department_id AS 부서번호
              ,grouping( department_id ) AS 그룹핑-- grouping(department_id) 은 결과값이 오로지 2개 나온다. 0 또는 1 인데, 0 이라함은 department_id 컬럼의 값으로 그룹을 지었다는 말이고, 1 이라함은 그룹을 안지었단 말이다.
              ,count(*) AS 인원수
        from employees
        group by rollup( department_id ) ;
        
        
    
        
        
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴')
                                                , '전체') AS 부서번호
              ,count(*) AS 인원수
        from employees
        group by rollup( department_id );



        ---- employees 테이블에서 성별로 인원수를 나타내면서 전체인원수도 나타내세요. ----

        
        select decode( grouping(성별),0,성별,'전체') AS 남여성별
                     , count(*) as 인원수
        from
        (
        select case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS 성별
        from employees
        ) V
        group by rollup(성별);
        
        
        
        ---- employees 테이블에서 부서번호별, 성별로 인원수를 나타내면서 전체인원수도 나타내세요. ----
        select 부서번호, 성별, count(*)
        from
        (
        select department_id as 부서번호
        ,case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS 성별 
        from employees
        ) V
        group by rollup(부서번호, 성별);
        
        
        
        select department_id AS 부서번호, GENDER AS 성별, count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by rollup(department_id, GENDER);
        
        
        select decode(grouping( department_id ),0,nvl(to_char(department_id), '인턴'),'전체총합') AS 부서번호, 
        decode(grouping( GENDER ), 0, gender, '부서별성별총합') AS 성별, count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by rollup(department_id, GENDER);
        
        
        
        --- 요약값을 보여주는 rollup, cube, grouping 에 대해서 알아봅니다.
        --- 전체가 얼마이며, 그 중에서 얼마인가?
    
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴'), '전체') AS 부서번호
        , decode(grouping ( GENDER ), 0, gender, '전체') AS 성별
        , count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by rollup(department_id, GENDER);
        
        
        
        ---- employees 테이블에서 부서번호별로 인원수를 나타내면서 동시에 전체 인원수도 나타내세요. ----
        select department_id AS 부서번호
              ,count(*) AS 인원수
        from employees
        group by cube (department_id);
        
        
        
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴'), '전체') AS 부서번호
        , decode(grouping ( GENDER ), 0, gender, '전체') AS 성별
        , count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by cube (department_id, GENDER)
        order by 1,2;
        
        
        ----- >>>>> 요약값(rollup, cube, grouping sets) <<<<< ------
  /*
      1. rollup(a,b,c) 은 grouping sets( (a,b,c),(a,b),(a),() ) 와 같다.
    
         group by rollup(department_id, gender) 은
         group by grouping sets( (department_id, gender), (department_id), () ) 와 같다.
  
      2. cube(a,b,c) 은 grouping sets( (a,b,c),(a,b),(b,c),(a,c),(a),(b),(c),() ) 와 같다.
 
         group by cube(department_id, gender) 은
         group by grouping sets( (department_id, gender), (department_id), (gender), () ) 와 같다.
  */
        
        
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴'), '전체') AS 부서번호
        , decode(grouping ( GENDER ), 0, gender, '전체') AS 성별
        , count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        -- group by rollup(department_id, GENDER);
        group by grouping sets( (department_id, GENDER), (department_id), () );
        
        
        
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴'), '전체') AS 부서번호
        , decode(grouping ( GENDER ), 0, gender, '전체') AS 성별
        , count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        -- group by cube (department_id, GENDER)
        group by grouping sets ( (department_id, GENDER),(department_id),(gender),() );
        
        
        
        
        
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴'), '전체') AS 부서번호
        , decode(grouping ( GENDER ), 0, gender, '전체') AS 성별
        , count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by grouping sets ( (department_id),(gender),() )
        -- order by 1,2;
        order by department_id;
        
        
        
        
        
        select decode(grouping( department_id ), 0, nvl(to_char(department_id), '인턴'), '전체') AS 부서번호
        , decode(grouping ( GENDER ), 0, gender, '전체') AS 성별
        , count(*) AS 인원수
        from
        (
            select department_id,
                   case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS GENDER
                 
            from employees
        ) V
        group by grouping sets ( (department_id, gender),() )
        order by 1,2;
        

        --------- ========= ********* having 그룹함수 조건절 ********* ========= ---------
        
        /*
            group by 절을 사용하여 그룹함수의 값을 나타내었을때
            그룹함수의 값이 특정 조건에 해당하는 것만 추출하고자 할때는 where 절을 사용하는 것이 아니라,
            having 그룹함수조건절 을 사용해야 한다.
        */
        
        -- employees 테이블에서 사원이 10명 이상 근무하는 부서번호와 그 인원수를 나타내세요
        
        
        select department_id AS 부서번호, count(*) AS 인원수
        from employees
        where count(*) >= 10
        group by department_id; -- 오류!!!
        
        select department_id AS 부서번호, count(*) AS 인원수
        from employees
        group by department_id -- 부서별로 그룹을 지었을 때
        having count(*) >= 10 -- 인원수가 10명 이상인 부서그룹을 나타내라
        order by 2 desc;
        
        
        
        --- [퀴즈] employees 테이블에서 부서번호별로 월급의 합계를 나타내었을때 
        --        부서번호별 월급의 합계가 50000 이상인 부서에 대해서만
        --        부서번호, 월급의 합계를 나타내세요.
        

        -- ==> 사원들 107 명을 일단 모두 메모리에 올려서 그룹화한 다음에
        -- ==> 부서별 월급합의 조건을 줘야한다. 
        -- ==> where 절이 아니라, having 절을 이용해야 한다.
        
        
        -- NVL 처리한 것
        select department_id AS 부서번호, sum( nvl(salary + (salary * commission_pct), salary) ) AS 월급의합계
        from employees
        group by department_id
        having sum( nvl(salary + (salary * commission_pct), salary) ) >= 50000
        order by 2 desc;
        /*
            80	377140
            50	156400
            90	58000
            100	51608
        */
  
        
        
        
        ------ **** !!! 누적(누계)에 대해서 알아봅시다. !!! **** ------
        /*
            sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
            
            sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
                                        order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
        */
        
        
         create table tbl_panmae
         (panmaedate  date
         ,jepumname   varchar2(20)
         ,panmaesu    number
         );
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-2), '새우깡', 10);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-2)+1, '새우깡', 15); 
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-2)+2, '감자깡', 20);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-2)+3, '새우깡', 10);
         
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-2)+3, '새우깡', 3);
         
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-1), '고구마깡', 7);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-1)+1, '새우깡', 8); 
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-1)+2, '감자깡', 10);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( add_months(sysdate,-1)+3, '감자깡', 5);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate - 4, '허니버터칩', 30);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate - 3, '고구마깡', 15);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate - 2, '고구마깡', 10);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate - 1, '허니버터칩', 20);
        
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '새우깡', 10);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '새우깡', 10);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '감자깡', 5);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '허니버터칩', 15);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '고구마깡', 20);
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '감자깡', 10); 
        
         insert into tbl_panmae(panmaedate, jepumname, panmaesu)
         values( sysdate, '새우깡', 10);
        
         commit;
         
         select *
         from tbl_panmae;
         
         
        --- *** tbl_panmae 테이블에서 '새우깡' 에 대한 일별판매량과 일별누적판매량을 나타내세요. *** ---
        
 
        

        
        
        
        select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') AS panmaedate
              , panmaesu
        from tbl_panmae
        where jepumname = '새우깡';
        
        /*
        ---------------------------------------------
        판매일자           일별판매량       일별누적판매량
        ---------------------------------------------   
        2021-05-21      	10               10
        2021-05-22       	15               25
        2021-05-24 	        13               38
        2021-06-22           8               46
        2021-07-21          30               76
        ---------------------------------------------
        */
        
        select to_char(panmaedate, 'yyyy-mm-dd') AS 판매일자
                , sum(panmaesu) AS 일별판매량
                , sum(sum(panmaesu)) over(order by to_char(panmaedate, 'yyyy-mm-dd') asc ) AS 일별누적판매량
                -- sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
                -- 판매수를 날짜 오름차순 방향으로 누적합을 한다.
                -- 여기에 이미 order by가 있기 때문에 아래에 쓸 필요가 없다.
                
        from tbl_panmae
        where jepumname = '새우깡'
        group by to_char(panmaedate, 'yyyy-mm-dd');
           
    
        --- *** tbl_panmae 테이블에서 모든제품에 대한 일별판매량과 일별누적판매량을 나타내세요. *** ---  
   
        select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') AS panmaedate
              , panmaesu
        from tbl_panmae
        where jepumname = '감자깡';
        
        select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') AS panmaedate
              , panmaesu
        from tbl_panmae;
        where jepumname = '새우깡';
        
        /*
        -----------------------------------------------------------
        제품명         판매일자           일별판매량       일별누적판매량
        -----------------------------------------------------------   
        감자깡       2021-05-23            20              20
        감자깡       2021-06-23            10              30
        감자깡       2021-06-24             5              35
        감자깡       2021-07-21            15              50
        새우깡       2021-05-21      	      10              10
        새우깡       2021-05-22       	  15              25
        새우깡       2021-05-24 	          13              38
        새우깡       2021-06-22             8              46
        새우깡       2021-07-21            30              76
        .....       ..........           ...             ...
        -----------------------------------------------------------
        */
        
        
        
        select jepumname AS 제품명
                , to_char(panmaedate, 'yyyy-mm-dd') AS 판매일자
                , sum(panmaesu) AS 일별판매량
       --       , sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
       --                               order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
                , sum(sum(panmaesu)) over(partition by jepumname 
                                        order by to_char(panmaedate, 'yyyy-mm-dd') asc ) AS 일별누적판매량
        from tbl_panmae
        group by jepumname, to_char(panmaedate, 'yyyy-mm-dd');
        


        create or replace view view_panmae
        as
        select jepumname AS 제품명
                , to_char(panmaedate, 'yyyy-mm-dd') AS 판매일자
                , sum(panmaesu) AS 일별판매량
                , sum(sum(panmaesu)) over(partition by jepumname 
                                        order by to_char(panmaedate, 'yyyy-mm-dd') asc ) AS 일별누적판매량
        from tbl_panmae
        group by jepumname, to_char(panmaedate, 'yyyy-mm-dd');                
        -- View VIEW_PANMAE이(가) 생성되었습니다.
        
        select *
        from view_panmae
        where 제품명 in('감자깡', '새우깡');
        
        
        --- *** [퀴즈] tbl_panmae 테이블에서 판매일자가 1개월전 '01'일
        --- (즉, 현재가 2021년 7월 21일이니 2021년 6월 1일 부터)부터 판매된 모든제품에 대한 일별판매량과 일별누적판매량을 나타내세요. *** ---  
        
        select jepumname AS 제품명
                , to_char(panmaedate, 'yyyy-mm-dd') AS 판매일자
                , sum(panmaesu) AS 일별판매량
                , sum(sum(panmaesu)) over(partition by jepumname 
                                        order by to_char(panmaedate, 'yyyy-mm-dd') asc ) AS 일별누적판매량
        from tbl_panmae
        where panmaedate >= to_date(to_char(add_months(sysdate, -1), 'yyyy-mm-')||'01','yyyy-mm-dd') -- 2021년 06월 01일 00시 00분 00초
        group by jepumname, to_char(panmaedate, 'yyyy-mm-dd');
        
        
        
        --------------- ===== *** 아래처럼 나오도록 하세요 *** ===== ---------------
        
        -----------------------------------------------------------------------
        전체사원수         10대    20대    30대    40대    50대     60대
        -----------------------------------------------------------------------
        
        /*
        select trunc(extract(year from sysdate) - (태어난년도)  + 1, -1 ) AS AGELINE 
        from employees
        */

        
        
        select count(ageline) AS 전체사원수
            ,  sum( decode(ageline, 10, 1) ) AS "10대"
            ,  sum( decode(ageline, 20, 1) ) AS "20대"
            ,  sum( decode(ageline, 30, 1) ) AS "30대"
            ,  sum( decode(ageline, 40, 1) ) AS "40대"
            ,  sum( decode(ageline, 50, 1) ) AS "50대"
            ,  sum( decode(ageline, 60, 1) ) AS "60대"           
        from
        (
            select trunc( extract(year from sysdate) - ( to_number(substr(jubun, 1, 2)) + case when substr(jubun,7,1) in ('1','2') then 1900 else 2000 end )  + 1, -1 ) AS AGELINE 
            from employees
        ) V;
        
        
        --------------- ===== *** 아래처럼 나오도록 하세요 *** ===== ---------------
        
        select employee_id, first_name, job_id
        from employees;
        
        ---------------------------------------------------------------------------------------------------------------------------
        직종ID            남자기본급여평균    여자기본급여평균      기본급여평균      (남자기본급여평균-기본급여평균)    (여자기본급여평균-기본급여평균)        
        ---------------------------------------------------------------------------------------------------------------------------
        .........                        
        FI_ACCOUNT           7900             7950             7920                  -20                            30
        IT_PROG	             5700	          6000	           5760	                 -60	                       240
        .........
        
        
        
        select 직종ID
             , 남자기본급여평균
             , 여자기본급여평균
             , 기본급여평균
             , 남자기본급여평균-기본급여평균 AS 평균과남자평균차액
             , 여자기본급여평균-기본급여평균 AS 평균과여자평균차액
        from
        (
            select job_id AS 직종ID
                , nvl(trunc( avg( decode(GENDER, '남', salary) ) ), 0) AS 남자기본급여평균
                , nvl(trunc( avg( decode(GENDER, '여', salary) ) ), 0) AS 여자기본급여평균
                , trunc( avg(salary) ) AS 기본급여평균
            from
            (
                select job_id
                    , salary
                    , case when substr(jubun, 7, 1) in('1', '3') then '남' else '여' end AS GENDER 
                from employees
            ) V
            group by job_id
            order by 1 
        ) T;
        
        
        
        
        ------------------------------------------------------------------------------------------
        
        
        ---------- ======== **** Sub Query(서브쿼리) **** ======== ----------
       /*
        -- Sub Query(서브쿼리)란?
        select 문속에 또 다른 select 문이 포함되어져 있을 때 포함되어진 select 문을 Sub Query(서브쿼리) 라고 한다.
        
        
        
        
        select ...
        from ....       ==> Main Query(메인쿼리 == 외부쿼리)
        where ... in( select ....     ==> Sub Query(서브쿼리 == 내부쿼리)
                      from ..... )
       */
       
       
       /*
        employees 테이블에서
        기본급여가 제일 많은 사원과 기본급여가 제일 적은 사원의 정보를
        사원번호, 사원명, 기본급여로 나타내세요...

       */
       
 
       select min(salary)
       from employees;
       
       select max(salary)
       from employees;
       
       select employee_id AS 사원번호, first_name || ' ' || last_name AS 사원명, salary
       from employees
       where salary = (select min(salary) from employees) or salary = (select max(salary) from employees);
       

       select employee_id, first_name || ' ' || last_name, salary
       from employees
       where salary = (employees 테이블에서 salary 의 최대값) OR 
                      (employees 테이블에서 salary 의 최소값);
       
       employees 테이블에서 salary 의 최대값 => select max(salary) from employees; => 24000
       employees 테이블에서 salary 의 최소값 => select min(salary) from employees; => 2100
       
       
       
       select employee_id AS 사원번호
       , first_name || ' ' || last_name AS 사원명
       , salary AS 기본급여
       from employees
       where salary = (select max(salary) from employees) OR
             salary = (select min(salary) from employees);
                
        /*
        -------------------------------
        사원번호      사원명       기본급여
        -------------------------------
        100	    Steven King	    24000
        132	    TJ Olson	    2100
        */
        
        
        
        /*
           employees 테이블에서 부서번호가 60, 80번 부서에 근무하는 사원들중에
           월급이 50번 부서 직원들의 '평균월급' 보다 많은 사원들만 
           부서번호, 사원번호, 사원명, 월급을 나타내세요....
        */
        
        select avg( NVL( salary + (salary * commission_pct), salary) )
        from employees
        where department_id = 50
        group by department_id;
        
        select department_id AS 부서번호
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , NVL( salary + (salary * commission_pct), salary) AS 월급
        from employees
        where department_id in(60, 80) AND 
        NVL( salary + (salary * commission_pct), salary > (   select avg( NVL( salary + (salary * commission_pct), salary) )
                                                from employees
                                                where department_id = 50
                                                )
        order by 1, 4;

        
        select department_id AS 부서번호
            ,  employee_id AS 사원번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  nvl(salary+(salary*commission_pct), salary) AS 월급
        from employees
        where department_id in (60, 80) AND
              nvl(salary+(salary*commission_pct), salary) > (select avg(nvl(salary+(salary*commission_pct), salary))
                                                      from employees
                                                      where department_id = 50)
        order by 1, 4;
        
        50번 부서 직원들의 '평균월급'
        ==> select avg(nvl(salary+(salary*commission_pct), salary))
            from employees
            where department_id = 50;
            -- 3475.555555555555555555555555555555555556
            

            
        select department_id AS 부서번호
              , count(*) AS 인원수
              , to_char(round(count(*) / (select count(*) from employees) * 100, 1),'990.0') || '%' AS 백분율
        from employees
        group by rollup(department_id) 
        order by 1;
        
        
        ---- employees 테이블에서 성별로 인원수를 나타내세요. ----
        select decode(grouping(성별), 0, 성별, '전체') AS 남녀성별
        , count(*) as 인원수
        , to_char(round(count(*) / (select count(*) from employees) * 100, 1), '990.0') || '%' AS "백분율(%)" 
        from
        (
        select case when substr(jubun, 7, 1) in ('1', '3') then '남' else '여' end AS 성별
        from employees
        ) V
        group by rollup(성별);

        ------- ****** Sub Query(서브쿼리)에서 사용되어지는 ANY, ALL 에 대해서 알아봅니다. ****** -------
        /*
            Sub Query(서브쿼리)에서 사용되어지는 ANY 는 OR 와 흡사하고,
            Sub Query(서브쿼리)에서 사용되어지는 ALL 은 AND 와 흡사하다.
        */
        
        
        -- employees 테이블에서 salary 가 30번 부서에 근무하는 사원들의 salary 와 동일한 사원들만 추출하세요..
        -- 단, 출력시 30번 부서에 근무하는 사원은 제외합니다.
        
        select salary
        from employees
        where department_id = 30
        -- 11000 3100 2900 2800 2600 2500
        
        select department_id, first_name || ' ' || last_name, salary
        from employees
        where salary in ( select salary from employees where department_id = 30 );
        
        
        
        
        
        
        
        
        select salary 
        from employees 
        where department_id = 30; 
        
         /*
        30번 부서의 salary
            11000
            3100
            2900
            2800
            2600
            2500
        */
        
        desc employees;
        
        
        select department_id AS 부서번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  salary AS 기본급여
        from employees
        where NVL(department_id, -9999) != 30 AND
              salary in(11000, 3100, 2900, 2800, 2600, 2500)
        order by 1, 3;
        
        
        select department_id AS 부서번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  salary AS 기본급여
        from employees
        where NVL(department_id, -9999) != 30 AND
              salary in( select salary 
                         from employees 
                         where department_id = 30 )
        order by 1, 3;                 
        
        -- 위는 아래와 같다.       
                         
        select department_id AS 부서번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  salary AS 기본급여
        from employees
        where NVL(department_id, -9999) != 30 AND
              salary =ANY ( select salary 
                         from employees 
                         where department_id = 30 )                 
        order by 1, 3;
        
        -- 위는 아래와 같다.
        
       select department_id AS 부서번호
            ,  first_name || ' ' || last_name AS 사원명
            ,  salary AS 기본급여
        from employees
        where NVL(department_id, -9999) != 30 AND
              salary =ANY(11000, 3100, 2900, 2800, 2600, 2500)
        order by 1, 3;
        
        
        
        /*
            기본급여(salary)가 제일 많은 사원만
            사원번호, 사원명, 기본급여(salary)를 나타내세요.
        */
        
        select max(salary)
        from employees;
        
        select employee_id, first_name || ' ' || last_name, salary
        from employees
        where salary = (select max(salary) from employees);
        
        select employee_id, first_name || ' ' || last_name, salary
        from employees
        where salary >= ALL (select salary from employees);
        
        
        
        
        
        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary AS 기본급여
        from employees
        where salary = (select max(salary) from employees) -- 24000
        order by 3 desc;
        
        
        -- 위는 아래와 같다
        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary AS 기본급여
        from employees
        where salary >= ALL (select salary from employees)
        -- salary 가 모든 사원들보다 큰 경우        
--      salary   >=  (24000,17000,17000,9000,6000,4800,4800,4200,12008,.....................)


/*
        24000  >=  24000    참 AND
        24000  >=  17000    참 AND 
        24000  >=  17000    참 AND 
        24000  >=  9000    참 AND 
        24000  >=  6000    참 AND 
        24000  >=  4800    참 AND 
        24000  >=  4800    참 AND
        24000  >=  4200    참 AND
        24000  >=  12008    참 AND
        .................=====> 참
        
        
        
        
        17000  >=  24000    거짓 AND
        17000  >=  17000    참 AND 
        17000  >=  17000    참 AND 
        17000  >=  9000    참 AND 
        17000  >=  6000    참 AND 
        17000  >=  4800    참 AND 
        17000  >=  4800    참 AND
        17000  >=  4200    참 AND
        17000  >=  12008    참 AND
        ...................=====> 거짓        
        
        
*/

        /*
            수당(salary*commission_pct)이 제일 많은 사원만
            사원번호, 사원명, 기본급여(salary)를 나타내세요.
        */
        
        from employees
        where salary*commission_pct = (employees 테이블에서 salary * commission_pct 의 최대값);
        
        employees 테이블에서 salary*commission_pct 의 최대값
        ==> select max(salary*commission_pct) from employees;
        
        
        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary*commission_pct AS 수당
        from employees
        where salary*commission_pct = (select max(salary*commission_pct) from employees); -- 5600

        -- 위는 아래와 같다
        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary*commission_pct AS 수당
        from employees
        where salary*commission_pct >= ALL (select salary*commission_pct from employees);
        -- 결과물에 null 이 있기 때문에 결과가 안 나온다.
        -- 나열되어진 null 들과 값을 비교할 순 없으니 ALL은 작동할 수 없다.
        
        /*
            salary*commission_pct    >=    (5600,4050,3600,null......)
            5600    >=  5600 참 AND
            5600    >=  4050 참 AND
            5600    >=  3600 참 AND
            5600    >=  null AND 
            ..................
            ==> 거짓
        
        */
        
        
        ---- *** Sub Query(서브쿼리) 절에서 사용하는 ALL 은 사용시 주의를 요한다.
        ---- select 결과물에서 null 은 존재하지 않도록 만들어야 한다.
        ---- >= ALL 결과물 << 여기 결과물에는 NULL이 없어야 한다.
        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary*commission_pct AS 수당
        from employees
        where salary*commission_pct >= ALL (select salary*commission_pct from employees
                                            where salary*commission_pct is not null );        
        -- 145	John Russell	5600
        
        
 
 
        /*
            수당(salary*commission_pct)이 제일 적은 사원을 제외한 사원들만
            사원번호, 사원명, 기본급여(salary)를 나타내세요.
        */ 
        

        
        -- 1번 방법
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary*commission_pct AS 수당
        from employees
        where salary*commission_pct > (select min(salary*commission_pct) from employees)       
        order by 3;
 
        -- 2번 방법        
        select employee_id AS 사원번호
        ,      first_name || ' ' || last_name AS 사원명
        ,      salary*commission_pct AS 수당
        from employees
        where salary*commission_pct > ANY (select salary*commission_pct from employees)
        order by 3 asc;
                                       
        --              610     > (610, 620, 680, 720, 1100, NULL, .................)
        /*
                        610 > 610 거짓 OR
                        ..............
                        ===========> 거짓
                        620 > 610 참 OR
                        620 > 620 거짓 OR
                        ................
                        ===========> 참 (출력)
                        680 > 610 참 OR
                        ..............
                        ===========> 참 (출력)
        
        */
        order by 3;
        
        
        
        ------- ======= ***** Pairwise(쌍) Sub Query ***** ====== ------
        /*
            employees 테이블에서
            부서번호별로 salary 가 최대인 사원과
            부서번호별로 salary 가 최소인 사원의 정보를
            부서번호, 사원번호, 사원명, 기본급여를 나타내세요
        */
        
        
        select department_id, max(salary)
        from employees
        group by department_id;
        
        
        select department_id, min(salary)
        from employees
        group by department_id;
        
        
        select department_id, employee_id, first_name || ' ' || last_name, salary
        from employees
        where (department_id, salary) in ( select department_id, max(salary)
                                           from employees
                                           group by department_id )
        OR    (department_id, salary) in ( select department_id, min(salary)
                                           from employees
                                           group by department_id )
        order by 1, 4;
        
        
        
        
        
        select department_id, salary
        from employees
        order by 1, 2;
        
        
        
        
        /*
            ---------------------------------
            department_id           salary
            ---------------------------------
                10	                4400
                20	                6000
                20	                13000
                
                30	                2500
                30	                2600
                30	                2800
                30	                4200
                30	                9000
                30	                11000
               
                40	                6500
                .........................
                60	                4200
                60	                4800
                60	                4800
                60	                6000
                60	                9000
                .........................
                
            
            원하는 결과값    
            ---------------------------------
            department_id           salary
            ---------------------------------
                10	                4400
                20	                6000
                20	                13000
                30	                2500
                30	                11000
                40	                6500
                .........................
                60	                4200
                60	                9000
                .........................
                
                각각 부서번호에서 최소값과 최대값만 뽑아야 한다.
                
                예를 들어 60번을 기준으로 4200 과 9000 만 나와야 한다.
                >> 30번의 4200 과 9000 은 나와선 안된다!!!
                
        */
        
        
        
        select department_id, min(salary)
        from employees
        group by department_id
        ---- ..     ....
        ---- 30     2500
        ---- ..     ....
        ---- 60     4200
        ---- ..     ....
        
        select department_id, max(salary)
        from employees
        group by department_id
        ---- ..     .....
        ---- 30     11000
        ---- ..     .....
        ---- 60     9000
        ---- ..     .....    
        
        
        select department_id as 부서번호
        , employee_id as 사원번호
        , first_name || ' ' || last_name as 사원명
        , salary as 기본급여
        from employees
        where (department_id, salary) in (select department_id, min(salary)
                                          from employees
                                          group by department_id)  -- 30번이면서 2500(최소), 60번이면서 4200(최소) 
               OR
              (department_id, salary) in (select department_id, max(salary)
                                          from employees
                                          group by department_id)  -- 30번이면서 11000(최대), 60번이면서 9000(최대)
       order by 1, 4;
       
       -- (department_id, salary)를 한 조건으로 묶어서, 조건이 30번이면서 2500 인것과 30번이면서 11000인 것만 출력한다.
       
       
       
       
       
        select department_id as 부서번호
        , employee_id as 사원번호
        , first_name || ' ' || last_name as 사원명
        , salary as 기본급여
        from employees
        where (NVL(department_id, -9999), salary) in (select NVL(department_id, -9999), min(salary)
                                                      from employees
                                                      group by department_id)  
               OR
              (NVL(department_id, -9999), salary) in (select NVL(department_id, -9999), max(salary)
                                                      from employees
                                                      group by department_id)  
       order by 1, 4;
       
       
       
---------------------------------------------------------------------------------------------------------       
       
       
       
    create table tbl_authorbook
       (bookname       varchar2(100)
       ,authorname     varchar2(20)
       ,loyalty        number(5)
       );
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('자바프로그래밍','이순신',1000);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','한석규',800);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','이순신',500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('조선왕조실록','엄정화',2500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','유관순',1200);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','이혜리',1300);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','서강준',1700);

   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('어린왕자','김유신',1800);
   
   commit;       
       
       
       
   
   select *
   from tbl_authorbook;    
       
   --- tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명은 다른 도서)로 지어진 도서정보를 나타내세요.. ----
       
       
   /*
   
    -----------------------------------
    도서명         작가명         로얄티
    -----------------------------------
    로빈슨크루소    한석규          800
    로빈슨크루소    이순신          500
    그리스로마신화   유관순         1200
    그리스로마신화   이혜리         1300
    그리스로마신화   서강준         1700
   
   */


    select bookname, count(*)
    from tbl_authorbook
    group by bookname;


    select bookname, count(*)
    from tbl_authorbook
    group by bookname
    having count(*) > 1;
    
    
    select bookname
    from tbl_authorbook
    group by bookname
    having count(*) > 1;
    
    
    
    select *
    from tbl_authorbook
    where bookname in ('로빈슨크루소', '그리스로마신화');
    
    select *
    from tbl_authorbook
    where bookname in (    select bookname
                            from tbl_authorbook
                            group by bookname
                            having count(*) > 1);
                            
                            
                            
                            
    -------------------- ****** 상관서브쿼리(=서브상관쿼리) ****** ----------------------------
    -- 7월 22일 수업
    /*
        상관서브쿼리 이라함은 Main Query(== 외부쿼리)에서 사용된 테이블(뷰)에 존재하는 컬럼이
        Sub Query(== 내부쿼리)의 조건절(where절, having절)에 사용되어질때를 
        상관서브쿼리(== 서브상관쿼리)라고 부른다.
    */
    
    --- employees 테이블에서 기본급여에 대해 전체등수 및 부서내등수를 구하세요
    -- 첫번째 방법은 rank() 함수를 사용하여 구해본다.
    
    select department_id, employee_id, first_name || ' ' || last_name, salary
    , rank() over(order by salary desc)
    , rank() over(partition by department_id order by salary desc)
    from employees
    order by 1, 4 desc;
    
    
    select department_id AS 부서번호
        , employee_id AS 사원번호
        , salary AS 기본급여
        , rank() over(order by salary desc) AS 전체등수
        , rank() over(partition by department_id order by salary desc) AS 부서내등수
    from employees
    order by 1, 3 desc;
    
    
    --- employees 테이블에서 기본급여에 대해 전체등수 및 부서내등수를 구하세요
    -- 두번째 방법은 count(*) 이용하여 상관서브쿼리를 사용하여 구해본다.

    select salary
    from employees;
    
    
    select salary
    from employees
    where salary > 12008; -- 자신의 기본급여가 12008 이라면
    
    
    select count(salary)
    from employees
    where salary > 12008; -- 자신의 기본급여가 12008 이라면 나보다 큰 사람은 6 명이다.
    
    
    select count(salary) + 1 AS 등수
    from employees
    where salary > 12008; -- 자신의 기본급여가 12008 이라면 나보다 큰 사람은 6 명이다.
    
    select  E.department_id AS 부서번호
        , E.employee_id AS 사원번호
        , E.salary AS 기본급여
        , ( select count(salary)+1
            from employees
            where salary > E.salary ) AS 전체등수  -- 여기 자리에는 매번 자기의 salary가 들어가야한다.
    from employees E
    order by 3 desc;
    
    
    select  department_id AS 부서번호
        , employee_id AS 사원번호
        , salary AS 기본급여
        , ( select count(salary)+1
            from employees
            where salary > E.salary ) AS 전체등수  -- 여기 자리에는 별칭을 빼면 안 된다. // 왜냐면 계속 자기자신과 비교만 하니깐
        , ( select count(salary)+1
            from employees
            where department_id = E.department_id AND salary > E.salary ) AS 부서내등수
        from employees E
    order by 1,3 desc;

    
    ----- **** Sub Query 를 사용하여 테이블을 생성할 수 있다. **** ---------------------------------
    create table tbl_employees_3060
    as
    select department_id
         , employee_id
         , first_name || ' ' || last_name AS ENAME
         , NVL(salary + (salary * commission_pct), salary) AS MONTHSAL
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
         , jubun
    from employees
    where department_id in (30, 60);
    
    select * from tab;
    
    
    -- employees 테이블을 가지고 데이터없이 테이블구조만 동일한 tbl_employees_sub 이라는 테이블을 생성하기
    
    select *
    from employees
    where 1=1;
    
    create table tbl_employees_sub
    as
    select *
    from employees
    where 1=2;
    -- Table TBL_EMPLOYEES_SUB이(가) 생성되었습니다.
    
    select *
    from TBL_EMPLOYEES_SUB;
    
    desc employees;
    desc tbl_employees_sub;
    
    
    ----- ***** !!!!! 필수로 꼭 알아두시길 바랍니다. !!!!! ***** ---------------------------------
    ----- 상관서브쿼리(서브상관쿼리)를 사용한 UPDATE 처리하기
    /*
        회사에 입사하셔서 delete 또는 update 를 할 때 먼저 반드시 해당 테이블을 백업두시고 하시길 바랍니다.
        실수하면 복구하기 위한 것이다.
    */
    
    create table tbl_employees_backup
    as
    select *
    from employees; -- select문을 가지고 테이블을 만들 수 있다. // 백업생성
    -- Table TBL_EMPLOYEES_BACKUP이(가) 생성되었습니다.
    
    select *
    from tbl_employees_backup;
    
    update employees set first_name = '순신', last_name ='이';
    -- where 조건절을 써서 특정 행만 바꿔야 하는데 모르고 다 바꿔버린 것이다.
    -- 107개 행 이(가) 업데이트되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select *
    from employees;
    -- 모르고 모든 이름을 '이순신'으로 바꿔버린 상황이다.
    -- 복구를 해야한다.
    set hidden param parseThreshold = 150000;
    
    
    update employees E 
    set first_name = ( select first_name 
                       from tbl_employees_backup
                       where employee_id = E.employee_id ) -- where의 사원번호가 계속해서 바껴서 107개의 모든 사원들의 번호가 들어가야 한다.
      , last_name = ( select last_name
                      from tbl_employees_backup
                      where employee_id = E.employee_id ); -- 뒤쪽 employee_id는 backup에 있는 사원번호가 아닌, 임의로 수정된 사원번호가 나와야 한다.
                    -- E 를 적지 않으면, 둘 다 똑같아져서 구분시켜줘야 따로 동작한다.
                    
    -- 107개 행 이(가) 업데이트되었습니다.   
    -- 복구완료
    
    commit;
    -- 커밋 완료.
    
    
    
    ---- **** Sub Query 절을 사용하여 데이터를 입력(insert)할 수 있다. ----------------------------
    
    select *
    from TBL_EMPLOYEES_3060;
    -- 원래는 30, 60번 부서번호의 데이터들만 있었지만 
    -- 40, 50 부서번호의 데이터들도 추가하려고 한다.
    
    
    insert into tbl_employees_3060
    select department_id
         , employee_id
         , first_name || ' ' || last_name AS ENAME
         , NVL(salary + (salary * commission_pct), salary) AS MONTHSAL
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
         , jubun
    from employees
    where department_id in (40, 50)
    order by 1;
    -- 46개 행 이(가) 삽입되었습니다.
    
    -- rollback; 
    -- 롤백 완료.
    
    commit;
    -- 커밋 완료.
    
    
    
    ---- **** Sub Query 절을 사용하여 데이터를 수정(update)할 수 있다. ----------------------------
    
    -- tbl_employees_3060 테이블에서 부서번호 60번에 해당하는 사원들의 월급(monthsal)을 
    -- 부서번호 30번에 해당하는 사원들의 평균 monthsal 값으로 변경하세요.
    
    update tbl_employees_3060 set monthsal = ( 부서번호 30번에 해당하는 사원들의 평균 monthsal )
    where department_id = 60;
   
   
   
   
    update tbl_employees_3060
    set monthsal = ( select avg(monthsal)
                     from tbl_employees_3060
                     where department_id = 30 ) --4150
    where department_id = 60;
    -- 5개 행 이(가) 업데이트되었습니다.
    
    select *
    from tbl_employees_3060;
    
    rollback;
    
    
    
    ---- **** Sub Query 절을 사용하여 데이터를 삭제(delete)할 수 있다. ----------------------------    
    
    select *
    from tbl_employees_3060;
    -- 부서번호 60, 50 에 해당하는 데이터를 지우려고 한다.
    
    ---- **** tbl_employees_3060 테이블에서 부서번호가 60, 50 인 행들을 삭제하세요
    delete from tbl_employees_3060
    where department_id in (60, 50); -- 만약에 where 절을 안 쓰면 이 테이블에 있는 모든 행을 다 지워버린다.
    -- 50개 행 이(가) 삭제되었습니다.
    
    rollback;
    -- 롤백 완료.
    
    ---- **** tbl_employees_3060 테이블에서 monthsal 이 평균 monthsal 보다 작은 행들만 삭제하세요.
    
    delete from tbl_employees_3060
    where monthsal < ( 평균 monthsal );
    
    
    delete from tbl_employees_3060
    where monthsal < ( select avg(monthsal) from tbl_employees_3060 ); -- 3800
    -- 40개 행 이(가) 삭제되었습니다.
    
    select *
    from tbl_employees_3060;    
    -- 월급이 3800 보다 큰 데이터만 남았다.
    
    rollback;
    -- 롤백 완료.
    
    
    
    
    
    -----------------------------------------------------------------------------------------------
    
    
    -----------------------------------------------------------------------------------------------
    -- !!!! 중요          JOIN 은 면접에 가시면 무조건 물어봅니다.               중요!!!! --
    -----------------------------------------------------------------------------------------------
                
                                ------- ====== JOIN ====== -------
    
     /*
        JOIN(조인) 테이블(뷰)과 테이블(뷰)을 합치는 것을 말하는데
        행(ROW) 과 행(ROW)을 합치는 것이 아니라, 컬럼(COLUMN)과 컬럼(COLUMN)을 합치는 것이다.
        위에서 말한 행(ROW) 과 행(ROW) 을 합치는 것은 UNION 연산자를 사용하는 것이다.
        
        
        -- 면접질문 : INNER JOIN(내부조인)과 OUTER JOIN(외부조인)의 차이점에 대해 말해보세요.
        -- 면접질문 : JOIN과 UNION 의 차이점에 대해 말해보세요.
        
        
        집합 A = (1, 2, 3)        원소가 3개
        집합 B = (a, b)           원소가 2개
        
        집합 A 와 집합 B로 만들 수 있는 모든 경우의 수 = 데카르트곱 3 * 2 = 6
        
        A ⊙ B = ( (1,a), (1,b)
                ,  (2,a), (2,b)
                ,  (3,a), (3,b)  )
        데카르트곱(수학) ==> 원소의 곱: 3 * 2 = 6(모든 경우의 수)
        --> 수학에서 말하는 데카르트곱을 데이터베이스에서는 Catersian Product 라고 부른다.
        
        
        
        JOIN => SQL 1992 CODE 방식 -> 테이블(뷰) 과 테이블(뷰) 사이에 콤마(,)를 찍어주는 것,
                                     콤마(,)를 찍어주는 것을 제외한 나머지 문법은 데이터베이스 밴더(회사) 제품마다 조금씩 다르다.
        
        JOIN => SQL 1999 CODE 방식(ANSI) -> 테이블(뷰) 과 테이블(뷰) 사이에 JOIN 이라는 단어를 넣어주는 것.
                                            ANSI(표준화) SQL
                                           
     */
    
    
    select *
    from employees;
    
    
    select count(*)
    from employees; -- 107 개행
    
    select *
    from departments;
    
    select count(*)
    from departments; -- 27 개행
    
    select *
    from employees, departments; --> SQL 1992 CODE 방식, Catersian Product
    -- employees 컬럼 + departments 컬럼 합치기
    -- departments의 department_id 이 10을 107명에 다 넣고, 20을 107명에 다 넣고
    
    select count(*)
    from employees, departments;    --> SQL 1992 CODE 방식
                                    -- 2889 개행
    select 107 * 27  -- 2889                    
    from dual;
    
    
    select *
    from employees CROSS JOIN departments; --> SQL 1999 CODE 방식, Catersian Product

    
    select count(*)
    from employees CROSS JOIN departments;    --> SQL 1999 CODE 방식
                                              -- 2889 개행
    
    /*
        1. CROSS JOIN 은 프로야구를 예로 들면 10개팀이 있는데 
           각 1팀당 경기를 몇번해야 하는지 구할때 쓰인다. 1팀당 모든 팀과 경기를 펼쳐야 한다.
           
        2.CROSS JOIN 은 그룹함수로 나온 1개의 행을 가지고 어떤 데이터 값을 얻으려고 할때 사용된다.
    */
    
    
    
    -- [ CROSS JOIN 사용 예 ]
    /*
        사원번호    사원명     부서번호      기본급여      모든사원들이기본급여평균   기본급여평균과의차액
        이것이 나오도록 하세요...
    */
    
    select employee_id AS 사원번호
        ,  first_name || ' ' || last_name AS 사원명
        ,  department_id AS 부서번호
        ,  salary AS 기본급여
        ,  avg(salary) AS 기본급여평균 -- 이거는 그룹함수여서 행이 1개 밖에 안 나온다.
                                     -- 6461.831775700934579439252336448598130841
    from employees;
    -- 데이터베이스는 사각형 모양이 떨어져야 한다.
    
    
    
    select employee_id AS 사원번호
        ,  first_name || ' ' || last_name AS 사원명
        ,  department_id AS 부서번호
        ,  salary AS 기본급여
    from employees; -- 107 개행
    
    select trunc( avg(salary) ) AS 기본급여평균 -- 6461
    from employees; -- 1 개행
    

    
    -- 사원번호   사원명   부서번호   기본급여   +   기본급여평균    ==> 컬럼과 컬럼을 붙이는 것이다. ==> JOIN
    
    select *
    from
    ( select employee_id AS 사원번호
          ,  first_name || ' ' || last_name AS 사원명
          ,  department_id AS 부서번호
          ,  salary AS 기본급여
      from employees ) A -- A 는 행이 107개행이다.
    ,
    ( select trunc( avg(salary) ) AS 기본급여평균
      from employees ) B; -- B 는 행이 1개행이다.
      
      
    select A.EMPLOYEE_ID AS 사원번호
    , A.ENAME AS 사원명
    , A.DEPARTMENT_ID AS 부서번호
    , A.SALARY AS 기본급여
    , B.SALARY_AVG AS 기본급여평균
    , (A.SALARY - B.SALARY_AVG) AS 기본급여평균과의차액
    from
    ( select employee_id 
          ,  first_name || ' ' || last_name AS ENAME
          ,  department_id
          ,  salary 
      from employees ) A -- A 는 행이 107개행이다.
    ,
    ( select trunc( avg(salary) ) AS SALARY_AVG
      from employees ) B; -- B 는 행이 1개행이다.
      
    -- 이제 내가 평균보다 많이 받나, 적게 받나를 알고싶다.
    
    
    -- 위와 아래는 똑같다.
    
    select A.EMPLOYEE_ID AS 사원번호
    , A.ENAME AS 사원명
    , A.DEPARTMENT_ID AS 부서번호
    , A.SALARY AS 기본급여
    , B.SALARY_AVG AS 기본급여평균
    , (A.SALARY - B.SALARY_AVG) AS 기본급여평균과의차액
    from
    ( select employee_id 
          ,  first_name || ' ' || last_name AS ENAME
          ,  department_id
          ,  salary 
      from employees ) A -- A 는 행이 107개행이다.
    CROSS JOIN
    ( select trunc( avg(salary) ) AS SALARY_AVG
      from employees ) B; -- B 는 행이 1개행이다.
      
      
      
    ----------------- **** EQUI JOIN (SQL 1992 CODE 방식 ) **** -----------------
    /*
        [EQUI JOIN 예]
        
        부서번호     부서명     사원번호     사원명     기본급여
        이 나오도록 하세요...
    */
    
    /*
        부서번호                             부서명                                사원번호     사원명     기본급여
        -------------------------    ---------------------------                --------------------------
        departments.department_id     departments.department_name               employees.employee_id, first_name, last_name, salary
        employees.department_id
    
    */
    
    
    
    
    select *
    from employees , departments
    where employees.department_id = departments.department_id -- 원래 자기의 부서번호 값과 // departments의 부서번호 값이 같은 것 끼리만 매핑해라
    
    
    select *
    from employees E, departments D
    where E.department_id = D.department_id;
    -- 별칭으로 안 쓰면 오류가 뜬다.
    -- 행이 106개이다, 부서가 미지정(NULL)된 Kimberely Grant가 없다.
    -- EQUI JOIN은 NULL은 다 빼버린다.
    
    -- ==== 틀린 풀이 ==== ---------------------------------------------------------    
    
    SELECT *
    FROM DEPARTMENTS;
    
    
    select *
    from employees E, departments D
    where NVL(E.department_id,-9999) = D.department_id;
    -- NVL 처리를 해도 구할 수 없다.
    -- ※ 애초에 DEPARTMENTS 테이블에는 NULL 값도 없으며, -9999 도 없다.
    -- ※ DEPARTMENTS 에는 우리 회사에 실제로 존재하는 부서번호만 있다.


    -- ==== 맞는 풀이 ==== ---------------------------------------------------------    
    
    
    select *
    from employees E, departments D
    where E.department_id = D.department_id(+);   
    
    -- 1. 일단 EMPLOYEES 테이블을 모두 다 보여줘야 한다. (107명)
    -- 2. 그런 다음에 결합시켜줘야 한다. D.department_id(+); 라고 써준다.
    -- (+)의 뜻은? 
    /*
        (+)는 (+)가 안 붙은 테이블인 E (employees) 의 모든 행을 출력해주고 나서 그 다음에 
        where E.department_id = D.department_id 조건에 만족하는 행들을 보여준다.
        Kimberely Grant는 조건에 만족하지 않아서, 연결시켜줄 부서가 없기 때문에 departments의 내용은 모두 NULL로 표시한다.
        나머지 사원들은 서로 연결될 departments의 내용들이 있기 때문에 알아서 연결되어 내용이 표시된다.
        
    */
    
    --- *** department_id 가 NULL인 '킴벨리그랜트' 는  출력되지 않는다. *** ---
    
    select E.department_id AS 부서번호  -- department_id 컬럼은 employees 테이블과 departments 테이블 양쪽에 존재하므로 반드시 소속을 밝혀야 한다.(E.department_id)
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E, departments D
    where E.department_id = D.department_id;   -- 106 개행
    -- ==> 이렇게하면 오류가 나온다.
    -- ==> 컬럼이 애매모호하다고 나온다.
    -- ==> department_id 는 양 쪽 테이블에 다 있기 때문에 소속을 확실하게 정해줘야 한다.
    
    -- ==> WHERE 절에서 EMPLOYEES에 기입된 부서번호에 맞게 나오도록 했기 때문에
    -- ==> D.부서번호 D.부서명     (E.부서번호) E.사원명
    -- ==> 서로 비교해서 맞는 것끼리만 붙여준다. 
    
    -- ==> select 에는 D.부서번호, E.부서번호 둘 중에 아무거나 쓰면 된다.
    
    
    ---- 위의 where 절을 JOIN 조건절 이라고 부른다.
    
    
    
    
    
    
    --- *** employees 테이블에서 department_id 컬럼의 값이 NULL 인 '킴벨리그랜트'도 출력하고자 한다. *** ---
    
    select E.department_id AS 부서번호  -- department_id 컬럼은 employees 테이블과 departments 테이블 양쪽에 존재하므로 반드시 소속을 밝혀야 한다.(E.department_id)
        , department_name AS 부서명     -- department_name 컬럼은 departments 테이블에만 있으므로 D.department_name 또는 department_name 으로 쓰면 된다.
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E, departments D
    where E.department_id = D.department_id(+);    -- 107 개행
    ---- 위의 where 절을 JOIN 조건절 이라고 부른다.
    
    /*
        (+)가 안 붙은 테이블인 E (employees) 의 모든 행을 출력해주고 나서 그 다음에 
        where E.department_id = D.department_id 조건에 만족하는 행들을 보여준다.
       
    */
    
    
    
    
    select D.department_id AS 부서번호
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E, departments D
    where E.department_id(+) = D.department_id;
    ---- 위의 where 절을 JOIN 조건절 이라고 부른다.   
    
    /*
        (+)가 안 붙은 테이블인 D (departments) 의 모든 행을 출력해주고 나서 그 다음에 
        where E.department_id = D.department_id 조건에 만족하는 행들을 보여준다.
       
    */
    
    
    
    
    
    
    
    ----------------- **** INNER JOIN (SQL 1999 CODE 방식 ) **** -----------------
    /*
        [INNER JOIN 예]
        
        부서번호     부서명     사원번호     사원명     기본급여
        이 나오도록 하세요...
    */
    
    /*
        부서번호                             부서명                                사원번호     사원명     기본급여
        -------------------------    ---------------------------                --------------------------
        departments.department_id     departments.department_name               employees.employee_id, first_name, last_name, salary
        employees.department_id
    
    */    
    
    --- *** department_id 가 NULL인 '킴벨리그랜트' 는  출력되지 않는다. *** ---
    
    select E.department_id AS 부서번호  -- department_id 컬럼은 employees 테이블과 departments 테이블 양쪽에 존재하므로 반드시 소속을 밝혀야 한다.(E.department_id)
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E INNER JOIN departments D
    ON E.department_id = D.department_id;
    -- 위의 ON 절을 JOIN 조건절 이라고 부른다.







     ----------------- ****  LEFT OUTER JOIN, RIGHT OUT JOIN, FULL OUT JOIN (SQL 1999 CODE 방식 ) **** -----------------
     --- *** employees 테이블에서 department_id 컬럼의 값이 NULL 인 '킴벨리그랜트'도 출력하고자 한다. *** ---

    select E.department_id AS 부서번호  
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E  LEFT OUTER JOIN departments D
    ON E.department_id = D.department_id;
    
    
    select E.department_id AS 부서번호  
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E  LEFT JOIN departments D -- OUTER 는 생략가능하다.
    ON E.department_id = D.department_id;
    
    
    
    select D.department_id AS 부서번호  
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E RIGHT OUTER JOIN departments D
    ON E.department_id = D.department_id;
    
    
    select D.department_id AS 부서번호  
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E RIGHT JOIN departments D -- OUTER 는 생략가능하다.
    ON E.department_id = D.department_id;
    
    
    
    select D.department_id AS 부서번호  
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E FULL OUTER JOIN departments D
    ON E.department_id = D.department_id;
    -- '킴벨리그랜트도' 도 보여주고, 우리가 일하지 않는 부서정보들도 보여준다.
    
    select D.department_id AS 부서번호  
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from employees E FULL JOIN departments D -- OUTER 는 생략가능하다.
    ON E.department_id = D.department_id;
    
    
    
    /*  ----------------
         SQL 1999 CODE
        ----------------
        
        
        == 1. CROSS JOIN 모든 경우의 수를 다 보여준다. ====> 모든 경우의 수 값을 다 보여준다.
        1. from A CROSS JOIN  B 
        
        
        
        == 2. INNER JOIN 또는 JOIN ==
        from A JOIN B
        ON A.공통컬럼명 = B.공통컬럼명 ==> A.공통컬럼명 또는 B.공통컬럼명에 값이 NULL인 것은 출력하지 않는다.
        
        
        
        == 3.LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN 
                또는 LEFT JOIN, RIGHT JOIN, FULL JOIN ==
                
           FROM A LEFT JOIN B
           
          ON A.컬럼명 = B.컬럼명  ==> A.컬럼명의 값이 NULL 인 것도 출력된다.
           -- A 테이블에 존재하는 모든 행들의 값을 출력해주고 그 다음에 A.컬럼명 = B.컬럼명 조건에 맞는 행들을 출력해준다.
           
           
           FROM A RIGHT JOIN B
         ON. B.컬럼명 = A.컬럼명 ==> B.컬럼명의 값이 NULL 인 것도 출력된다.
          -- B 테이블에 존재하는 모든 행들의 값을 출력해주고 그 다음에 A.컬럼명 = B.컬럼명 조건에 맞는 행들을 출력해준다.
                
                      
           from A FULL JOIN B
           A.컬럼명의 값과 B.컬럼명의 값이 NULL 인 것도 출력된다.
        -- A 테이블과 B 테이블에 존재하는 모든 행들의 값을 출력해주고 그 다음에 A.컬럼명 = B.컬럼명 조건에 맞는 행들을 출력해준다.
        
            
    
    */
    
    
    
    
    
    
    
    ---- **** JOIN 을 사용한 응용문제 **** ----
    /*
        아래와 같이 나오도록 하세요.
        
        부서번호     사원번호     사원명     기본급여     부서평균기본급여    부서평균과의차액
        
        
        
        ---------------------------       --------------------------------------------
          부서번호   부서평균기본급여          부서번호   사원번호   사원명    기본급여
        ---------------------------       --------------------------------------------
            10          3500                 10        1001     홍길동    3700
            20          4000                 10        1002     이순신    2500
            30          2800                 20        2001     엄정화    3500
            ..          ....                 20        2002     유관순    4500
            110         3200                 ..        ....     .....    .....
         --------------------------       ---------------------------------------------

    
    */
    

    select V1.department_id AS 부서번호
    , employee_id AS 사원번호
    , ENAME AS 사원명
    , salary AS 기본급여
    , DEPT_AVG_SAL AS 부서평균기본급여
    , (salary-DEPT_AVG_SAL) AS 부서평균과의차액
    from 
    ( 
        select department_id, employee_id, first_name || ' ' || last_name AS ENAME, salary
        from employees 
    ) V1 
        JOIN 
    ( 
        select DEPARTMENT_ID
             , TRUNC(avg(salary)) AS DEPT_AVG_SAL
        from employees
        group by department_id 
    ) V2 
    ON nvl(V1.department_id, -9999) = nvl(V2.department_id, -9999)
    order by 1, 4 desc;
    
    
    
    
    
    /*
        [퀴즈] 아래와 같이 나오도록 하세요.
        
        -----------------------------------------------------------------------------------------------------------------
        부서번호     사원번호     사원명     기본급여     부서평균기본급여    부서평균과의차액     부서내기본급여등수      전체기본급여등수
        -----------------------------------------------------------------------------------------------------------------
   */ 
    
    
    select V1.department_id AS 부서번호
    , employee_id AS 사원번호
    , ENAME AS 사원명
    , salary AS 기본급여
    , DEPT_AVG_SAL AS 부서평균기본급여
    , (salary-DEPT_AVG_SAL) AS 부서평균과의차액
    , rank() over(partition by V1.department_id order by salary desc) AS 부서내기본급여등수
    , rank() over(order by salary desc) AS 전체기본급여등수
    from 
    ( 
        select department_id, employee_id, first_name || ' ' || last_name AS ENAME, salary
        from employees 
    ) V1 
        JOIN 
    ( 
        select DEPARTMENT_ID
             , TRUNC(avg(salary)) AS DEPT_AVG_SAL
        from employees
        group by department_id 
    ) V2 
    ON nvl(V1.department_id, -9999) = nvl(V2.department_id, -9999)
    order by 1, 4 desc;
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
        [퀴즈] 부서번호가 10, 30, 50번 부서에 근무하는 사원들만 아래와 같이 나오도록 하세요.
        
        -----------------------------------------------------------------------------------------------------------------
        부서번호     사원번호     사원명     기본급여     부서평균기본급여    부서평균과의차액     부서내기본급여등수      전체기본급여등수
        -----------------------------------------------------------------------------------------------------------------
   */ 
    
    
    select V1.department_id AS 부서번호
    , employee_id AS 사원번호
    , ENAME AS 사원명
    , salary AS 기본급여
    , DEPT_AVG_SAL AS 부서평균기본급여
    , (salary-DEPT_AVG_SAL) AS 부서평균과의차액
    , rank() over(partition by V1.department_id order by salary desc) AS 부서내기본급여등수
    , rank() over(order by salary desc) AS 전체기본급여등수
    from 
    ( 
        select department_id, employee_id, first_name || ' ' || last_name AS ENAME, salary
        from employees
        
    ) V1 
        JOIN 
    ( 
        select DEPARTMENT_ID
             , TRUNC(avg(salary)) AS DEPT_AVG_SAL
        from employees
        group by department_id 
    ) V2 
    ON nvl(V1.department_id, -9999) = nvl(V2.department_id, -9999)
    where V1.department_id in (10, 30, 50)
    order by 1, 4 desc;
    
    
    ------ ****** 위의 풀이과정도 맞지만, 아래의 풀이과정을 권장한다.
    
    
    
    select V1.department_id AS 부서번호
    , employee_id AS 사원번호
    , ENAME AS 사원명
    , salary AS 기본급여
    , DEPT_AVG_SAL AS 부서평균기본급여
    , (salary-DEPT_AVG_SAL) AS 부서평균과의차액
    , rank() over(partition by V1.department_id order by salary desc) AS 부서내기본급여등수
    , rank() over(order by salary desc) AS 전체기본급여등수
    from 
    ( 
        select department_id, employee_id, first_name || ' ' || last_name AS ENAME, salary
        from employees 
        where department_id in (10,30,50)
    ) V1 
        JOIN 
    ( 
        select DEPARTMENT_ID
             , TRUNC(avg(salary)) AS DEPT_AVG_SAL
        from employees
        where department_id in (10,30,50)
        group by department_id 
    ) V2 
    ON V1.department_id = V2.department_id -- JOIN 조건절
    order by 1, 4 desc;
    
    ------ 아래에 방법을 사용하면 처음부터 10, 30, 50 번 부서들만 메모리에 퍼올리기 때문에
    ------ 메모리 낭비가 덜 하다.
    
    -- 또는
    ---- ===== 07월 23일 with 절을 사용한 inline view 를 사용한 JOIN  ===== ------
    with V1 as ( 
            select department_id, employee_id, first_name || ' ' || last_name AS ENAME, salary
            from employees 
            where department_id in (10,30,50)
        ),   V2 as ( 
            select DEPARTMENT_ID
                 , TRUNC(avg(salary)) AS DEPT_AVG_SAL
            from employees
            where department_id in (10,30,50)
            group by department_id 
        )
    select V1.department_id AS 부서번호
        , employee_id AS 사원번호
        , ENAME AS 사원명
        , salary AS 기본급여
        , DEPT_AVG_SAL AS 부서평균기본급여
        , (salary-DEPT_AVG_SAL) AS 부서평균과의차액
        , rank() over(partition by V1.department_id order by salary desc) AS 부서내기본급여등수
        , rank() over(order by salary desc) AS 전체기본급여등수
        from V1 JOIN V2 
        ON V1.department_id = V2.department_id -- JOIN 조건절
        order by 1, 4 desc;    
    
    
    
    ----------------- **** NON-EQUI JOIN **** -----------------
    
    /*
        JOIN 조건절에 사용되는 컬럼의 값이 특정한 범위에 속할 때 사용하는 것이 NON-EQUI JOIN 이다.
        NON-EQUI JOIN 에서는 JOIN 조건절에 = 을 사용하는 것이 아니라 between A and B 를 사용한다.
    */
    
    
    -- 소득세율 지표 관련 테이블을 생성한다. 
     create table tbl_taxindex
      (lowerincome   number       -- 연봉의 최저
      ,highincome    number       -- 연봉의 최대
      ,taxpercent    number(2,2)  -- 세율  -0.99 ~ 0.99 
      );
       
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(1, 99999, 0.02);
    
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(100000, 149999, 0.05);
    
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(150000, 199999, 0.08);
    
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(200000, 10000000000000000, 0.1);
    
      commit; 
      
      select *
      from tbl_taxindex;
      
      ----------------------------------------------------------------------
      사원번호        사원명        연봉        세율        소득세액
      ----------------------------------------------------------------------
      1001          홍길동        50000      0.02     50000 * 0.02 = 1000
      1002          엄정화       170000      0.08    170000 * 0.08 = 13600
      ....          .....       ......      ....    .....................
      ----------------------------------------------------------------------
      
      
      
      --- SQL 1992 CODE ---
      /*
      --------------------------------------          ----------
        사원번호        사원명        연봉                   세율
      --------------------------------------          ----------
                employees 테이블                     tbl_taxindex 테이블
      
      
      */
      
      
      select employee_id AS 사원번호
      , first_name || ' ' || last_name AS 사원명
      , nvl( salary + ( salary * commission_pct ), salary)*12 AS 연봉
      , T.*
      from employees e, tbl_taxindex t ---- SQL 1992 CODE 방식
      where nvl(salary + (salary * commission_pct), salary)*12 between T.lowerincome AND T.highincome; --JOIN 조건절
      
      
      select employee_id AS 사원번호
      , first_name || ' ' || last_name AS 사원명
      , nvl( salary + ( salary * commission_pct ), salary)*12 AS 연봉
      , taxpercent as 세율
      , nvl( salary + ( salary * commission_pct ), salary)*12 * taxpercent AS 소득세액
      from employees e, tbl_taxindex t ---- SQL 1992 CODE 방식
      where nvl(salary + (salary * commission_pct), salary)*12 between T.lowerincome AND T.highincome --JOIN 조건절
      order by 1;
      
      
      
      --- SQL 1999 CODE ---
      
      select employee_id AS 사원번호
      , first_name || ' ' || last_name AS 사원명
      , nvl( salary + ( salary * commission_pct ), salary)*12 AS 연봉
      , taxpercent as 세율
      , nvl( salary + ( salary * commission_pct ), salary)*12 * taxpercent AS 소득세액
      from employees e JOIN tbl_taxindex t ---- SQL 1992 CODE 방식
      ON nvl(salary + (salary * commission_pct), salary)*12 between T.lowerincome AND T.highincome --JOIN 조건절
      order by 1;
      
      
      
      
      
    ----------------- **** SELF JOIN(자기조인) **** -----------------      
    /*
        자기자신의 테이블(뷰)을 자기자신의 테이블(뷰)과 JOIN 을 시키는 것이다.
        이때 반드시 테이블(뷰)에 대한 alias(별칭)을 달리 주어서 실행해야 한다.
    */
    
    --- 아래처럼 나오도록 하세요...
    -------------------------------------------------------------------------------------------------------
    사원번호              사원명             이메일     급여      직속상관번호             직속상관명
  employee_id   first_name || last_name    email     salary   employee_id      first_name || last_name
    -------------------------------------------------------------------------------------------------------
     100             Steven King           SKING     24000     null                 null 
     102             Lex De Haan           LDEHAAN   17000     100                  Steven King
     103             Alexander   Hunold       AHUNOLD   9000      102                  Lex De Haan
     104             Bruce Ernst           BERNST    6000      103                  Alexander Hunold
       
    -- SQL 1992 CODE 방식
    select E1.employee_id AS 사원번호
    ,E1.first_name || ' ' ||E1.last_name AS 사원명
    ,E1.email AS 이메일
    ,E1.salary AS 기본급여
    ,E2.employee_id AS 직속상관번호
    ,E2.first_name || ' ' || E2.last_name AS 직속상관명
    from employees E1, employees E2
    where E1.manager_id = E2.employee_id(+) -- E1 매니저 번호와 같은 E2의 사원번호의 정보를 합쳐라
    order by 1;
    -- (+) 을 써서 직속상관이 NULL이라 나오지 않던 사장님의 정보를 모두 출력해준다.
    
    
    
    
    
    -- SQL 1999 CODE 방식
    select E1.employee_id AS 사원번호
    ,E1.first_name || ' ' ||E1.last_name AS 사원명
    ,E1.email AS 이메일
    ,E1.salary AS 기본급여
    ,E2.employee_id AS 직속상관번호
    ,E2.first_name || ' ' || E2.last_name AS 직속상관명
    from employees E1 LEFT JOIN employees E2
    on E1.manager_id = E2.employee_id -- E1 매니저 번호와 같은 E2의 사원번호의 정보를 합쳐라
    order by 1;
    
    
    set hidden param parseThreshold = 150000;
    
   select *
   from tbl_authorbook;    
   
   --- 07월 23일    
   --- SELF 조인을 사용하여 tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명은 다른 도서)로 지어진 도서정보를 나타내세요.. ----
       
       
   /*
   
    -----------------------------------
    도서명         작가명         로얄티
    -----------------------------------
    로빈슨크루소    한석규          800
    로빈슨크루소    이순신          500
    그리스로마신화   유관순         1200
    그리스로마신화   이혜리         1300
    그리스로마신화   서강준         1700
   
   */
    
    
   select A1.* -- A1의 모든것만 보겠다.
   from tbl_authorbook A1,tbl_authorbook A2 -- SQL 1992 CODE 방식
   where A1.bookname = A2.bookname AND A1.authorname != A2.authorname;
   -- 공저는 책 제목은 똑같으나, 저자명이 다른 것을 의미한다.
   -- where 조건절까지 추가하면 공저인 책들만 나온다.
   
   -- 경우의 수 때문에 똑같은 것이 중복되어져 나온다.
   
   -----------------------------------------------------------------------------
   
   --- select 되어진 행의 결과물에서 중복된 행이 1번만 나오도록 하려면 select distinct 를 사용하면 된다.
   
   select distinct A1.* -- A1의 모든것만 보겠다.
   from tbl_authorbook A1,tbl_authorbook A2 -- SQL 1992 CODE 방식
   where A1.bookname = A2.bookname AND A1.authorname != A2.authorname -- 조인조건절
   order by A1.bookname;
   
   select distinct A1.* -- A1의 모든것만 보겠다.
   from tbl_authorbook A1 JOIN tbl_authorbook A2 -- SQL 1999 CODE 방식
   ON A1.bookname = A2.bookname AND A1.authorname != A2.authorname -- 조인조건절
   order by A1.bookname;
    
   
   /* !!!! select 문에서 distinct 와 order by 절을 함께 사용할때는 조심해야 한다.!!!!!
     select 문에 distinct 가 있는 경우 order by 절에는 select 문에서 사용된 컬럼만 들어올 수 있다.
     또는 select 문에 distinct 가 있는 경우 order by 절을 사용하지 않아야 한다.
   */
    
    select bookname, authorname
    from tbl_authorbook
    where authorname = '이순신'
    order by loyalty asc;
    -- select 에는 loyalty가 없지만 정렬은 테이블에 있는 loyalty 순으로 해서 '로빈슨크루소'가 먼저 나온다.
    
    select distinct authorname
    from tbl_authorbook
    where authorname = '이순신';

    -- 아래는 ORA-01791: not a SELECTed expression 발생함.
    select distinct authorname
    from tbl_authorbook
    where authorname = '이순신'
    order by loyalty asc;
    -- distinct 는 select문의 행 전체가 똑같을 때만 중복된 것을 없애준다.
    -- distinct 를 썼는데 order by를 했다면 order by의 기준은 반드시 select에 나오는 컬럼이여야 한다.
    
    select distinct authorname
    from tbl_authorbook
    where authorname = '이순신'
    order by authorname asc;   -- 오류가 없음, select 문에 사용된 컬럼을 써서 문제 X 
    
    select distinct authorname
    from tbl_authorbook
    where authorname = '이순신'; -- 오류가 없음

    
    ------- ====== ***** Multi Table JOIN ( 다중 테이블 조인 ) ***** ===== -------
    
    ----> 3개 이상의 테이블(뷰)을 가지고 조인 시켜주는 것이다.
    
    /*
        
        -----------------------------------------------------------------------------------------------------------------------------
        대륙명                 국가명                     주소                     부서번호       부서명     사원번호       사원명     기본급여
        -----------------------------------------------------------------------------------------------------------------------------
        America   United States Of America      Seattle 2004 Charade Rd         90        Execuvite   100      Steven King    24000    
        
        대륙명 ==> regions.region_name             regions.region_id
        국가명 ==> countries.country_name          country.region_id        countries.country_id
        부서주소 ==> locations.city || ' ' || locations.street_address      locations.country_id      locations.location_id
        부서명 ==> departments.departments_name    departments.locations_id    departments.department_id
        사원번호, 사원명, 기본급여 ==> employees.employee_id, employees.first_name || ' ' || employees.last_name, employees.salary, department_id
        
        
        대륙 -> 국가(region_id로 연결) -> 부서주소(country_id로 연결) -> 부서명(location_id로 연결) -> 사원명(department_id로 연결)
        
    */
    
    -- regions, countries, locations,departments, employees 테이블을 서로 JOIN 시킨다. 
    
    select *
    from tab;
    
    select *
    from regions;
    
    select *
    from countries;
    
    select *
    from locations;
    
    select *
    from departments;
    
    select *
    from employees;
    
    
    select *
    from REGIONS r 
    join COUNTRIES c 
    on r.REGION_ID = c.REGION_ID  -- REGIONS 와 COUNTRIES 를 연결
    join LOCATIONS l 
    on c.COUNTRY_ID = l.COUNTRY_ID -- 거기에 또 LOCATION 도 연결됨
    join DEPARTMENTS d
    on l.LOCATION_ID = d.LOCATION_ID -- 거기에 또 DEPARTMENTS 도 연결됨
    join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    order by 1;
    
    
    select *
    from REGIONS r 
    join COUNTRIES c 
    on r.REGION_ID = c.REGION_ID -- REGIONS 와 COUNTRIES 를 연결
    join LOCATIONS l 
    on c.COUNTRY_ID = l.COUNTRY_ID -- 거기에 또 LOCATION 도 연결됨
    join DEPARTMENTS d
    on l.LOCATION_ID = d.LOCATION_ID -- 거기에 또 DEPARTMENTS 도 연결됨
    right join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID -- 거기에 또 EMPLOYEES 도 연결됨
    order by 1;
    -- '킴벨리그랜트'도 출력된다. 
    
    
    select R.region_name AS 대륙명
    , C.country_name AS 국가명
    , L.city || ' ' || L.street_address AS 부서주소
    , D.department_id AS 부서번호
    , D.department_name AS 부서명
    , E.employee_id AS 사원번호
    , E.first_name || ' ' || E.last_name AS 사원명
    , E.salary AS 기본급여
    FROM REGIONS R 
    JOIN COUNTRIES C 
    ON R.REGION_ID = C.REGION_ID -- REGIONS 와 COUNTRIES 를 연결
    JOIN LOCATIONS L 
    ON C.COUNTRY_ID = L.COUNTRY_ID -- 거기에 또 LOCATION 도 연결됨
    JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID -- 거기에 또 DEPARTMENTS 도 연결됨
    RIGHT JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID -- 거기에 또 EMPLOYEES 도 연결됨
    ORDER BY R.region_id;
    
    
    
    select region_name AS 대륙명
    , country_name AS 국가명
    , city || ' ' || street_address AS 부서주소
    , D.department_id AS 부서번호
    , department_name AS 부서명
    , employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , salary AS 기본급여
    FROM REGIONS R 
    JOIN COUNTRIES C 
    ON R.REGION_ID = C.REGION_ID   -- REGIONS 와 COUNTRIES 를 연결
    JOIN LOCATIONS L 
    ON C.COUNTRY_ID = L.COUNTRY_ID -- 거기에 또 LOCATION 도 연결됨
    JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID -- 거기에 또 DEPARTMENTS 도 연결됨
    RIGHT JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID -- 거기에 또 EMPLOYEES 도 연결됨
    ORDER BY R.region_id;
    -- 중복이 안되는 컬럼들은 테이블 alias 를 생략해도 괜찮다.
    -- department_id, region_id 는 중복되기 때문에 alias 생략불가
    
    
    ---- [ 대분류 검색 ]
    ---- **** Americas 대륙에 근무하는 사원들만
    --        국가명, 부서주소, 부서번호, 부서명, 사원번호, 사원명, 기본급여를 출력하세요...
    -- 대륙이 대분류, 국가가 중분류, 주소가 소분류, 상세가 사원정보
    -- 대분류를 먼저 걸러야 한다.
    
    
    with V as (
    select R.region_id, region_name, 
           C.country_id, country_name,
           L.location_id, street_address, postal_code, city, state_province,
           D.department_id, department_name, D.manager_id, 
           E.employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
           -- D.manager_id 는 부서장, E.manager_id 는 직속상관
    from REGIONS r 
    join COUNTRIES c 
    on r.REGION_ID = c.REGION_ID 
    join LOCATIONS l 
    on c.COUNTRY_ID = l.COUNTRY_ID 
    join DEPARTMENTS d
    on l.LOCATION_ID = d.LOCATION_ID 
    RIGHT join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    )
    -- with 절로 조건용 테이블을 하나 만들고, 이제 밖에서 select 문을 만들어서 where 조건을 준다.
    
    select *
    from V;
    
    
    
    with V as (
    select R.region_id, region_name, 
           C.country_id, country_name,
           L.location_id, street_address, postal_code, city, state_province,
           D.department_id, department_name, D.manager_id, 
           E.employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
           -- D.manager_id 는 부서장, E.manager_id 는 직속상관
    from REGIONS r 
    join COUNTRIES c 
    on r.REGION_ID = c.REGION_ID 
    join LOCATIONS l 
    on c.COUNTRY_ID = l.COUNTRY_ID 
    join DEPARTMENTS d
    on l.LOCATION_ID = d.LOCATION_ID 
    RIGHT join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    )
    -- with 절로 조건용 테이블을 하나 만들고, 이제 밖에서 select 문을 만들어서 where 조건을 준다.
    -- ★★ 안에 on절에 조건을 주면, '킴벨리그랜트' 를 나오게하려고 EMPLOYEES 테이블을 RIGHT OUTER로 했기 때문에, 조건이 아닌 사원들도 나온다.
    -- 이렇게 테이블로 간주하고 밖에서 조건을 줘서 출력을 하게 하면 정확하게 나온다.
    -- 안에 ON절에 조건을 주고하면 복잡하고, 얘를 통짜로 테이블 취급하고, 밖에서 호출해서 대분류 / 중분류 / 소분류 검색하는게 편하다.
    -- 쫙 있는 테이블을 일단 만들고 그거를 호출해서 거르는게 편하다.
    
    select country_name AS 국가명
          , city || ' ' || street_address AS 부서주소
          , department_id AS 부서번호
          , department_name AS 부서명
          , employee_id AS 사원번호
          , first_name || ' ' || last_name AS 사원명
          , salary AS 기본급여
    from V
    where region_id = 2;
    
    
    
    
    ---- [ 중분류 검색 ]
    ---- **** Seattle 에 근무하는 사원들만
    --        국가명, 부서주소, 부서번호, 부서명, 사원번호, 사원명, 기본급여를 출력하세요...
    -- 대륙이 대분류, 국가가 중분류, 주소가 소분류, 상세가 사원정보
    -- 대분류를 먼저 걸러야 한다.    
    
    with V as (
    select R.region_id, region_name, 
           C.country_id, country_name,
           L.location_id, street_address, postal_code, city, state_province,
           D.department_id, department_name, D.manager_id, 
           E.employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
           -- D.manager_id 는 부서장, E.manager_id 는 직속상관
    from REGIONS r 
    join COUNTRIES c 
    on r.REGION_ID = c.REGION_ID 
    join LOCATIONS l 
    on c.COUNTRY_ID = l.COUNTRY_ID 
    join DEPARTMENTS d
    on l.LOCATION_ID = d.LOCATION_ID 
    RIGHT join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    )
        select country_name AS 국가명
          , city || ' ' || street_address AS 부서주소
          , department_id AS 부서번호
          , department_name AS 부서명
          , employee_id AS 사원번호
          , first_name || ' ' || last_name AS 사원명
          , salary AS 기본급여
    from V
    where city = 'Seattle'; -- 중분류 검색
    
    
    
    
    
    ---- [ 소분류 검색 ]
    ---- **** Finance 에 근무하는 사원들만
    --        국가명, 부서주소, 부서번호, 부서명, 사원번호, 사원명, 기본급여를 출력하세요...
    -- 대륙이 대분류, 국가가 중분류, 주소가 소분류, 상세가 사원정보
    -- 대분류를 먼저 걸러야 한다.    
    
    with V as (
    select R.region_id, region_name, 
           C.country_id, country_name,
           L.location_id, street_address, postal_code, city, state_province,
           D.department_id, department_name, D.manager_id, 
           E.employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
           -- D.manager_id 는 부서장, E.manager_id 는 직속상관
    from REGIONS r 
    join COUNTRIES c 
    on r.REGION_ID = c.REGION_ID 
    join LOCATIONS l 
    on c.COUNTRY_ID = l.COUNTRY_ID 
    join DEPARTMENTS d
    on l.LOCATION_ID = d.LOCATION_ID 
    RIGHT join EMPLOYEES e
    on d.DEPARTMENT_ID = e.DEPARTMENT_ID
    )
        select country_name AS 국가명
          , city || ' ' || street_address AS 부서주소
          , department_id AS 부서번호
          , department_name AS 부서명
          , employee_id AS 사원번호
          , first_name || ' ' || last_name AS 사원명
          , salary AS 기본급여
    from V
    where department_name = 'Finance';  -- 소분류 검색
    
    
    
    
    
    
    
    --- [퀴즈] 아래와 같이 나오도록 하세요..
    /*
        ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        부서번호                 부서명                            부서장성명                                      사원번호   사원명   입사일  
        ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        D.department_id   D.departments_name        E.first_name || ' ' ||  E.last_name
        E.department_id
                          D.manager_id     ====>    E.employee_id
                          ( 부서장의 사원번호 ) 
    */
    
    -- D 테이블 + E1 테이블(부서장 정보) + E2 테이블 (사원 정보)
    
   select D.department_id AS 부서번호
                    , D.department_name AS 부서명
                    , D.manager_id AS "부서장의 사원번호"
                    , E.first_name || ' ' || E.last_name AS 부서장성명
   from departments D JOIN employees E
   on D.manager_id = E.employee_id;

  -- 부서장의 정보 + 사원의 정보를 합친다.
  -- 결합조건은 부서장의 부서번호 와 사원의 부서번호가 같은 것을 합친다.
  -- 사원의 부서번호에 맞는 부서장의 정보를 합치는 것이다.
    
  select D.department_id AS 부서번호
                    , D.department_name AS 부서명
                    , D.manager_id AS "부서장의 사원번호"
                    , E1.first_name || ' ' || E1.last_name AS 부서장성명
                    , E2.employee_id AS 사원번호
                    , E2.first_name || ' ' || E2.last_name AS 사원명
                    , E2.hire_date AS 입사일
   from departments D JOIN employees E1
   on D.manager_id = E1.employee_id
   RIGHT JOIN employees E2
   ON D.department_id = E2.department_id
   order by 1;
   
   select *
   from employees
   where employee_id = 203;
   


   
  
   
   
   ---- [ 과제 ] ----
   -- 아래와 같이 나오도록 하세요...
   /*
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------
   부서번호     부서명     부서주소     부서장성명     사원번호     사원명      성별     나이     연봉     연봉소득세액     부서내연봉평균차액   부서내연봉등수      전체연봉등수
   ---------------------------------------------------------------------------------------------------------------------------------------------------------------
   departments + location + employees + tbl_taxindex + 그룹함수(avg) 는 cross join으로
   */
   
   -- email : tjdudgkr0959@naver.com
   -- 메일제목 : SQL과제_2_자기이름
   -- 첨부파일 : SQL과제_2_자기이름.txt
   -- 기한 : 2021.07.26 월요일까지 제출
   
   select D.department_id AS 부서번호
                    , D.department_name AS 부서명
                    , L.street_address || ' ' || city AS 부서주소
                    , E1.first_name || ' ' || E1.last_name AS 부서장성명
                    , E2.employee_id AS 사원번호
                    , E2.first_name || ' ' || E2.last_name AS 사원명
                    , case when substr(E2.jubun, 7, 1) in ('1','3') then '남' else '여' end AS 성별
                    , extract(year from sysdate) - ((substr(E2.jubun, 1, 2) + case when substr(E2.jubun, 7, 1) in ('1','2') then 1900 else 2000 end)) + 1 AS 나이
                    , NVL(E2.salary + (E2.salary * E2.commission_pct), E2.salary) * 12 AS 연봉
                    , NVL(E2.salary + (E2.salary * E2.commission_pct), E2.salary) * 12 * T.taxpercent AS 연봉소득세액
                    , (NVL(E2.salary + (E2.salary * E2.commission_pct), E2.salary) * 12) - A.department_avg AS 부서내연봉평균차액
                    , rank() over(partition by D.department_id order by NVL(E2.salary + (E2.salary * E2.commission_pct), E2.salary) * 12 desc) AS 부서내연봉등수
                    , rank() over(order by NVL(E2.salary + (E2.salary * E2.commission_pct), E2.salary) * 12 desc) AS 전체연봉등수
   from departments D JOIN employees E1
   on D.manager_id = E1.employee_id
   JOIN locations L
   on D.location_id = L.location_id
   RIGHT JOIN employees E2
   ON D.department_id = E2.department_id
   JOIN tbl_taxindex T
   ON NVL(E2.salary + (E2.salary * E2.commission_pct), E2.salary) * 12 between T.lowerincome and T.highincome
   JOIN ( select nvl(department_id,-9999) AS department_id
          , trunc( avg( nvl(salary + (salary * commission_pct), salary)*12 ) ) AS department_avg
          from employees
          group by department_id ) A
   ON nvl(E2.department_id,-9999) = A.department_id
   order by 1;
   
   
   ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
   
   ------ *** SET Operator(SET 연산자 , 집합연산자) *** -------
   
   /*
    -- 종류 --
    1. UNION
    2. UNION ALL
    3. INTERSECT
    4. MINUS
    
    -- 면접시 JOIN 과 UNION 의 차이점에 대해서 말해보세요
    ==> JOIN은 테이블의 컬럼과 컬럼의 결합이다.
    ==> UNION은 테이블의 행과 행의 결합이다.
    
    ==>  UNION 은 테이블(뷰)과 테이블(뷰)을 합쳐서 보여주는 것으로써,
     이것은 행(ROW)과 행(ROW)을 합친 결과를 보여주는 것이다.

    A = { a, x, b, e, g }
          -     -
    B = { c, d, a, b, y, k, m}    
                -  -    
    A ∪ B = {a, b, c, d, e, g, k, m, x, y}  ==> UNION               
                                             {a, b, c, d, e, g, k, m, x, y}

                                             ==> UNION ALL 
                                             {a, x, b, e, g, c, d, a, b, y, k, m} 

    A ∩ B = {a,b}  ==> INTERSECT
                       {a,b}

    A - B = {x,e,g} ==> MINUS 
                        {x,e,g}

    B - A = {c,d,y,k,m} ==> MINUS 
                           {c,d,y,k,m}
   
   
   */
   
   select *
   from tbl_panmae;

    -- tbl_panmae 테이블에서 2달전에 해당하는 월(현재가 2021년 7월이므로 2021년 5월)에 판매되어진 정보만 추출해서 tbl_panmae_202105 라는 테이블로 생성하세요.
    
    create table tbl_panmae_202105
    as
    select *
    from tbl_panmae
    where to_char(panmaedate, 'yyyy-mm') = to_char(add_months(sysdate, -2), 'yyyy-mm');
    -- Table TBL_PANMAE_202105이(가) 생성되었습니다.
    
    select *
    from tbl_panmae_202105;
    
    
    
    
    
    
    -- tbl_panmae 테이블에서 1달전에 해당하는 월(현재가 2021년 7월이므로 2021년 5월)에 판매되어진 정보만 추출해서 tbl_panmae_202105 라는 테이블로 생성하세요.
    
    create table tbl_panmae_202106
    as
    select *
    from tbl_panmae
    where to_char(panmaedate, 'yyyy-mm') = to_char(add_months(sysdate, -1), 'yyyy-mm');
    -- Table TBL_PANMAE_202106이(가) 생성되었습니다.
    
    select *
    from tbl_panmae_202106;  

    select *
    from tbl_panmae;
    
    
    -- tbl_panmae 테이블에서 이번달에 해당하는 월(현재가 2021년 7월)에 판매되어진 정보만 남겨두고 나머지는 모두 삭제하세요.
    
    delete from tbl_panmae
    where to_char(panmaedate, 'yyyy-mm') != to_char(sysdate,'yyyy-mm');
    -- 9개 행 이(가) 삭제되었습니다.
    
    commit;
    
    select *
    from tbl_panmae;
    
    ---- *** 최근 3개월간 판매되어진 정보를 가지고 제품별 판매량의 합계를 추출하세요 *** ----
    
    select *
    from tbl_panmae_202105; -- 2달전
    

    select *
    from tbl_panmae_202106; -- 1달전
    
    
    select *
    from tbl_panmae;    -- 이번달
    
    
    
    select *
    from tbl_panmae_202105
    UNION 
    select *
    from tbl_panmae_202106
    UNION 
    select *
    from tbl_panmae;  
    
    
    select *
    from tbl_panmae -- 이번달
    UNION
    select *
    from tbl_panmae_202105 -- 2달전
    UNION 
    select *
    from tbl_panmae_202106; -- 1달전
    -- UNION을 하면 항상 첫번째 컬럼(panmaedate)을 기준으로  오름차순 정렬되어 나온다.
    -- 그래서 2021년 5월 데이터 부터 먼저 나온다.
    -- UNION은 중복된 값도 1번만 나온다.
    
    select *
    from tbl_panmae -- 이번달
    UNION ALL
    select *
    from tbl_panmae_202105 -- 2달전
    UNION ALL
    select *
    from tbl_panmae_202106; -- 1달전
    -- UNION ALL을 하면 정렬 없이 그냥 순서대로 행을 붙여서 보여줄 뿐이다.
    -- 그래서 맨처음이 tbl_panmae 테이블이고, 그 다음이 tbl_panmae_202105 테이블이고, 마지막이 tbl_panmae202106 테이블 이므로
    -- 7월, 5월, 6월 순서대로 보여질 뿐이다.

    select jepumname AS 제품명
         , sum(panmaesu) AS 판매합계
    from
    (
        select *
        from tbl_panmae
        UNION
        select *
        from tbl_panmae_202105
        UNION 
        select *
        from tbl_panmae_202106 
    ) V
    -- 이 전체를 하나의 테이블(V라는 테이블)로 간주한다.
    group by jepumname
    order by 2 desc;
    -- 최근 3개월간 판매되어진 제품별 판매량
    
    
    -- 월 별로 찢어진 데이터(행)들을 하나로 합쳐서, 통계한 것이다.
    
    
    
    -- 또는
    
    with V AS
    (   select *
        from tbl_panmae
        UNION
        select *
        from tbl_panmae_202105
        UNION 
        select *
        from tbl_panmae_202106 
    )
    
    select jepumname AS 제품명
        , sum(panmaesu) AS 판매합계
    from V
    group by jepumname
    order by 2 desc;
    
    
    
    
    
    
    
    ------ **** [퀴즈] 최근 3개월간 판매되어진 정보를 가지고
    ------ **** 아래와 같이 제품명, 판매년월, 판매량의합계, 백분율(%) 을 추출하세요  *** ----
    
    --------------------------------------------------------------
    제품명         판매년월       판매량의합계              백분율(%)
    --------------------------------------------------------------
    감자깡         2021-05             20                  8.2
    감자깡         2021-06             15                  6.2
    감자깡         2021-07             15                  6.2
    감자깡                             50                 20.6
    새우깡         2021-05             38                 15.6
    새우깡         2021-06              8                  3.3
    새우깡         2021-07             30                 12.3
    새우깡                             76                 31.3
    .....          ......             ..                 .....
    전체                              243                100.0 
    -------------------------------------------------------------
        
        
        -- 최근 3개월간 판매되어진 판매량의 총 합계
        select sum(panmaesu)
        from 
        (
        select panmaesu
        from tbl_panmae
        UNION
        select panmaesu
        from tbl_panmae_202105
        UNION 
        select panmaesu
        from tbl_panmae_202106     
        ) V; -- 이건 틀린것이다. 10개만 팔린 것들을 중복이라고 없애버린다!!!
             -- 98개만 나온다!!
        
        select sum(panmaesu)
        from
        (
        select panmaesu
        from tbl_panmae
        UNION ALL
        select panmaesu
        from tbl_panmae_202105
        UNION ALL
        select panmaesu
        from tbl_panmae_202106    
        ) V; -- 243 이게 올바른 것이다!!!
    
    
   
    ---- 내꺼 풀이 -----
    with V AS
    (   select *
        from tbl_panmae
        UNION
        select *
        from tbl_panmae_202105
        UNION 
        select *
        from tbl_panmae_202106 
    )
    
    
    select decode(grouping(jepumname),0,jepumname,'전체') AS 제품명
        , decode(grouping(to_char(panmaedate,'yyyy-mm')), 0,  to_char(panmaedate,'yyyy-mm'), ' ') AS 판매년월
        , sum(panmaesu) AS 판매합계
        , to_char( round( sum(panmaesu)  / (select sum(panmaesu) from V )*100, 1),'999.0')AS "백분율(%)"
    from V
    group by rollup(jepumname, to_char(panmaedate,'yyyy-mm'));
    --- 전체는 20개이다.
    --- 판매량이 10개인 것이 8개나 있어서 얘네는 UNION에 의해 삭제되선 안되는데 삭제된다
    --- UNION은 중복을 제거하기 때문에, 제거된 것을 다시 살려내야 한다.
    
    
    

    ---- 강사님 풀이 ----
    
    
   select -- NVL(jepumname, '전체') AS 제품명
        -- , NVL(to_char(panmaedate, 'yyyy-mm'), '') AS 판매년월
        -- 또는 // 위의 방식은 데이터에 NULL이 없다는 전제 하에 쓴 것이다. 
        -- 데이터에 NULL이 있다면 위의 방식은 쓰면 안 된다!!!!!
        
          decode( grouping(jepumname), 0, jepumname, '전체') AS 제품명
        , decode( grouping( to_char(panmaedate,'yyyy-mm')), 0,  to_char(panmaedate,'yyyy-mm'), ' ') AS 판매년월
        -- grouping은 0 아니면 1이 나온다. 0이면 그룹화가 됐다는 것이고 // 1이면 그룹을 안 지었다는 것이다.
        , sum(panmaesu) AS 판매량의합계
        , to_char( round( sum(panmaesu) / ( select sum(panmaesu)
                                            from
                                            (
                                                select panmaesu
                                                from tbl_panmae
                                                UNION ALL
                                                select panmaesu
                                                from tbl_panmae_202105
                                                UNION ALL
                                                select panmaesu
                                                from tbl_panmae_202106    
                                            ) V1 ) * 100, 1), '999.0') AS "백분율(%)" -- 전체 판매량
   from
    (
        select *
        from tbl_panmae
        UNION
        select *
        from tbl_panmae_202105
        UNION 
        select *
        from tbl_panmae_202106 
    ) V -- 3개월간 판매되어진 데이터는 이곳에 다 있다.
   group by grouping sets( (jepumname, to_char(panmaedate, 'yyyy-mm') ), (jepumname), () );
    --또는 group by rollup ( (jepumname, to_char(panmaedate, 'yyyy-mm') )
    
    -- 제품명별, 월별 그룹짓고 ==> 제품별 판매월별 
    -- 제품명별 소계 출력하고 ==> 제품별 3개월간 판매량
    -- 다 끝나면 총계 출력하고 ==> 모든 제품의 3개월간 판매량
    -- ==== !!! 한 제품이였으면 날짜만 그룹화했으면 됐는데, 각각의 제품별 날짜별이 나와야 하니깐 제품명도 그룹화에 포함됨!!
    
    
    
    
    
    -- 강사님 풀이 2 with 절 사용하기 --
    
    with T AS
    (   select *
        from tbl_panmae
        UNION
        select *
        from tbl_panmae_202105
        UNION 
        select *
        from tbl_panmae_202106 
    )
    
    , V as
    (   select panmaesu
        from tbl_panmae
        UNION ALL
        select panmaesu
        from tbl_panmae_202105
        UNION ALL
        select panmaesu
        from tbl_panmae_202106    
    )
    
   select decode( grouping(jepumname), 0, jepumname, '전체') AS 제품명
         , decode( grouping( to_char(panmaedate,'yyyy-mm')), 0,  to_char(panmaedate,'yyyy-mm'), ' ') AS 판매년월
         , sum(panmaesu) AS 판매량의합계
         , to_char( round( sum(panmaesu)  / (select sum(panmaesu) from V )*100, 1),'999.0')AS "백분율(%)"
   from T
   group by grouping sets( (jepumname, to_char(panmaedate, 'yyyy-mm') ), (jepumname), () );
   
   
   
   
   ------------------------- **** INTERSECT(교집합) **** -------------------------
   insert into tbl_panmae_202105(panmaedate, jepumname, panmaesu) 
   values( to_date('2021-04-05','yyyy-mm-dd'), '쵸코파이', 10); 

   insert into tbl_panmae(panmaedate, jepumname, panmaesu) 
   values( to_date('2021-04-05','yyyy-mm-dd'), '쵸코파이', 10);  
   
   insert into tbl_panmae_202106(panmaedate, jepumname, panmaesu) 
   values( to_date('2021-04-05','yyyy-mm-dd'), '쵸코파이', 10); 
   
   commit;
   
   
   select *
    from tbl_panmae
    INTERSECT
    select *
    from tbl_panmae_202105
    INTERSECT 
    select *
    from tbl_panmae_202106;
    -- 3개의 테이블에서 똑같이 있는 것만 나온다. 교집합
    -- 21/04/05	쵸코파이	10
   
   
   
   ------------------------- **** MINUS(차집합) **** -------------------------   
   select *
   from tab;
   
   select  *
   from TBL_EMPLOYEES_BACKUP;	
   
   select *
   from employees
   where employee_id in (173, 185, 195);
   
   
   select *
   from TBL_EMPLOYEES_BACKUP
   where employee_id in (173, 185, 195);  
   
   
   
   delete from employees
   where employee_id in (173, 185, 195);
   -- 3개 행 이(가) 삭제되었습니다.
   -- 이거를 지우면 안되는데, 실수로 지워버린 상황
   
   commit;
   -- 커밋까지 해버림;;
   
   -- 개발자가 실수로 employees 테이블에 있던 사원들을 삭제(delete)했다. 그런데 누구를 삭제했는지 모른다.
   -- 백업받은 tbl_employees_backup 테이블을 이용하여 삭제된 사원들을 다시 복구하도록 하겠다.
   
   SELECT * 
   FROM TBL_EMPLOYEES_BACKUP -- 얘는 A
   MINUS
   SELECT *
   FROM EMPLOYEES; -- 얘는 B
   --- TBL_EMPLOYEES_BACKUP 테이블에만 존재하고,
   --- EMPLOYEES 테이블에는 존재하지 않는 행을 찾아주는 것이다.

   
   -- A MINUS B 를 하면 A에만 존재하고 B에는 없는 것을 보여준다.
   -- B MINUS A 를 하면 B에만 존재하고 A에는 없는 것을 보여준다.
   
   
   
   select *
   from employees
   where employee_id in (173, 185, 195);   
   -- 없음
   
   
   select *
   from TBL_EMPLOYEES_BACKUP
   where employee_id in (173, 185, 195); 
   -- 있다
   
   
   INSERT INTO EMPLOYEES 
   SELECT * 
   FROM TBL_EMPLOYEES_BACKUP 
   MINUS
   SELECT *
   FROM EMPLOYEES;
   -- ==> SELECT 되어진 결과물을 EMPLOYEES 테이블에 넣어라
   -- 3개 행 이(가) 삽입되었습니다.
   
   COMMIT;
   -- 커밋 완료.
   
   select *
   from employees
   where employee_id in (173, 185, 195);
   -- 복구 완료.
   
   set hidden param parseThreshold = 150000;
   
   
   ----------------- =========== **** Pseudo(의사, 유사, 모조) Column **** =========== -----------------
   ----------------- Pseudo(의사) Column 은 rowid 와 rownum 이 있다.
   -- 07월 26일
   
   /*
    1. rowid
    rowid 는 오라클이 내부적으로 사용하기 위해 만든 ID 값으로써 행에 대한 ID값 인데
    오라클 전체내에서 고유한 값을 가진다.
   */
   create table tbl_heowon
   (userid     varchar2(20),
   name       varchar2(20),
   address    varchar2(100)
   );
    
   insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
   insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
   insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
    
   insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
   insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
   insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
        
   insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
   insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
   insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
        
   commit;
   
   select *
   from tbl_heowon;
   
   select rowid, userid, name, address
   from tbl_heowon;
   
   select rowid, userid, name, address
   from tbl_heowon
   where rowid in ('AAAFBJAAEAAAAG+AAA', 'AAAFBJAAEAAAAG+AAB', 'AAAFBJAAEAAAAG+AAC');
   
   delete from tbl_heowon
   where rowid > 'AAAFBJAAEAAAAG+AAC';
   -- 첫번째 강감찬보다 높은 rowid 들은 (중복값들은) 지워라
   
   select rowid, userid, name, address
   from tbl_heowon;
   
   commit;
   
   select *
   from tbl_heowon;  
   
   /*
    2. rownum (!!!! 게시판 등 웹에서 아주 많이 사용됩니다. !!!!)
   */
   
   select boardno AS 글번호
        , subject AS 글제목
        , userid  AS 글쓴이
        , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS 작성일자
   from tbl_board;
   
   ----------------------------------------------------------------------------------
   번호     글번호             글제목                           글쓴이           작성일자
   ---------------------------------------------------------------------------------- 
    1        5         오늘도 좋은 하루 되세요                   kimys      2021-07-19 20:35:59   
    2        4         기쁘고 감사함이 넘치는 좋은 하루되세요       leess      2021-07-19 20:35:59
    3        3         건강하세요                              youks      2021-07-19 20:35:59
    4        2         반갑습니다                              eomjh      2021-07-19 20:35:59
    5        1         안녕하세요                              leess      2021-07-19 20:35:59
   ---------------------------------------------------------------------------------- 
                                1   2   3 ==> 페이지바
                        
    
   select rownum   -- rownum(행번호)은 기본적으로 insert 되어진 순서대로 나온다.
        , boardno AS 글번호
        , subject AS 글제목
        , userid  AS 글쓴이
        , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS 작성일자
   from tbl_board;    
   
   -- inline view 를 사용해서
   select rownum, boardno, subject, userid, registerday
   from
   (
       select boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board
       order by boardno desc
   ) V;
   
   
   -- 또는 with 절을 사용해서
   with V as 
   (
       select boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board
       order by boardno desc   
   )
   select rownum, boardno, subject, userid, registerday 
   from V;
   
   
   -- 또는 rownum 을 사용하지 않고 row_number() 함수를 사용해서 나타낼 수 있다.
   
   select row_number() over(order by boardno desc)
        , boardno 
        , subject 
        , userid  
        , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
   from tbl_board;       
   
   /*
    한 페이지당 2개씩 보여주고자 한다.
    1 페이지 ==> rownum : 1 ~ 2     boardno : 5 ~ 4
    2 페이지 ==> rownum : 3 ~ 4     boardno : 3 ~ 2        
    3 페이지 ==> rownum : 5 ~ 6     boardno : 1            
   */
   
   -- 1 페이지 ==> rownum : 1 ~ 2  /  boardno : 5 ~ 4
   select rownum, boardno, subject, userid, registerday
   from
   (
       select boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board
       order by boardno desc
   ) V
   where rownum between 1 and 2;
   
   
   -- 2 페이지 ==> rownum : 3 ~ 4  /  boardno : 3 ~ 2
   select rownum, boardno, subject, userid, registerday
   from
   (
       select boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board
       order by boardno desc
   ) V
   where rownum between 3 and 4;    -- rownum 은 where 절에 바로 쓸 수가 없다.!!!
                                    -- 그래서 rownum 을 가지는 컬럼의 별칭을 만든 후에 inline view 를 사용해야만 된다.
   
   
   -- [올바른 SQL문]
   -- 1 페이지 ==> rownum : 1 ~ 2  /  boardno : 5 ~ 4
   select boardno, subject, userid, registerday
   from
   (
       select rownum AS RNO, boardno, subject, userid, registerday
       from
       (
           select boardno 
                , subject 
                , userid  
                , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
           from tbl_board
           order by boardno desc
       ) V -- V에는 별칭을 준 rownum이 없기 때문에, 별칭을 준 select 문을 다시 inline view로 만든다.
   ) T -- T에는 RNO별칭을 준 rownum이 있다.
   where RNO between 1 and 2; -- 1페이지
   
   
   
   -- 2 페이지 ==> rownum : 3 ~ 4  /  boardno : 3 ~ 2
   select boardno, subject, userid, registerday
   from
   (
       select rownum AS RNO, boardno, subject, userid, registerday
       from
       (
           select boardno 
                , subject 
                , userid  
                , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
           from tbl_board
           order by boardno desc
       ) V
   ) T
   where RNO between 3 and 4;   -- 2페이지
   
   
   -- 3 페이지 ==> rownum : 5 ~ 6  /  boardno : 1
   select boardno, subject, userid, registerday
   from
   (
       select rownum AS RNO, boardno, subject, userid, registerday
       from
       (
           select boardno 
                , subject 
                , userid  
                , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
           from tbl_board
           order by boardno desc
       ) V
   ) T
   where RNO between 5 and 6;   -- 3페이지   
   
   
   
   --- 또는 rownum 을 사용하지 않고 row_number() 함수를 사용하여 페이징 처리를 해봅니다. ---
   
   select row_number() over(order by boardno desc)
        , boardno 
        , subject 
        , userid  
        , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
   from tbl_board
   where row_number() over(order by boardno desc) between 1 and 2;
   -- 오류!! ORA-30483: window  functions are not allowed here
   -- 마찬가지로 row_number() 는 where 절에 바로 쓸 수가 없다.
   -- 그러므로 이것 또한 inline view 를 사용해야 한다.
   
   
   -- 1페이지 ==> row_number() : 1 ~ 2 / boardno 5 ~ 4
   select boardno, subject, userid, registerday
   from
   (
       select row_number() over(order by boardno desc) AS RNO
            , boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board 
   ) V
   where RNO between 1 and 2; -- 1페이지
   
   
   -- 2페이지 ==> row_number() : 3 ~ 4 / boardno 3 ~ 2
   select boardno, subject, userid, registerday
   from
   (
       select row_number() over(order by boardno desc) AS RNO
            , boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board 
   ) V
   where RNO between 3 and 4;   -- 2페이지
   

   -- 3페이지 ==> row_number() : 5 ~ 6 / boardno 1
   select boardno, subject, userid, registerday
   from
   (
       select row_number() over(order by boardno desc) AS RNO
            , boardno 
            , subject 
            , userid  
            , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
       from tbl_board 
   ) V
   where RNO between 5 and 6;     -- 3페이지
   
   
   -------- **** 데이터 조작어(DML == Data Manuplation Language) **** ---------
   --- DML 문은 기본적으로 수동 commit 이다.
   --- 즉, DML 문을 수행한 다음에는 바로 디스크(파일)에 적용되지 않고 commit 해야만 적용된다.
   --- 그래서 DML 문을 수행한 다음에 디스크(파일)에 적용치 않고자 한다라면 rollback 하면 된다.
   
   1. insert  --> 데이터 입력
   2. update  --> 데이터 수정
   3. delete  --> 데이터 삭제
   4. merge   --> 데이터 병합
   
   insert 는 문법이
   insert into 테이블명(컬럼명1,컬럼명2,...) values(값1,값2,...); 
   이다.
   
   ※ Unconditional insert all  -- ==>조건이 없는 insert 
    [문법]  insert all 
           into 테이블명1(컬럼명1, 컬럼명2, ....)
           values(값1, 값2, .....)
           into 테이블명2(컬럼명3, 컬럼명4, ....)
           values(값3, 값4, .....)
           SUB Query문;   
           

   create table tbl_emp1
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(6)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );
   -- Table TBL_EMP1이(가) 생성되었습니다.
   
   
   create table tbl_emp1_backup
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(6)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );
   -- Table TBL_EMP1_BACKUP이(가) 생성되었습니다.
   
   insert all 
   into tbl_emp1(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender||'자', manager_id, department_id, department_name)
   into tbl_emp1_backup(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender||'자', manager_id, department_id, department_name)
   select employee_id
        , first_name || ' ' || last_name AS ename 
        , nvl(salary + (salary * commission_pct), salary) AS month_sal
        , case when substr(jubun,7,1) in('1','3') then '남' else '여' end AS gender
        , E.manager_id
        , E.department_id
        , department_name
   from employees E LEFT JOIN departments D 
   on E.department_id = D.department_id
   order by E.department_id asc, employee_id asc;
   -- 214개 행 이(가) 삽입되었습니다. ( 107 + 107 )
   
   commit;
   -- 커밋 완료.
   
   select *
   from tbl_emp1;
   
   select *
   from tbl_emp1_backup;   
   
   ※ Conditional insert all -- ==> 조건이 있는 insert 
   조건(where절)에 일치하는 행들만 특정 테이블로 찾아가서 insert 하도록 하는 것이다.   
   
   create table tbl_emp_dept30
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );

   create table tbl_emp_dept50
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );

   create table tbl_emp_dept80
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );   
   
   
   
   insert all 
   when department_id = 30 then
   into tbl_emp_dept30(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values( employee_id, ename, month_sal, gender, manager_id, department_id, department_name )
   when department_id = 50 then
   into tbl_emp_dept50(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values( employee_id, ename, month_sal, gender, manager_id, department_id, department_name ) 
   when department_id = 80 then
   into tbl_emp_dept80(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values( employee_id, ename, month_sal, gender, manager_id, department_id, department_name )
   select employee_id
        , first_name || ' ' || last_name AS ename 
        , nvl(salary + (salary * commission_pct), salary) AS month_sal
        , case when substr(jubun,7,1) in('1','3') then '남' else '여' end AS gender
        , E.manager_id
        , E.department_id
        , department_name
   from employees E LEFT JOIN departments D 
   on E.department_id = D.department_id
   where E.department_id in(30, 50, 80)
   order by E.department_id asc, employee_id asc;
   -- 85개 행 이(가) 삽입되었습니다.
   
   commit;
   -- 커밋 완료..
   
   select *
   from tbl_emp_dept30;
   -- 6
   
   select *
   from tbl_emp_dept50;
   -- 45
   
   select *
   from tbl_emp_dept80;
   -- 34   
   
   
   ---------------- ===== ***** merge(병합) ***** ===== ---------------------
   -- 어떤 2개 이상의 테이블에 존재하는 데이터를 다른 테이블 한곳으로 모으는것(병합)이다.
   
   ----- **** 데이터베이스 링크(database link) 만들기 **** -----
   1. 탐색기에서 C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN 에 간다.
   
   2. tnsnames.ora 파일을 메모장으로 연다.
   
   3. TEACHER =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = 211.238.142.72)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = XE)
        )
      )
      을 추가한다.
      HOST = 211.238.142.72 이 연결하고자 하는 원격지 오라클서버의 IP 주소이다.
      그런데 전제조건은 원격지 오라클서버(211.238.142.72)의 방화벽에서 포트번호 1521 을 허용으로 만들어주어야 한다.
      
      그리고 TEACHER 를 'Net Service Name 네트서비스네임(넷서비스명)' 이라고 부른다.
      
      4.  명령프롬프트를 열어서 원격지 오라클서버(211.238.142.72)에 연결이 가능한지 테스트를 한다.
          C:\Users\User>tnsping TEACHER 5
            Used TNSNAMES adapter to resolve the alias
            Attempting to contact (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 211.238.142.72)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = XE)))
            OK (10 msec)
            OK (20 msec)
            OK (10 msec)
            OK (20 msec)
            OK (20 msec)
            
      5. 데이터베이스링크(database link) 만들기
      
      create database link teacherServer
      connect to hr identified by cclass -- 이때 hr 과 암호 cclass 는 연결하고자 하는 원격지 오라클서버(211.238.142.72)의 계정명과 암호이다.
      using 'TEACHER'; -- TEACHER 는 Net Service Name 네트서비스네임(넷서비스명) 이다.
      -- Database link TEACHERSERVER이(가) 생성되었습니다.
      
      select *
      from employees
      order by employee_id;
      
      update employees set first_name = '성현', last_name = '박'
      where employee_id = 100; -- Steven King
      -- 1 행 이(가) 업데이트되었습니다.
      
      commit;
      -- 커밋 완료.
      
      
      select *
      from employees    -- 로컬서버
      order by employee_id;
      
      select *
      from employees@teacherServer    -- 원격지 오라클서버(211.238.142.72)
      order by employee_id;   
      
      
      ---- *** 생성되어진 데이터베이스 링크를 조회해봅니다. *** ----
      select *
      from user_db_links;
      /*
      ------------------------------------------------------------
        DB_LINK         USERNAME PASSWORD      HOST      CREATED 
      ------------------------------------------------------------       
        TEACHERSERVER	HR		 NUMLL         TEACHER	21/07/26
      ------------------------------------------------------------  
                                               TEACHER 는 Net Service Name 네트서비스네임(넷서비스명) 이다.
      */
      
      ---- *** 데이터베이스 링크 삭제하기 *** ----
      drop database link TEACHERSERVER;
      -- Database link TEACHERSERVER이(가) 삭제되었습니다.
      
      create database link teacherServer
      connect to hr identified by cclass 
      using 'TEACHER';
      -- Database link TEACHERSERVER이(가) 생성되었습니다.
      
      
      -- [ 가상 시나리오 ]
      -- 각 지점별로 예약되어진 정보를 본점 원격지 서버의 테이블에 병합시켜보기
      
      create database link bonjumlink -- 본점연결용 데이터베이스 링크 생성하기
      connect to hr identified by cclass -- 그 원격지의 이 오라클서버에 연결한다.
      using 'TEACHER'; -- 이 네트서비스를 이용하여서 원격지에 연결한다.
      
      
      -- 각 지점마다 tbl_reservation_psh 이라는 테이블을 생성한다.
      create table tbl_reservation_psh
      (rsvno        varchar2(20)        --예약고유번호
      ,memberid     varchar2(20)        --회원ID
      ,ticketcnt    number              --티켓갯수
      ,constraint PK_tbl_reservation_psh primary key(rsvno)
      );
      -- Table TBL_RESERVATION_PSH이(가) 생성되었습니다.
      
      insert into tbl_reservation_psh(rsvno, memberid, ticketcnt)
      values('psh001', '박성현', 2);
      -- 1 행 이(가) 삽입되었습니다.
      
      commit;
      -- 커밋 완료.
      
      select *
      from tbl_reservation_merge@bonjumlink; -- 본점의 이 테이블을 보자 현재는 비어있다.
      
      select *
      from tbl_reservation_psh; -- 각 지점별의 테이블의 정보를 본점으로 보내준다.
      
      merge into tbl_reservation_merge@bonjumlink R
      using tbl_reservation_psh L
      on (L.rsvno = R.rsvno)
      when matched then -- 만약 일치하는 고유키값이 있다면 수정을 한다.
            update set R.memberid = L.memberid
                    ,  R.ticketcnt = L.ticketcnt
      when not matched then -- 만약 일치하는 고유키값이 없다면 추가를 한다.
            insert(rsvno, memberid, ticketcnt) values(L.rsvno, L.memberid, L.ticketcnt);    -- insert into 쓰면 오류가 난다.
      -- 1 행 이(가) 병합되었습니다.
      
      commit;
      -- 커밋 완료
      
      -- rollback;
      
      select *
      from tbl_reservation_merge@bonjumlink;
      -- 이제 본점에 분점의 정보가 들어갔나 확인해본다.
      
      select *
      from tbl_reservation_psh;  -- 예약정보를 변경할 일이 생겼다.
      
      update tbl_reservation_psh set memberid = 'Park S.H', ticketcnt = 5 
      where rsvno = 'psh001';
      -- 1 행 이(가) 업데이트되었습니다. 
      
      commit;
      -- 커밋 완료.
      
      select *
      from tbl_reservation_psh;
      -- 지점 테이블의 정보를 변경한 것이다.
      -- 변경한 정보를 본점 테이블로 보내줘야 한다.
      
      merge into tbl_reservation_merge@bonjumlink R
      using tbl_reservation_psh L
      on (L.rsvno = R.rsvno)
      when matched then  --==> 똑같은 예약번호가 있으면 업데이트를 해라!
            update set R.memberid = L.memberid
                    ,  R.ticketcnt = L.ticketcnt
      when not matched then 
            insert(rsvno, memberid, ticketcnt) values(L.rsvno, L.memberid, L.ticketcnt);    -- insert into 쓰면 오류가 난다.
      -- 이미 본점에 똑같은 키값이 있으니, 똑같은 것이 있으므로 when matched then 구절의 실행명령문이 실행된다.
      -- 그러므로 update 명령문 실행된다.
      
      -- 1 행 이(가) 병합되었습니다.

      
      commit; -- 원격지의 넣어준 정보를 커밋해준다.
      -- 커밋 완료.
      
      select *
      from tbl_reservation_merge@bonjumlink;
      -- 변경된 정보가 잘 들어갔나 원격지를 확인한다.
      
      insert into tbl_reservation_psh(rsvno, memberid, ticketcnt)
      values('psh002', '박성현2', 10);
      -- 1 행 이(가) 삽입되었습니다.
      
      commit;
      -- Local, 지점에 새로운 예약 추가
      -- 커밋 완료.
      
      select *
      from tbl_reservation_psh;
      -- psh002 는 현재 지점에만 존재하지, 본점에 없는 정보이다.
      -- 그러므로 본점에 보내줘야(병합해줘야)한다.
      
      merge into tbl_reservation_merge@bonjumlink R
      using tbl_reservation_psh L
      on (L.rsvno = R.rsvno)
      when matched then  --==> psh001 은 이미 있으니 업데이트 구절 적용
            update set R.memberid = L.memberid
                    ,  R.ticketcnt = L.ticketcnt
      when not matched then --==> psh002 는 본점에 없으니 새로 삽입한다.
            insert(rsvno, memberid, ticketcnt) values(L.rsvno, L.memberid, L.ticketcnt); 
      -- 2개 행 이(가) 병합되었습니다. ( 없는거 1 개행은 삽입, 있는거 1개행은 업데이트 )
            
      commit;
      -- 커밋 완료.
      
      select *
      from tbl_reservation_merge@bonjumlink;
      -- 원격지 확인
      
      
      
   -------- **** 데이터 질의어(DQL == Data Query Language) **** --------- 
   --> DQL 은 select 를 말한다.
   
   -------- **** 트랜잭션 제어어(TCL == Transaction Control Language) **** ---------
   -->  TCL 은 commit, rollback 을 말한다.
   
   
   -- *** Transaction(트랜잭션) 처리 *** --
   --> Transaction(트랜잭션)이라 함은 관련된 일련의 DML로 이루어진 한꾸러미(한세트)를 말한다.
   --> Transaction(트랜잭션)이라 함은 데이터베이스의 상태를 변환시키기 위하여 논리적 기능을 수행하는 하나의 작업단위를 말한다. 
   /*
      예>   네이버카페(다음카페)에서 활동
            글쓰기(insert)를 1번하면 내포인트 점수가 10점이 올라가고(update),
            댓글쓰기(insert)를 1번하면 내포인트 점수가 5점이 올라가도록 한다(update)
           
           위와같이 정의된 네이버카페(다음카페)에서 활동은 insert 와 update 가 한꾸러미(한세트)로 이루어져 있는 것이다.
           이와 같이 서로 다른 DML문이 1개의 작업을 이룰때 Transaction(트랜잭션) 처리라고 부른다.
           
           Transaction(트랜잭션) 처리에서 가장 중요한 것은 
           모든 DML문이 성공해야만 최종적으로 모두 commit 을 해주고,
           DML문중에 1개라도 실패하면 모두 rollback 을 해주어야 한다는 것이다. 
           
           예를 들면 네이버카페(다음카페)에서 글쓰기(insert)가 성공 했다라면
           그 이후에 내포인트 점수가 10점이 올라가는(update) 작업을 해주고, update 작업이 성공했다라면
           commit 을 해준다. 
           만약에 글쓰기(insert) 또는 10점이 올라가는(update) 작업이 실패했다라면
           rolllback 을 해준다.
           이러한 실습은 자바에서 하겠습니다.
   */
   
   
   ----- **** ==== ROLLBACK TO SAVEPOINT ==== **** -----
   ----- **** 특정 시점까지 rollback 을 할 수 있습니다. **** -----
   
   SELECT *
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 50;
   
   UPDATE EMPLOYEES SET FIRST_NAME = '몰라'
   WHERE DEPARTMENT_ID = 50;
   -- 45개 행 이(가) 업데이트되었습니다.
   
   SAVEPOINT POINT_1;
   -- Savepoint이(가) 생성되었습니다.
   
   DELETE FROM EMPLOYEES
   WHERE DEPARTMENT_ID IS NULL;
   -- 1 행 이(가) 삭제되었습니다.
   
   SELECT FIRST_NAME
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 50;   
   -- 전부다 '몰라' 로 나온다.
   
   SELECT *
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID IS NULL;
   -- 행이 없다.
   
   ROLLBACK TO SAVEPOINT POINT_1;
   -- 롤백 완료.
   -- SAVEPOINT POINT_1; 이 선언되어진 이후로 실행된 DML문을 ROLLBACK 시킨다.
   -- 그러므로 '킴벨리그랜트' 를 삭제한 DELECT문부터 ROLLBACK이다.
   
   /*
    그러므로
    DELETE FROM EMPLOYEES
    WHERE DEPARTMENT_ID IS NULL; 만 롤백시킨다.
   */
   
   
   SELECT *
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID IS NULL;
   -- 행이 나온다.
   
   SELECT FIRST_NAME
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 50;   
   -- 여전히 전부 '몰라'로 출력된다.
   
   rollback; --> commit; 한 이후로 수행되어진 모든 DML문을 롤백시킨다.
   -- 롤백 완료.
   
   
   SELECT FIRST_NAME
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 50;  
   -- first_name 컬럼의 값이 원상복구됨
   
   
   
   ------ **** 데이터 정의어(DDL = Data Defination Language) **** ------
   ==> DDL : create, drop, alter, truncate
   --> 여기서 중요한 것은 DDL 문을 실행을 하면 자동적으로 commit; 이 되어진다.
   --> 즉, auto commit 되어진다.
   
   select *
   from employees
   where employee_id = 100;
   --- salary ==> 24000
   --- email ==> SKING
   
   update employees set salary = 43245, email ='qwer1234'
   where employee_id = 100;
   -- 1 행 이(가) 업데이트되었습니다.
   -- commit 은 아직 안했다.
   
   create table tbl_imsi
   (no      number
   ,name    varchar2(20)
   );
   -- Table TBL_IMSI이(가) 생성되었습니다.
   
   -- 눈에는 안 보이지만, DDL 문을 실행했으므로 자동적으로 commit; 이 되어진다.
   
   
   select *
   from employees
   where employee_id = 100;
   
   rollback;

   select *
   from employees
   where employee_id = 100;   
   -- 원래 값으로 복구가 안된다.
   -- 왜냐하면 위에서 중간에 DDL문(create)을 실행했기 때문에 auto commit이 되버려서 얼떨결에 같이 commit;이 된 것이다.
   -- 그래서 rollback 안 됨.
   
   
   
   --- [퀴즈] ---
   -- 원격지 오라클서버(211.238.142.72)에 존재하는 employees 테이블의 데이터를 가지고
   -- 로컬 서버에 존재하는 employees 테이블의 사원번호 100 번에 해당하는 email 컬럼의 값과 salary 컬럼의 값을 변경하세요.
   
    update employees set email = (select email from employees@teacherserver where employee_id = 100)
                       , salary = (select salary from employees@teacherserver where employee_id = 100)
    where employee_id = 100;
    -- merge가 아니라 update를 써야한다.
    -- 새로 추가하는 것이 아니라 원래 있는 행을 수정하는 거니깐
    
    -- 원격지에 있는 값을 가져와서 로컬에 값을 바꿔라
    --1 행 이(가) 업데이트되었습니다.
    
    commit;
    -- 커밋 완료.
    
    
    
    
    
    ------ ====== **** TRUNCATE TABLE 테이블명; **** ====== ------
    --> TRUNCATE table 테이블명; 을 실행하면 테이블명 에 존재하던 모든 행(row)들을 삭제해주고,
   --  테이블명에 해당하는 테이블은 완전초기화 가 되어진다.
   --  중요한 사실은 TRUNCATE table 테이블명; 은 DDL 문이기에 auto commit; 되어지므로 rollback 이 불가하다.
   
   --  delete from 테이블명; 을 실행하면 이것도 테이블명 에 존재하던 모든 행(row)들을 삭제해준다.
   --  이것은 DML문 이므로 rollback 이 가능하다.
   
   create table tbl_emp_copy1
   as
   select * from employees;
   -- Table TBL_EMP_COPY1이(가) 생성되었습니다.
   
   select *
   from tbl_emp_copy1;
   
   delete from tbl_emp_copy1;
   -- where 절이 없어서 모든 행이 삭제된다.
   -- 107개 행 이(가) 삭제되었습니다.
   
   select count(*)
   from tbl_emp_copy1; -- 0
   
   rollback;
   
   select count(*)
   from tbl_emp_copy1; -- 107
   -- DML문이여서 rollback 이 가능하다.
   
   truncate table tbl_emp_copy1;
   -- Table TBL_EMP_COPY1이(가) 잘렸습니다.
   
   select count(*)
   from tbl_emp_copy1;  -- 0
   
   rollback;
   
   select count(*)
   from tbl_emp_copy1; -- 0 
   
   -- DDL문이여서 auto commit;이 되기 때문에, rollback;을 해도 다 날라가져 있다.
   -- TRUNCATE TABLE 테이블명; 은 어떤 테이블의 모든 행들을 싹 다 없애버리고,
   -- TABLE을 완전 초기 형태로 만들어 버린다.
   
   
   
   
   
   
   
   
   
   ------ **** 데이터 제어어(DCL = Data Control Language) **** ------ 
   ==> DCL : grant(권한 부여하기), revoke(권한 회수하기) 
   --> 여기서 중요한 것은 DCL 문을 실행을 하면 자동적으로 commit; 이 되어진다.
   --> 즉, auto commit 되어진다.
   

   -- **** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 시작 **** --
   
   show user;
   -- USER이(가) "SYS"입니다.
   
   -- orauser1 이라는 오라클 일반사용자 계정을 생성합니다. 암호는 cclass 라고 하겠습니다.
   create user orauser1 identified by cclass default tablespace users;
   -- User ORAUSER1이(가) 생성되었습니다.

   -- 생성되어진 오라클 일반사용자 계정인 orauser1 에게 오라클서버에 접속이 되어지고, 
   -- 접속이 되어진 후 테이블 등을 생성할 수 있도록 권한을 부여해주겠다.
   grant connect, resource, unlimited tablespace to orauser1;
   -- Grant을(를) 성공했습니다.
   
   -- **** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 끝 **** --
   
   
   --- **** HR에서 아래와 같은 작업을 한다. **** ---
   show user;
   -- USER이(가) "HR"입니다.
   
   select * 
   from HR.employees;
   -- 원래 FROM은 저렇게 소유주명.테이블명을 써야 한다.
   
   -- 현재 오라클 서버에 접속된 사용자가 HR 이므로 HR.EMPLOYEES 대신에 EMPLOYEES 을 쓰면 HR.EMPLOYEES로 알아서 인식한다.
   
   select * 
   from employees;
   
   -- ==== **** 권한 부여하기 **** ====
   
   -- orauser1 에게 HR이 자신의 소유인 HR.employees(=employees) 테이블에 대해 select 할 수 있도록 권한을 부여하겠습니다.
   grant select on employees to orauser1;
   -- Grant을(를) 성공했습니다.
   -- employees 테이블은 주인이 HR이기 때문에 HR이 select할 권한을 다른 접속자에게 줄 수 있다.
   
   
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 update 할 수 있도록 권한을 부여한다.
   grant update on employees to orauser1;
   -- Grant을(를) 성공했습니다.
      
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 delete 할 수 있도록 권한을 부여한다.
   grant delete on employees to orauser1;
   -- Grant을(를) 성공했습니다.
   
   
   
   -- ==== **** 권한 회수하기 **** ====
   
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 delete 할 수 없도록 권한을 부여한 것을 회수 하겠다.
   revoke delete on employees from orauser1;
   -- Revoke을(를) 성공했습니다.
   
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 update 할 수 없도록 권한을 부여한 것을 회수 하겠다.
   revoke update on employees from orauser1;
   -- Revoke을(를) 성공했습니다.
   
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select 할 수 없도록 권한을 부여한 것을 회수 하겠다.
   revoke select on employees from orauser1;
   -- Revoke을(를) 성공했습니다.

   
   
   --- 한꺼번에 grant 하기
   
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select, update, delete 할 수 있도록 권한을 부여한다.
   grant select, update, delete on employees to orauser1;
   -- Grant을(를) 성공했습니다.  
   
   
   --- 한꺼번에 revoke 하기
   
   -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select, update, delete 할 수 없도록 권한을 회수한다.
   revoke select, update, delete on employees from orauser1;
   -- Revoke을(를) 성공했습니다.  
   
   
   
   
   update employees set first_name = '몰라';
   -- 107개 행 이(가) 업데이트되었습니다.
   
   -- commit 이나 rollback 하지 않음.
   
   
   grant select, update, delete on employees to orauser1;
   -- Grant을(를) 성공했습니다.
   
   
   rollback; -- 위에서 DCL 문인 grant 를 했기 때문에 auto commit; 되어져서 rollback 해도 소용이 없다.
   -- 롤백 완료.
   
   
   
   select *
   from TBL_EMPLOYEES_BACKUP;
   
   update employees E set first_name = ( select first_name 
                               from TBL_EMPLOYEES_BACKUP 
                               where employee_id = E.employee_id );
                               
   select * 
   from employees;
   
   commit;
   
  /*
      DML(Data Manuplation Language) : 데이터 조작어 ==> insert, update, delete, merge
                                     : 수동 commit 이므로 rollback 이 가능하다.
                                     
      DDL(Data Definition Language) : 데이터 정의어 ==> create, drop, alter, truncate
                                    : 자동 commit( Auto commit) 이므로 rollback 이 불가하다.
                                    
      DCL(Data Control Language) : 데이터 제어어 ==> grant, revoke     
                                 : 자동 commit( Auto commit) 이므로 rollback 이 불가하다.
                                 
      TCL(Transaction Control Language) : 트랜잭션 제어어 ==> commit, rollback
      
      DQL(Data Query Language) : 데이터 질의어 ==> select 
   */
   
   
   
  -------- **** ==== 시퀀스(sequence) ==== **** --------
  -- 시퀀스(sequence)란? 쉽게 생각하면 은행에서 발급해주는 대기번호표 와 비슷한 것이다.
  -- 시퀀스(sequence)는 숫자로 이루어져 있으며 매번 정해진 증가치 만큼 숫자가 증가되어지는 것이다.   
   
/*
     create sequence seq_yeyakno     -- seq_yeyakno 은 시퀀스(sequence) 이름이다.
     start with 1    -- 첫번째 출발은 1 부터 한다.
     increment by 1  -- 증가치 값    2 3 4 5 ......
     maxvalue 5      -- 최대값이 5 이다.
  -- nomaxvalue      -- 최대값이 없는 무제한. 계속 증가시키겠다는 말이다.
     minvalue 2      -- 최소값이 2 이다. cycle 이 있을때만 minvalue 에 주어진 값이 사용된다. 
                     --                nocycle 일 경우에는 minvalue 에 주어진 값이 사용되지 않는다.
                     -- minvalue 숫자 에 해당하는 숫자 값은 start with 숫자 에 해당하는 숫자 값과 같든지 
                     -- 아니면 start with 숫자 에 해당하는 숫자보다 작아야 한다.
                     
  -- nominvalue      -- 최소값이 없다.   
     cycle           -- 반복을 한다.
  -- nocycle         -- 반복이 없는 직진.
     nocache;
*/   


    create sequence seq_yeyakno_1
    start with 1            -- 첫번째 출발은 1 부터 한다.
    increment by 1          -- 증가치는 1이다. 즉, 1씩 증가한다.
    maxvalue 5              -- 최대값이 5 이다.
    minvalue 2              -- 최소값이 2 이다.
    cycle                   -- 반복을 한다. 
    nocache;
    
    /*
        오류보고 - 
        ORA-04006: START WITH cannot be less than MINVALUE
        
        minvalue 숫자에 해당하는 숫자 값은 start with 숫자에 해당하는 숫자 값과 같든지
        또는 start with 숫자에 해당하는 숫자보다 작아야 한다.
    */
   
   
    create sequence seq_yeyakno_1
    start with 2            -- 첫번째 출발은 1 부터 한다.
    increment by 1          -- 증가치는 1이다. 즉, 1씩 증가한다.
    maxvalue 5              -- 최대값이 5 이다.
    minvalue 1              -- 최소값이 1 이다.
    cycle                   -- 반복을 한다. 
    nocache;   
    -- Sequence SEQ_YEYAKNO_1이(가) 생성되었습니다.
    
    ---- **** 생성되어진 시퀀스(sequence)를 조회해 봅니다. **** ----
    select *
    from user_sequences;
    
    select last_number -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다.
    from user_sequences
    where sequence_name = 'SEQ_YEYAKNO_1';
    
    
    
    create table tbl_board_test_1
    (boardno        number
    ,subject        varchar2(100)
    ,registerdate   date default sysdate -- 이 컬럼에 값을 안주면 기본값으로 sysdate가 들어간다.
    );
    -- Table TBL_BOARD_TEST_1이(가) 생성되었습니다.
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '첫번째 글입니다.');
    -- 내가 쓸 게시물 번호가 몇번인지 모르니깐 알아서 1씩 증가하는 시퀀스를 넣어준다.
    -- 넣을땐 시퀀스명.nextval로 쓴다.
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 start 값이 2이었다.
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '두번째 글입니다.');
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment by 값이 1 이었다.
    -- 시퀀스 값은 3
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '세번째 글입니다.');
    -- 시퀀스 값은 4
    -- seq_yeyakno_1 시퀀스의 increment by 값이 1 이었다.
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '네번째 글입니다.');
    -- 시퀀스 값은 5
    -- seq_yeyakno_1 시퀀스의 increment by 값이 1 이었다.
    -- 1 행 이(가) 삽입되었습니다.    
    -- seq_yeyakno_1 시퀀스의 maxvalue 값이 5 이었고, cycle 이었다. 즉, 반복을 한다.
   
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '다섯번째 글입니다.');
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스 minvalue 값이 1 이었고, cycle(반복) 이었으므로 
    -- maxvalue 값이 사용되어진 다음에 들어오는 시퀀스 값은 minvalue 값인 1이 들어온다.
   
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '여섯번째 글입니다.');
    -- 1 행 이(가) 삽입되었습니다.
    -- 시퀀스 값은 2
    
    commit;
    
    
    select *
    from tbl_board_test_1;
    
    
    /*
        seq_yeyakno 시퀀스값의 사용은 
        2(start) 3  4  5(maxvalue)  1(minvalue)  2  3  4  5(maxvalue)  1(minvalue)  2  3....
        와 같이 사용된다.
    */
    
    -- drop sequence seq_yeyakno_2; -- 시퀀스 삭제하기
    -- Sequence SEQ_YEYAKNO_2이(가) 삭제되었습니다.
    
    
    
    -- 일반적인 시퀀스
       
    create sequence seq_yeyakno_2
    start with 1            -- 첫번째 출발은 1 부터 한다.
    increment by 1          -- 증가치는 1이다. 즉, 1씩 증가한다.
    nomaxvalue              -- 최대값이 없는 무제한, 계속 증가시키겠다는 말이다.
    nominvalue              -- 마찬가지로 max가 없기 때문에 반복할 수 없으니, nominvalue를 준다.
    nocycle                 -- 반복을 안한다. 
    nocache;   
    -- Sequence SEQ_YEYAKNO_2이(가) 생성되었습니다.
    
    
    ---- **** 생성되어진 시퀀스(sequence)를 조회해 봅니다. **** ----
    select *
    from user_sequences;
    
    
    -- drop table tbl_board_test_2 purge;
    -- Table TBL_BOARD_TEST_2이(가) 삭제되었습니다.
    
    create table tbl_board_test_2
    (boardno        number
    ,subject        varchar2(100)
    ,registerdate   date default sysdate -- 이 컬럼에 값을 안주면 기본값으로 sysdate가 들어간다.
    );
    -- Table TBL_BOARD_TEST_2이(가) 생성되었습니다.

    
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '첫번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '두번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '세번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '네번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '다섯번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '여섯번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '일곱번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '여덟번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '아홉번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '열번째 글입니다.');
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '열한번째 글입니다.');
    
    commit;
    
    select * 
    from tbl_board_test_2;
    
    
    -- **** 시퀀스 SEQ_YEYAKNO_2 이 마지막으로 사용되어진 값을 알아보려고 한다. **** --
    select seq_yeyakno_2.currval
    from dual;
    -- 11까지 찍혔다.
    
    select last_number -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다.
    from user_sequences
    where sequence_name = 'SEQ_YEYAKNO_2';
    -- 12
    
    -- **** 시퀀스(sequence) 삭제하기 **** --
    drop sequence seq_yeyakno_2;
    -- Sequence SEQ_YEYAKNO_2이(가) 삭제되었습니다.
    

    ---- **** 생성되어진 시퀀스(sequence)를 조회해 봅니다. **** ----
    select *
    from user_sequences;    
    
    
    
    ---- 07월 27일 오전수업 ----
    
    ------ ==== *** 시노님(Synonym, 동의어) *** ==== ------
    
    select *
    from orauser1.tbl_emp;
    -- ORA-00942: table or view does not exist
    -- select 권한이 없다.
    
    select *
    from orauser1.tbl_emp;
    -- 1001	홍길동
    -- 테이블 이름이 너무 길어서, 동의어를 만들어 짧게 만든다.
    
    -- orauser1.tbl_emp 이름을 emp 라는 이름으로 사용되도록 한다.
    -- 이러한 경우 시노님(Synonym, 동의어) 을 사용하여 해결한다.
    
    create or replace synonym emp for orauser1.tbl_emp;
    -- Synonym EMP이(가) 생성되었습니다.
    -- emp 가 시노님(Synonym, 동의어)이고 for 다음에 나오는 orauser1.tbl_emp 이 원래 이름이다.
    
    select *
    from emp;
    -- 1001	홍길동
    
    --- *** 생성되어진 시노님(Synonym, 동의어)을 조회해본다. *** ---
    select *
    from user_synonyms;
    /*
        --------------------------------------------------------------------
        SYNONYM_NAME        TABLE_OWNER     TABLE_NAME      DB_LINK
        --------------------------------------------------------------------
        EMP	                ORAUSER1	    TBL_EMP         (NULL)
        --------------------------------------------------------------------
    */
    
        
    select *
    from tbl_reservation_merge@bonjumlink;
    
    create or replace synonym reservation for tbl_reservation_merge@bonjumlink;
    -- Synonym RESERVATION이(가) 생성되었습니다.
    
    select *
    from user_synonyms;   

    /*
        --------------------------------------------------------------------
        SYNONYM_NAME        TABLE_OWNER             TABLE_NAME      DB_LINK
        --------------------------------------------------------------------
        EMP	                ORAUSER1	            TBL_EMP          NULL
        RESERVATION		    TBL_RESERVATION_MERGE	BONJUMLINK       BONJUMLINK
        --------------------------------------------------------------------
    */    
    
    select *
    from reservation;
    
    --- *** 시노님(Synonym, 동의어) 삭제하기 *** ---
    drop synonym reservation;
    -- Synonym RESERVATION이(가) 삭제되었습니다.
    
    select *
    from user_synonyms;    
    -- EMP	ORAUSER1	TBL_EMP	
    
    
    
    ---- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ----
    ----------------------------------------------------------------------------
       ---- ==== Constraint(제약조건)을 사용하여 테이블을 생성해 보겠습니다. ==== ----
    
    
    /*
     >>>> 제약조건(Constraint)의 종류 <<<<
     --   제약조건의 이름은 오라클 전체에서 고유해야 한다. --
     
     1. Primary Key(기본키, 대표식별자) 제약 [P]  -- 하나의 테이블당 오로지 1개만 생성할 수 있다.
                                              -- 어떤 컬럼에 Primary Key(기본키) 제약을 주면 그 컬럼에는 자동적으로 NOT NULL 이 주어지면서 
                                                 동시에 그 컬럼에는 중복된 값은 들어올 수 없고 오로지 고유한 값만 들어오게 되어진다.
                                              -- 컬럼 1개를 가지고 생성된 Primary Key 를 Single Primary Key 라고 부르고,
                                              -- 컬럼 2개 이상을 가지고 생성된 Primary Key 를 Composite(복합) Primary Key 라고 부른다.
                                              
                                              
     2. Unique 제약 [U]              -- 하나의 테이블당 여러개를 생성할 수 있다.                                 
                                    -- 어떤 컬럼에 Unique 제약을 주면 그 컬럼에는 NULL 을 허용할 수 있으며, 그 컬럼에는 중복된 값은 들어올 수 없고 오로지 고유한 값만 들어오게 되어진다.             
                                    -- Unique Key 중에 후보키, 후보식별자가 되려면 해당 컬럼은 NOT NULL 이어야 한다.
                                    
     3. Foreign Key(외래키) 제약 [R]  -- 하나의 테이블당 여러개를 생성할 수 있다. 
                                     -- Foreign Key(외래키) 제약에 의해 참조(Reference)받는 컬럼은 반드시 NOT NULL 이어야 하고, 중복된 값을 허락하지 않는 고유한 값만 가지는 컬럼이어야 한다. 
                                     
     4. Check 제약 [C]               -- 하나의 테이블당 여러개를 생성할 수 있다.
                                    -- insert(입력) 또는 update(수정) 시 어떤 컬럼에 입력되거나 수정되는 데이터값을 아무거나 허락하는 것이 아니라 조건에 맞는 데이터값만 넣고자 할 경우에 사용되는 것이다.
  
     5. NOT NULL 제약 [C]            -- 하나의 테이블당 여러개를 생성할 수 있다.
                                    -- 특정 컬럼에 NOT NULL 제약을 주면 그 컬럼에는 반드시 데이터값을 주어야 한다는 말이다. 
    */    
    
    ----- >>>>> Primary Key(기본키, 대표식별자) 제약에 대해서 알아봅니다. <<<<< -----
    
    
    ---- *** "고객" 이라는 테이블을 생성해 보겠습니다. *** ----
    
    drop table tbl_gogek purge;
    -- Table TBL_GOGEK이(가) 삭제되었습니다.
       
    create table tbl_gogek
    (
    --gogekId     varchar2(30)   primary key     -- COLUMN Level 제약조건
     gogekId     varchar2(30)   
    ,gogekName   varchar2(30)   not null
    ,gogekPhone  varchar2(50)   
    
    ,constraint PK_tbl_gogek_gogekId primary key(gogekId)   -- ROW Level 제약조건   gogekId 컬럼에 primary ket(기본키) 제약을 준것이다.
                -- 제약조건의 이름은 최대 30byte 이다.
    /*
        ,constraint PK_tbl_gogek_gogkePhone primary key(gogekPhone)
        오류 보고 -
        ORA-02260: table can have only one primary key
    */
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    -- ORA-02260: table can have only one primary key
    
    desc tbl_gogek;
    
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone) values('leess','이순신','010-2345-6789');
    insert into tbl_gogek(gogekId, gogekName, gogekPhone) values('leess','이삼순','010-5345-9789');
    -- 1번째 : 아이디는 중복되어선 안되나, 중복이 되고 있다.
    -- 2번째 : ORA-00001: unique constraint (HR.SYS_C007072) violated
    insert into tbl_gogek(gogekId, gogekName, gogekPhone) values(null,'이삼식','010-7345-69809');
    -- 1번째 : 아이디는 null이 들어와선 안되나, null이 들어오고 있다.
    -- 2번째 : ORA-01400: cannot insert NULL into ("HR"."TBL_GOGEK"."GOGEKID")
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone) values('eomjh','엄정화','010-2255-6987'); 
    
    
    select *
    from tbl_gogek;
    
    
    -- ** 제약조건의 이름은 오라클 전체에서 고유해야 한다. ** --
    create table tbl_gogek_2
    (gogekId     varchar2(30)   
    ,gogekName   varchar2(30)   not null
    ,gogekPhone  varchar2(50)   
    
    ,constraint PK_tbl_gogek_gogekId primary key(gogekId)
    -- 오류 보고 -
    -- ORA-02264: name already used by an existing constraint
    -- 제약조건의 이름은 최대 30byte 이면서 고유해야 한다.

    );
    
    create table tbl_gogek_2
    (gogekId     varchar2(30)   
    ,gogekName   varchar2(30)   not null
    ,gogekPhone  varchar2(50)   
    
    ,constraint PK_tbl_gogek_2_gogekId primary key(gogekId)
    -- 오류 보고 -
    -- ORA-02264: name already used by an existing constraint
    -- 제약조건의 이름은 최대 30byte 이면서 고유해야 한다.

    );
    
    
    
    
    
    ---- **** tbl_gogek 테이블에 생성되어진 제약조건을 조회해 봅니다. **** ----
    select *
    from user_constraints
    where table_name = 'TBL_GOGEK';
    
    
    ---- **** tbl_jumun 테이블에 생성되어진 제약조건을 조회해 보는데 어떤 컬럼에 생성되어졌는지를 보도록 한다. **** ----
    select *
    from user_cons_columns
    where table_name = 'TBL_GOGEK';    
    
    
    
    
    
    ---- ==== **** Composite(복합) Primary Key 예제 **** ==== ----
    drop table tbl_jumun purge;
    
    
    create table tbl_jumun  -- '주문' 테이블
    (gogekID        varchar2(30)         -- 고객ID
    ,productID      varchar2(30)         -- 제품ID
    ,jumunDate      date default sysdate -- 주문일자, 값을 안 넣어주면 기본적으로 sysdate가 들어간다.
    ,jumunQty       number               -- 주문량
    ,constraint PK_tbl_jumun primary key(gogekID, productID, jumunDate)
    );
    
    desc tbl_jumun;
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('leess', '새우깡', 10);
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('leess', '감자깡', 20);
    -- 같은 ID의 사용자가 다른 제품을 주문하려는데 제약조건 위배로 주문을 못하게 되는 상황이다.
    -- Single Primary Key로 인해서 일어난 상황이다.
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('eomjh', '새우깡', 30);
    -- 제품ID에만 기본키를 줘도 문제가 발생한다.
    -- 다른 사용자가 같은 제품을 주문하려는데 제약조건 위배로 주문을 못하게 되는 상황이다.
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('leess', '새우깡', 40);
    -- 같은 ID의 사용자가 같은 제품을 또 다시 시키면 제약조건 위배가 발생한다.

    
    select gogekid, productid, to_char(jumundate, 'yyyy-mm-dd hh24:mi:ss') AS jumundate, jumunQty
    from tbl_jumun;
    -- 고객ID, 제품ID, 주문일자 까지 묶어버리면 주문일자는 sysdate를 default로 줘서 계속 바뀌기 때문에
    -- 제약조건 위배가 나오지 않는다.
    
    ---- **** tbl_jumun 테이블에 생성되어진 제약조건을 조회해 봅니다. **** ----
    select *
    from user_constraints
    where table_name = 'TBL_JUMUN';    
    -- 싱글인지 복합인지는 안 나온다.
    
    ---- **** tbl_jumun 테이블에 생성되어진 제약조건을 조회해 보는데 어떤 컬럼에 생성되어졌는지를 보도록 한다. **** ----
    select *
    from user_cons_columns
    where table_name = 'TBL_JUMUN';
    -- 이렇게 하면 테이블의 어떤 컬럼이 제약조건인지 알 수 있다.
    -- 그래서 조건절에 한 테이블만 찾게해서 2개 이상 컬럼이 나온다면, 복합 기본키임을 알 수 있다.
    
    
    
    
    ----- >>>>> Unique(후보키, 후보식별자) 제약에 대해서 알아봅니다. <<<<< -----
    -- Unique Key 중에 후보키, 후보식별자가 되려면 해당 컬럼은 NOT NULL 이어야 한다.
    -- 아래의 예제에서는 gogekEmail 컬럼이 후보키, 후보식별자가 된다.
    -- ==> 핸드폰은 NULL이 중복이 가능해져서 회원정보를 찾을 때 NULL 핸드폰번호중 어떤 걸 찾아야 할지 모르기 때문이다.
    
    
     ---- *** "고객" 이라는 테이블을 생성해 보겠습니다. *** ----
    
    drop table tbl_gogek purge;
    -- Table TBL_GOGEK이(가) 삭제되었습니다.
       
    create table tbl_gogek
    (gogekId     varchar2(30)   
    ,gogekName   varchar2(30)   not null
    ,gogekPhone  varchar2(50)       null -- null 을 허용함
    ,gogekEmail  varchar2(50)   not null
    
    ,constraint PK_tbl_gogek_gogekId primary key(gogekId)
    ,constraint UQ_tbl_gogek_gogekPhone Unique(gogekPhone)  -- gogekPhone 컬럼에 Unique 제약을 준 것이다.
    ,constraint UQ_tbl_gogek_gogekEmail Unique(gogekEmail)  -- gogekEmail 컬럼에 Unique 제약을 준 것이다.
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('leess','이순신','010-2345-6789','leess@gmail.com');
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('eomjh','엄정화',null,'eomjh@naver.com'); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('youks','유관순',null,'youks@naver.com'); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('seokj','서강준','010-2345-6789','youks@naver.com'); 
    /*
        오류 보고 -
        ORA-00001: unique constraint (HR.UQ_TBL_GOGEK_GOGEKPHONE) violated
    */
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('seokj','서강준','010-9876-0987','seokj@naver.com'); 
    -- 1 행 이(가) 삽입되었습니다.   
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('leehr','이혜리','010-5678-2356','seokj@naver.com');
    /*
        오류 보고 -
        ORA-00001: unique constraint (HR.UQ_TBL_GOGEK_GOGEKEMAIL) violated
    */
    
    insert into tbl_gogek(gogekId, gogekName, gogekPhone, gogekEmail) values('leehr','이혜리','010-5678-2356','leehr@naver.com'); 
    -- 1 행 이(가) 삽입되었습니다.
    
    select *
    from tbl_gogek;
    
    
    
    ---- ==== **** Composite(복합) Unique Key 예제 **** ==== ----
    drop table tbl_jumun purge;
    
    
    create table tbl_jumun  -- '주문' 테이블
    (gogekID        varchar2(30) not null           -- 고객ID
    ,productID      varchar2(30) not null           -- 제품ID
    ,jumunDate      date default sysdate not null   -- 주문일자, 값을 안 넣어주면 기본적으로 sysdate가 들어간다.
    ,jumunQty       number                          -- 주문량
    ,constraint UQ_tbl_jumun UNIQUE(gogekID, productID, jumunDate)
    );    
    -- 고객ID, 제품ID, 주문일자는 NOT NULL이면서, 고유해야 한다.
    -- NOT NULL + UNIQUE 는 Primary Key와 똑같다.
    -- 허나 UNIQUE는 테이블당 여러 개를 만들 수 있지만, Primary Key는 한 테이블당 1개만 가능하다.
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('leess', '새우깡', 10);
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('leess', '감자깡', 20);
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('eomjh', '새우깡', 30);
    
    insert into tbl_jumun(gogekID, productID, jumunQty) values('leess', '새우깡', 40);
   

    ---- **** tbl_gogek 테이블에 존재하는 제약조건 알아보기 **** ----
    
    select *
    from user_constraints
    where table_name = 'TBL_GOGEK';
    
    select *
    from user_cons_columns
    where table_name = 'TBL_GOGEK';
    -- 복합 제약조건은 이렇게 user_cons_columns 로 조회한다.
    
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_GOGEK';
    
    
    
    ---- **** tbl_jumun 테이블에 존재하는 제약조건 알아보기 **** ----
    
    select *
    from user_constraints
    where table_name = 'TBL_JUMUN';

    select *
    from user_cons_columns
    where table_name = 'TBL_JUMUN';    
    -- 제약조건이름이 똑같은데 컬럼이 2개 이상이라면? 복합 유니크 키인 것이다.
    
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_JUMUN';
    
    
    
    
    
    ----- >>>>> Check 제약에 대해서 알아봅니다. <<<<< -----
    create table tbl_sawon
    (sano           number
    ,saname         varchar2(20)    not null
    ,salary         number(5)       not null         -- 급여는 커미션 보다 커야 한다.
    ,commission     number(5)                        -- 커미션은 0 이상이어야 한다.
    ,jik            varchar2(20)    default '사원'    -- 직급의 종류는 '사장','부장','과장','대리','사원'만 가능하다.
    ,email          varchar2(50)    not null
    ,hire_date      date            default sysdate
    ,constraint PK_tbl_sawon_sano primary key(sano)
    ,constraint UQ_tbl_sawon_email unique(email) -- 나중에 ID를 까먹으면, 후보식별자로 ID를 찾게 해준다.
    ,constraint CK_tbl_sawon_jik check(jik in('사장','부장','과장','대리','사원'))
    ,constraint CK_tbl_sawon_salary_commission check(salary > commission and commission >= 0 )
    -- 샐러리는 커미션보다 커야한다, 커미션은 0 보다 커야한다, 자동적으로 샐러리는 0 보다 커야한다가 성립된다.
    );
    -- Table TBL_SAWON이(가) 생성되었습니다.
    
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email) 
    values(1001, '홍길동', 500, 1000, '과장', 'hongkd@naver.com');
    -- salary는 commission보다 커야한다. 오류발생!
    /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
    */
    
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email) 
    values(1001, '홍길동', 500, -100, '과장', 'hongkd@naver.com');
    /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
    */    
    
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email) 
    values(1001, '홍길동', 500, 100, '장군', 'hongkd@naver.com');    
    /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_SAWON_JIK) violated
    */
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email) 
    values(1001, '홍길동', 500, 100, '과장', 'hongkd@naver.com');      
    -- 1 행 이(가) 삽입되었습니다.
    -- 월급, 커미션, 직급 모두 유효성 통과
    
    select *
    from tbl_sawon;
    
    update tbl_sawon set commission = 499 
    where sano = 1001;
    -- ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
    -- salary 는 commission 보다 커야 한다. (같으면 안됨)
    
    -- 499 는 가능하다.
    -- 1 행 이(가) 업데이트되었습니다.
    
    commit;
    
    ---- **** tbl_sawon 테이블에 존재하는 제약조건 알아보기 **** ----
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_SAWON';
    
    
    
    
    ----- >>>>> Foreign Key(외래키) 제약에 대해서 알아봅니다. <<<<< -----
    
    ---- *** 고객들의 예약을 받아주는 "예약" 테이블을 생성해보겠습니다. *** ----
    select *
    from tbl_gogek;
    
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_GOGEK';
    
    
    alter table tbl_gogek
    drop constraint PK_TBL_GOGEK_GOGEKID; -- tbl_gogek 테이블에 생성되어진 PK_TBL_GOGEK_GOGEKID 제약조건을 삭제하는 것이다.
    -- Table TBL_GOGEK이(가) 변경되었습니다.
    
    alter table tbl_gogek
    add constraint PK_TBL_GOGEK_GOGEKID primary key(gogekid); -- tbl_gogek 테이블의 gogekid 컬럼에 Primary key 제약을 주는 것이다.
    -- Table TBL_GOGEK이(가) 변경되었습니다.
    
    -- 예약번호에 쓸 시퀀스 생성
    create sequence seq_tbl_yeyak
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    -- Sequence SEQ_TBL_YEYAK이(가) 생성되었습니다.
    
    
    
    
    
    
    
    
    --- 어떤 한명의 고객은(예 : leess 이순신) 예약을 1번도 안할 수도 있고,
    --- 예약을 딱 1번만 할 수 있고, 예약을 여러번 할 수도 있다.
    
    drop table tbl_yeyak purge;
    
    create table tbl_yeyak
    (yeyakno        number  --> 예약번호,   예약번호의 값은 NOT NULL 이면서 고유한 값만 가져야 한다.
                            --> 그러므로 yeyakno 컬럼에는 Primary key 제약을 주어야 한다.
                            /*
                                예약번호는 사용자가 수동적으로 입력하지 않고 자동적으로 들어와야 한다.
                                그리고 예약번호는 매번 그 숫자가 증가되면서 고유해야 한다.
                                이렇게 되려면 시퀀스(Sequence)를 사용하면 된다.
                            */
    ,fk_gogekID        varchar2(30) not null -- 고객아이디
                                          -- gogekID 컬럼에 들어올 수 있는 값은 tbl_gogek 테이블의 gogekId 컬럼의 값만 들어와야 한다.
                                          -- 이 뜻은 참조한다는 뜻이므로 Foreign Key를 사용한다.
                                          -- 참조를 받는 컬럼은 (여기서는 tbl_gogek 테이블의 gogekid 임) 반드시 고유한 값을 가지는 컬럼이어야 한다.
                                          -- 즉, 참조를 받는 컬럼은 (여기서는 tbl_gogek 테이블의 gogekid 임) Primary Key 또는 Unique 제약을 가져야 한다.
                                          
    ,ticketCnt         number(2) not null   -- 예약티켓개수
                                            -- 데이터 타입이 number(2) 이므로 -99 ~ 99 값들이 들어온다.
                                            -- 그런데 예약티켓개수는 1번 예약에 최대 10개 까지만 허락하고자 한다.
                                            -- 즉, ticketCnt 컬럼에 들어오는 값은 1 ~ 10 까지만 가능하도록 해야 한다.
                                            -- 이러한 경우 입력된 값을 검사해야 하므로 Check 제약을 사용하면 된다.
    ,registerDay        date default sysdate
    
    
    
    ,constraint PK_tbl_yeyak_yeyakno primary key(yeyakno)
    ,constraint FK_tbl_yeyak_fk_gogekID foreign key(fk_gogekID) references tbl_gogek(gogekid)
   /*
        tbl_yeyak 테이블의 fk_gogekID 컬럼에는 foreign key 제약을 만들었는데
        그 뜻은 tbl_yeyak 테이블의 fk_gogekID 컬럼에 입력(insert)되거나 수정(update)되어지는 값은 반드시 tbl_gogek 테이블의 gogekid 컬럼에 존재하는 값들만 가능하다.
        즉, tbl_gogek 테이블의 gogekID 컬럼에 존재하지 않는 값은 tbl_yeyak 테이블의 fk_gogekid 컬럼에 들어올 수 없다는 말이다.
        그리고 중요한 것은 tbl_gogek 의 gogekid 컬럼은 식별자 컬럼(Primary Key, Unique Key)이어야 한다.
   
   */
    ,constraint CK_tbl_yeyak_ticketcnt Check(1 <= ticketCnt and ticketCnt <= 10)
    );
    -- Table TBL_YEYAK이(가) 생성되었습니다.
    
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketcnt) values(seq_tbl_yeyak.nextval, 'leess', 5);
    -- tbl_gogek에 있는 회원이여서 삽입이 된다.
    
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketcnt) values(seq_tbl_yeyak.nextval, 'superman', 5);
    -- tbl_gogek 에 없는 회원이여서 오류가 난다.
    /*
        오류 보고 -
        ORA-02291: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - parent key not found
    */
    
    
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketcnt) values(seq_tbl_yeyak.nextval, 'eomjh', 20);
    -- ticketcnt의 조건에 맞질 않아서 오류가 난다.
    /*
    오류 보고 -
    ORA-02290: check constraint (HR.CK_TBL_YEYAK_TICKETCNT) violated
    */
    
    insert into tbl_yeyak(yeyakno, fk_gogekID, ticketcnt) values(seq_tbl_yeyak.nextval, 'eomjh', 7);
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    
    select *
    from tbl_yeyak;
    -- 엄정화는 시퀀슥 4로 표기된다.
    -- 시퀀스를 사용하긴 했으나, 제약조건으로 인해 insert가 안됐을 뿐이여서 시퀀스가 올라간다.
    -- ※ 시퀀스는 굳이 1, 2, 3, 4, 5 맞출 필요 없다. 고유하기만 하면 되기 때문이다.
    
    
    

    
    
    
    ----- ***** foreign key 제약이 있는 테이블을 "자식" 테이블 이라고 하고, 
    -----       foreign key 에 의해 참조를 받는 테이블을 "부모" 테이블 이라고 한다. **** ------
    
    
    
    ----- "자식" 테이블(여기서는 tbl_yeyak 테이블)에 입력되어진 데이터가 "부모" 테이블(여기서는 tbl_gogek 테이블) 존재하는 경우에
    ----- "부모" 테이블의 행을 삭제할 때 어떻게 되어지는지 알아봅니다.
    
    select *
    from tbl_yeyak; -- "자식" 테이블 // foreign key 가 있는 곳이 자식테이블이다.
    /*
    ---------------------------------------------------------------------
        yeyakno     fk_gogekid      ticketcnt   registerday
    ---------------------------------------------------------------------    
        1	          leess	           5	      21/07/27
        4	          eomjh	           7	      21/07/27
    ---------------------------------------------------------------------    
    */
    
    
    
    select *
    from tbl_gogek; -- "부모" 테이블
    /*
   -----------------------------------------------------------------------
   gogekid        gogekname              gogekphone           gogekemail
   -----------------------------------------------------------------------
   
    leess	        이순신	            010-2345-6789	    leess@gmail.com
    eomjh	        엄정화		        null                eomjh@naver.com
    youks	        유관순		        null                youks@naver.com
    seokj	        서강준	            010-9876-0987	    seokj@naver.com
    leehr	        이혜리	            010-5678-2356	    leehr@naver.com
    */
    
    
    delete from tbl_gogek
    where gogekid = 'seokj';
    -- 1 행 이(가) 삭제되었습니다.
    
    
    delete from tbl_gogek
    where gogekid = 'leess'; -- 자식테이블에서 사용중인 아이디임
    
    /*
    오류 보고 -
    ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found
    
    child ==> 자식테이블(tbl_yeyak)
    child record found 말은 tbl_yeyak 테이블에 존재하는 '1	leess	5	21/07/27' 행을 말한다.
    */
    
    
    -- 07월 28일
    -- !!!!!!!!!!!![퀴즈] TBL_YEYAK 테이블에 존재하는 제약조건 중에 Foreign Key 제약조건을 조회하는데 아래와 같이 나오도록 하세요..!!!!!!!
    -----------------------------------------------------------------------------------------------------------------------
    제약조건명                       제약조건타입          컬럼명             참조를받는부모테이블명        참조를받는식별자컬럼명
    -----------------------------------------------------------------------------------------------------------------------
    FK_TBL_YEYAK_FK_GOGEKID             R             FK_GOGEKID               TBL_GOGEK                    GOGEKID
    -----------------------------------------------------------------------------------------------------------------------
    -- 자식테이블의 제약조건명, 제약조건 타입, 참조를 하는 제약조건명을 가져온다.
    select constraint_name, constraint_type, R_constraint_name 
    from user_constraints 
    where table_name = 'TBL_YEYAK' and constraint_type = 'R';
    
    

    
    /*
        --------------------------------------------------------------------
        constraint_name             constraint_type             R_constraint_name
        --------------------------------------------------------------------
        FK_TBL_YEYAK_FK_GOGEKID	        R	                 PK_TBL_GOGEK_GOGEKID
    
    */
    
    -- 자식테이블의 제약조건 컬럼명을 가져온다.
    select constraint_name, column_name
    from user_cons_columns
    where table_name = 'TBL_YEYAK';
    
    /*
    -------------------------------------------------------------
    constraint_name                     column_name
    -------------------------------------------------------------
    SYS_C007113	                        FK_GOGEKID
    SYS_C007114	                        TICKETCNT
    CK_TBL_YEYAK_TICKETCNT	            TICKETCNT
    PK_TBL_YEYAK_YEYAKNO	            YEYAKNO
    FK_TBL_YEYAK_FK_GOGEKID	            FK_GOGEKID 
    */
    
    -- 부모테이블의 제약조건 컬럼명을 가져온다.
    select constraint_name, table_name, column_name
    from user_cons_columns
    where constraint_name = (    select R_constraint_name 
                                 from user_constraints 
                                 where table_name = 'TBL_YEYAK' and constraint_type = 'R'  )
                                 
    select constraint_name, table_name, column_name 
    from user_cons_columns
    where constraint_name = ( select R_constraint_name from user_constraints where table_name = 'TBL_YEYAK' and constraint_type = 'R' );
    

    
                                 
                                 
                                 
                                 
     /*
        -------------------------------------------------------------------
        constraint_name         table_name  column_name
        -------------------------------------------------------------------
        PK_TBL_GOGEK_GOGEKID	TBL_GOGEK	GOGEKID
     */
     
     with A as
     (
         select constraint_name, constraint_type, R_constraint_name 
         from user_constraints 
         where table_name = 'TBL_YEYAK' and constraint_type = 'R'
      )
    , B as 
     (
        select constraint_name, column_name
        from user_cons_columns
        where table_name = 'TBL_YEYAK'
      )
    , C as
     (
       select constraint_name, table_name, column_name
       from user_cons_columns
       where constraint_name = (    select R_constraint_name 
                                 from user_constraints 
                                 where table_name = 'TBL_YEYAK' and constraint_type = 'R'  )
     )
    
                                                          
    select A.constraint_name AS 제약조건명
         , A.constraint_type AS 제약조건타입
         , B.column_name AS 컬럼명
         , C.table_name AS 참조받는부모테이블명
         , C.column_name AS 참조받는식별자컬럼명
    from A join B 
    on A.constraint_name = B.constraint_name
    join C 
    on A.r_constraint_name = C.constraint_name;
     
     
     
     
     
                                 
    
    ---- **** ==== !!!! Foreign Key 생성시 on delete cascade 옵션을 주는 것 !!!! ==== **** ----
    
    
    create table tbl_board_a ---> "원글" 테이블
    (writeno            number  --- 원글의 글번호
    ,subject            varchar2(100) not null --- 원글의 글제목
    ,constraint PK_tbl_board_a primary key(writeno)
    );
    -- Table TBL_BOARD_A이(가) 생성되었습니다.
    
    insert into tbl_board_a(writeno, subject) values(1001, '천일번째 원글입니다.');
    insert into tbl_board_a(writeno, subject) values(1002, '천이번째 원글입니다.');
    insert into tbl_board_a(writeno, subject) values(1003, '천삼번째 원글입니다.');
    
    commit;
    -- 커밋 완료.
    
    
    
    select *
    from tbl_board_a;
    
    create table tbl_board_a_add ---> "댓글" 테이블
    (addno          number        -- 댓글의 글번호
    ,subject        varchar2(100) -- 댓글의 글제목
    ,fk_writeno     number        -- 원글의 글번호
    ,constraint     PK_tbl_board_a_add primary key(addno)
    ,constraint     FK_tbl_board_a_add foreign key(fk_writeno) references tbl_board_a(writeno)
    );
    -- 참조를 받는 컬럼은 식별자이여야 한다. 기본식별자 - primary key or 후보식별자 - unique
    -- Table TBL_BOARD_A_ADD이(가) 생성되었습니다.
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(1, '천일번째 원글에 대한 첫번째 댓글입니다', 1001);
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(2, '천이번째 원글에 대한 첫번째 댓글입니다', 1002);
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(3, '천일번째 원글에 대한 두번째 댓글입니다', 1001);
    
    commit;    
    
    select *
    from tbl_board_a_add;
    
    ---- **** 원글 삭제하기 **** -----
    
    select *
    from tbl_board_a;
    
    
    delete from tbl_board_a
    where writeno = 1003;
    -- 1 행 이(가) 삭제되었습니다.
    
    delete from tbl_board_a
    where writeno = 1001;
   /*
    오류 보고 -
    ORA-02292: integrity constraint (HR.FK_TBL_BOARD_A_ADD) violated - child record found
    
    < 댓글 >
    1	천일번째 원글에 대한 첫번째 댓글입니다	1001
    3	천일번째 원글에 대한 두번째 댓글입니다	1001
    
    ==> 1001번 글에 달린 댓글들 때문에 삭제를 할 수 없다.
    ==> 1001번 글을 삭제했는데 1001번에 대한 댓글이 남아있는 것은 모순임.
    
    ==> 허나, 우리는 원글을 삭제해야한다.
   */
    
    ---- tbl_board_a 테이블에 딸린 자식테이블이 뭔지 조사해와서 삭제하고자 하는 부모테이블의 컬럼값을 가지는 자식테이블의 행을 먼저 삭제해야 한다.
    
    delete from tbl_board_a_add 
    where fk_writeno = 1001;
    -- 2개 행 이(가) 삭제되었습니다.
    
    delete from tbl_board_a
    where writeno = 1001;
    -- 1 행 이(가) 삭제되었습니다.
    
    select *
    from tbl_board_a; 
    
    ---- 위와 같이 하는 것은 수작업 방법이다.
    
    commit;
    
    
    ----------------------------------------------------------------------
    
    ---- 아래는 위의 방법들을 한방에 끝낼 수 있는 방법이다.
    
    
    insert into tbl_board_a(writeno, subject) values(1001, '천일번째 원글입니다.');
    insert into tbl_board_a(writeno, subject) values(1003, '천삼번째 원글입니다.');
    
    commit;        
    
    select *
    from tbl_board_a; 
    
    drop table tbl_board_a_add purge;
    
    create table tbl_board_a_add ---> "댓글" 테이블
    (addno          number        -- 댓글의 글번호
    ,subject        varchar2(100) -- 댓글의 글제목
    ,fk_writeno     number        -- 원글의 글번호
    ,constraint     PK_tbl_board_a_add primary key(addno)
    ,constraint     FK_tbl_board_a_add foreign key(fk_writeno) references tbl_board_a(writeno) on delete cascade
                    /*
                        on delete cascad 의 의미는
                        부모 테이블인 tbl_board_a 테이블에서 행을 delete 할 시
                        자식 테이블인 tbl_board_a_add 테이블에 fk_writeno 컬럼에 삭제하려는 tbl_board_a 부모 테이블의 writeno 컬럼값을
                        가지는 행이 있다라면 자동적으로 자식 테이블에서 먼저 행을 삭제하고서
                        그 다음에 부모 테이블인 tbl_board_a에서 행을 삭제해주는 것이다.
                    */
    );
    -- 참조를 받는 컬럼은 식별자이여야 한다. 기본식별자 - primary key or 후보식별자 - unique
    -- Table TBL_BOARD_A_ADD이(가) 생성되었습니다.
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(1, '천일번째 원글에 대한 첫번째 댓글입니다', 1001);
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(2, '천이번째 원글에 대한 첫번째 댓글입니다', 1002);
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(3, '천일번째 원글에 대한 두번째 댓글입니다', 1001);
    
    commit;        
    
    select *
    from tbl_board_a_add;
    
    
    
   ---- **** 원글 삭제하기 **** -----
    
    select *
    from tbl_board_a;
    
    
    delete from tbl_board_a
    where writeno = 1003;
    -- 1 행 이(가) 삭제되었습니다.
    
    delete from tbl_board_a
    where writeno = 1001;
    -- 1 행 이(가) 삭제되었습니다.    
    
    
    /*
        foreign key 생성시 on delete cascade 을 주었으므로
        내부적으로 아래의 작업을 자동적으로 먼저 해준다.
        
        delete from tbl_board_a_add 
        where fk_writeno = 1001;
        -- 2개 행 이(가) 삭제되었습니다.  
        
        그런 다음에
        
        delete from tbl_board_a
        where writeno = 1001;
        
        이것을 해주는 것이다.
    */
   
    select *
    from tbl_board_a_add;    
    
    
    rollback;
    
    
    select *
    from departments;
    
    select *
    from employees;
    
    update employees set department_id = 55
    where department_id = 50;
    /*
    오류 보고 -
    ORA-02291: integrity constraint (HR.EMP_DEPT_FK) violated - parent key not found
    */
    
    -- departments 테이블에는 부서번호가 55 가 없다.
    -- employees 에서 쓰는 department_id는 foreign key 여서 부모테이블에 있는 값으로만 update 가능하다.
    
    
    delete from departments
    where department_id = 50;
    /*
    오류 보고 -
    ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
    */
    -- employees 에서 department_id 를 foreign key 로 쓰고 있어서 삭제 불가
    -- 만약에 on delete cascade 를 줬다면, 부서테이블에서 50번 부서 행을 지우면
    -- employees 에 있는 모든 50번 부서의 사람들마저도 지워버린다.
    -- 사원들을 다 지운다음에 50번 부서도 지운다.
    ----> 내가 원하는건 부서 통폐합인데, on delete cascade를 써버리면 사원들을 짤라버린다.
    -- 그래서 무조건 on delete cascade는 줘선 안 된다.
       
       
       
       
    ---- **** ==== !!!! Foreign Key 생성시 on delete set null 옵션을 주는 것 !!!! ==== **** ----
    
    
    -- 부모 테이블을 삭제하려고 한다라면 먼저 자식테이블의 foreign key 제약을 삭제하든지 
    -- 아니면 자식 테이블을 먼저 하고서 그 다음에 부모 테이블을 삭제해야 한다.
    drop table tbl_board_a_add purge;
    -- Table TBL_BOARD_A_ADD이(가) 삭제되었습니다.
    
    drop table tbl_board_a purge;
    -- Table TBL_BOARD_A이(가) 삭제되었습니다.
    
  
    
    
    create table tbl_board_a ---> "원글" 테이블
    (writeno            number  --- 원글의 글번호
    ,subject            varchar2(100) not null --- 원글의 글제목
    ,constraint PK_tbl_board_a primary key(writeno)
    );
    -- Table TBL_BOARD_A이(가) 생성되었습니다.
    
    insert into tbl_board_a(writeno, subject) values(1001, '천일번째 원글입니다.');
    insert into tbl_board_a(writeno, subject) values(1002, '천이번째 원글입니다.');
    insert into tbl_board_a(writeno, subject) values(1003, '천삼번째 원글입니다.');
    
    commit;    
    
    
    
    create table tbl_board_a_add ---> "댓글" 테이블
    (addno          number        -- 댓글의 글번호
    ,subject        varchar2(100) -- 댓글의 글제목
   -- ,fk_writeno     number  not null      -- 원글의 글번호
    ,fk_writeno     number  
    ,constraint     PK_tbl_board_a_add primary key(addno)
    ,constraint     FK_tbl_board_a_add foreign key(fk_writeno) references tbl_board_a(writeno) on delete set null
                    /*
                        on delete set null 의 의미는
                        부모 테이블인 tbl_board_a 테이블에서 행을 delete 할 시
                        자식 테이블인 tbl_board_a_add 테이블에 fk_writeno 컬럼에 삭제하려는 tbl_board_a 부모 테이블의 writeno 컬럼값을
                        가지는 행이 있다라면 자동적으로 자식 테이블인 tbl_board_a_add 에서 먼저 fk_writeno 컬럼의 값을 null로 변경(update)해준다.
                        그 다음에 부모 테이블인 tbl_board_a에서 행을 삭제해주는 것이다.
                        이렇게 하기 위해서는 fk_writeno 컬럼은 null 을 허용해야만 한다.
                        
                        
                    */
    );
    -- 참조를 받는 컬럼은 식별자이여야 한다. 기본식별자 - primary key or 후보식별자 - unique
    -- Table TBL_BOARD_A_ADD이(가) 생성되었습니다.
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(1, '천일번째 원글에 대한 첫번째 댓글입니다', 1001);
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(2, '천이번째 원글에 대한 첫번째 댓글입니다', 1002);
    
    insert into tbl_board_a_add(addno, subject, fk_writeno)
    values(3, '천일번째 원글에 대한 두번째 댓글입니다', 1001);
    
    commit;            
    
    select *
    from tbl_board_a_add;
    
    select *
    from tbl_board_a;
    
    
    ---- **** 원글 삭제하기 **** ----
    
    
    delete from tbl_board_a
    where writeno = 1001;
    -- 1 행 이(가) 삭제되었습니다.
    
    select *
    from tbl_board_a;
    
    select *
    from tbl_board_a_add;
    -- 1001번 글을 삭제하기 위해서 1001 을 참조해간 값들이 모두 null로 바꿔서 
    -- 부모 테이블을 없앴기에 부모 테이블의 데이터를 정상적으로 삭제할 수 있게 됐다.
    
    select *
    from tbl_board_a;
    
    rollback;
    -- 롤백 완료.
    
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_BOARD_A_ADD';        
    
    
    ----- >>>>> NOT NULL 제약에 대해서 알아봅니다. <<<<< -----
    ----- 어떤 컬럼의 값을 입력하거나 수정할 때 NULL 을 허락하지 않는다는 말이다.
    
    drop table tbl_jikwon;
    
    create table tbl_jikwon
    (sano           number
    ,saname         varchar2(20)    constraint NN_tbl_jikwon_saname not null  
    ,salary         number(5)       not null         -- 급여는 커미션 보다 커야 한다.
    ,commission     number(5)                        -- 커미션은 0 이상이어야 한다.
    ,jik            varchar2(20)    default '사원'    -- 직급의 종류는 '사장','부장','과장','대리','사원'만 가능하다.
    ,email          varchar2(50)    not null
    ,hire_date      date            default sysdate
    ,constraint PK_tbl_jikwon_sano primary key(sano)
    ,constraint UQ_tbl_jikwon_email unique(email) -- 나중에 ID를 까먹으면, 후보식별자로 ID를 찾게 해준다.
    ,constraint CK_tbl_jikwon_jik check(jik in('사장','부장','과장','대리','사원'))
    ,constraint CK_tbl_jikwon_salaryCommission check(salary > commission and commission >= 0 )
    );
    -- Table TBL_JIKWON이(가) 생성되었습니다.
    
    insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 200, '부장', 'hongkd@gmail.com');
    
    insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
    values(1002, '엄정화', 600, 300, '과장', 'eomjh@gmail.com');    
    
    insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
    values(1003, '이순신', 300, 100, '대리', 'leess@gmail.com');
    
    commit;
    
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_JIKWON';
    
    ---- **** 어떤 테이블을 Sub Query 를 사용하여 어떤 테이블을 생성할 경우 원본테이블에 존재하던 제약조건중 NOT NULL 제약만 복사가 되어지고
    ----      나머지 제약조건은 복사가 안 됩니다. 또한 복사되는 NOT NULL 제약의 제약조건명은 SYS_C뭐뭐뭐로 변경되어진다.
    
    create table tbl_jikwon_copy
    as
    select *
    from tbl_jikwon;
    -- Table TBL_JIKWON_COPY이(가) 생성되었습니다.
    
        
    select * 
    from tbl_jikwon_copy;
    
    
    select A.constraint_name, A.constraint_type, A.search_condition, B.column_name, B.position
    from user_constraints A JOIN user_cons_columns B
    on A.constraint_name = B.constraint_name 
    where A.table_name = 'TBL_JIKWON_COPY';    

    
    --------- 07월 28일 오전수업 ------------
    --------- **** 어떤 테이블에 제약조건을 추가하기 ***** --------------
    
    /*
       제약조건 추가시 NOT NULL 제약을 제외한 나머지 4개는 아래와 같이한다.
       
       alter table 테이블명 add constraint 제약조건명 primary key(컬럼명);
       alter table 테이블명 add constraint 제약조건명 unique(컬럼명);
       alter table 테이블명 add constraint 제약조건명 check( ... );
       
       alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명) references 부모테이블명(컬럼명);
       alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명) references 부모테이블명(컬럼명) on delete casecade;
       alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명) references 부모테이블명(컬럼명) on delete set null;
    */    
    
    
    /*
        NOT NULL 제약을 추가할 때는 아래와 같이 한다.
        
        alter table 테이블명 modify 컬럼명 (제약조건명) not null;
    
    
    */
    
    alter table TBL_JIKWON_COPY
    add constraint PK_TBL_JIKWON_COPY_SANO primary key(SANO);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    alter table TBL_JIKWON_COPY
    add constraint UQ_TBL_JIKWON_COPY_EMAIL unique(EMAIL);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    alter table TBL_JIKWON_COPY 
    add constraint CK_TBL_JIKWON_COPY_JIK check( JIK in('사장','부장','과장','대리','사원') );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    alter table TBL_JIKWON_COPY 
    add constraint CK_TBL_JIKWON_COPY_SAL_COMM check( salary > commission and commission >= 0  );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    
    
    
    ---- *** 어떤 테이블에 제약조건을 삭제하기 *** ----
    /*
        alter table 테이블명 drop constraint 제약조건명;
        
        그런데 NOT NULL 제약은 위의 것처럼 해도 되고, 또는 아래처럼 해도 된다.
        alter table 테이블명 modify 컬럼명 null;
        
        어떤 테이블에 primary key 제약조건을 삭제할 경우에는 위의 것처럼 해도 되고, 또는 아래처럼 해도 된다.
        alter table 테이블명 drop primary key;
    */    
    
    alter table TBL_JIKWON_COPY 
    drop constraint CK_TBL_JIKWON_COPY_SAL_COMM;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    /*
        alter table TBL_JIKWON_COPY 
        drop constraint SYS_C007141;
    */
    
    -- 또는
    
    alter table TBL_JIKWON_COPY
    modify SALARY null;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    /*
        alter table TBL_JIKWON_COPY
        drop constraint PK_TBL_JIKWON_COPY_SANO;
    */
    
    -- 또는, 아래와 같이한다. Primary Key는 테이블당 1개밖에 없으니 아래도 가능하다.
    
    alter table TBL_JIKWON_COPY
    drop primary key;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    
    
    ---- *** 어떤 테이블에 생성되어진 제약조건의 내용을 변경하기 *** ----
    ---->    기존 제약조건을 삭제하고서 내용이 변경되어진 제약조건을 추가하는 것이다.
    ---- TBL_JIKWON_COPY 테이블에 생성되어진 JIK 컬럼에 대한 Check 제약의 내용을 변경하겠습니다.
    ---- 직급에 '이사'를 추가한다.
    
    
    alter table TBL_JIKWON_COPY
    drop constraint CK_TBL_JIKWON_COPY_JIK;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    alter table TBL_JIKWON_COPY
    add constraint CK_TBL_JIKWON_COPY_JIK check( JIK in('사장','이사','부장','과장','대리','사원')  );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    ---- *** 어떤 테이블에 생성되어진 제약조건의 이름을 변경하기 *** ----
    /*
        alter table 테이블명
        rename constraint 현재사용중인제약조건명 to 새로운제약조건명;
    */
    
    
    alter table TBL_JIKWON_COPY
    modify salary not null;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    alter table TBL_JIKWON_COPY
    rename constraint SYS_C007154 to NN_TBL_JIKWON_COPY_SALARY;  
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    
    ---- *** 어떤 테이블에 존재하는 제약조건을 비활성화 시키기 *** ----
    /*
        alter table 테이블명
        disable constraint 제약조건명;
    */
    select constraint_name, constraint_type, search_condition, status
    from user_constraints
    where table_name = 'TBL_JIKWON_COPY';
    
    alter table TBL_JIKWON_COPY
    disable constraint CK_TBL_JIKWON_COPY_JIK;  
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    
    ---- *** 어떤 테이블에 존재하는 제약조건을 활성화 시키기 *** ----
    /*
        alter table 테이블명
        enable constraint 제약조건명;
    */
    select constraint_name, constraint_type, search_condition, status
    from user_constraints
    where table_name = 'TBL_JIKWON_COPY';
    
    alter table TBL_JIKWON_COPY
    enable constraint CK_TBL_JIKWON_COPY_JIK;  
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.    
    
    
    ---- **** 어떤 테이블에 새로운 컬럼 추가하기 **** ----
    
    /*
        alter table 테이블명 
        add 추가할컬럼명 데이터타입

    */
    

    desc TBL_JIKWON_COPY;
    
    alter table TBL_JIKWON_COPY
    add jubun varchar2(13);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    select *
    from tbl_jikwon_copy;
    
    alter table TBL_JIKWON_COPY
    modify jubun not null;
    /*
    오류 보고 -
    ORA-02296: cannot enable (HR.) - null values found     
    */
    -- 현재 데이터(행)가 하나도 없으면 가능하나, 데이터가 들어와져있는 상태에서 
    -- 주번 컬럼을 변경하려 한 것이다.
    -- 이미 주번컬럼은 NULL로 설정되있는데, 주번컬럼을 NOT NULL로 변경하려하면 
    -- 모순이되서 오류가 뜬다.
    
    update TBL_JIKWON_COPY set jubun = ' ' 
    where jubun is null;
    -- 일단 NOT NULL로 변경하기 위해서 임의로 공백으로 값을 준다.
    -- 3개 행 이(가) 업데이트되었습니다.
    
    alter table TBL_JIKWON_COPY
    modify jubun not null;
    -- DDL 문이여서 위의 UPDATE도 포함해서 AUTO COMMIT 된다.
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    select *
    from tbl_jikwon_copy;
    
     ---- **** 어떤 테이블에 새로운 컬럼 삭제하기 **** ----
    /*
        alter table 테이블명 
        drop column 삭제할컬럼명;

    */    
    
    alter table tbl_jikwon_copy 
    drop column jubun; 
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc tbl_jikwon_copy;
    
    ---- **** 어떤 테이블에 새로운 컬럼 추가하는데 동시에 NOT NULL 을 주고 싶다. **** ----
    /*
        alter table 테이블명 
        add 추가할컬럼명 데이터타입 NOT NULL; 이 아니라,
        
        alter table 테이블명 add 추가할컬럼명 데이터타입 default 기본값 NOT NULL; 이다. 

    */    
    
    alter table tbl_jikwon_copy 
    add jubun varchar2(13) NOT NULL;
    /*
        오류 보고 -
        ORA-01758: table must be empty to add mandatory (NOT NULL) column
    */
    
    alter table tbl_jikwon_copy 
    add jubun varchar2(13) default ' ' NOT NULL;
    
    desc tbl_jikwon_copy;
    
    select *
    from tbl_jikwon_copy;
    
    
    ---- *** 어떤 테이블에 존재하는 컬럼명을 변경하기 *** ----
    /*
        alter table 테이블명
        rename column 현재컬럼명 to 새로이변경할컬럼명;
    
    */
    
    alter table TBL_JIKWON_COPY
    rename column jubun to juminbunho;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc tbl_jikwon_copy;
    
    select *
    from tbl_jikwon_copy;
    
    
     ---- *** 어떤 테이블에 존재하는 컬럼의 데이터타입 변경하기 *** ----   
     /*
        alter table 테이블명
        modify 컬럼명 새로운데이터타입;
     */
     
    alter table tbl_jikwon_copy
    modify email varchar2(100);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc tbl_jikwon_copy;
    -- 변경 전 : EMAIL      NOT NULL VARCHAR2(20) 
    -- 변경 후 : EMAIL      NOT NULL VARCHAR2(100)
    
    select *
    from tbl_jikwon_copy;
    
    alter table tbl_jikwon_copy
    modify email varchar2(10);
    /*
        오류 보고 -
    ORA-01441: cannot decrease column length because some value is too big
    */
    
    alter table tbl_jikwon_copy
    modify email varchar2(20);
    
    desc tbl_jikwon_copy;
    -- EMAIL      NOT NULL VARCHAR2(20) 
    
    ---- **** 어떤 테이블의 테이블명 변경하기 **** ----
    /*
        rename 현재테이블명 to 새로운테이블명;
    
    */
    
    rename TBL_JIKWON_COPY to TBL_JIKWON_BACKUP;
    -- 테이블 이름이 변경되었습니다.
    
    select *
    from TBL_JIKWON_COPY;
    -- ORA-00942: table or view does not exist

    select *
    from TBL_JIKWON_BACKUP;
    
    
    ---- !!!! 테이블을 생성한 이후에 반드시 테이블명에 대한 주석문을 달아주도록 합시다. !!!! ----
    
    ---- **** 테이블명에 달려진 주석문 조회하기 **** ----
    
    select* 
    from user_tab_comments;
    
    comment on table tbl_jikwon
    is '우리회사 사원들의 정보가 들어있는 테이블';
    -- Comment이(가) 생성되었습니다.
    
    ---- !!!! 테이블을 생성한 이후에 반드시 컬럼명에 대한 주석문을 달아주도록 합시다. !!!!   ----       
    
    select *
    from user_col_comments
    where table_name = 'EMPLOYEES';
    
    select *
    from user_col_comments
    where table_name = 'TBL_JIKWON';
    
    comment on column TBL_JIKWON.SANO is '사원번호 Primary Key'; -- Comment이(가) 생성되었습니다.
    comment on column TBL_JIKWON.SANAME is '사원명 NOT NULL';  -- Comment이(가) 생성되었습니다.
    comment on column TBL_JIKWON.SALARY is '기본급여 0이상 이면서 COMMISSION 보다 크다'; -- Comment이(가) 생성되었습니다.
    comment on column TBL_JIKWON.COMMISSION is '커미션 최소 0 이면서 SALARY 보다 작다'; -- Comment이(가) 생성되었습니다.
    comment on column TBL_JIKWON.JIK is '직급 사장,이사,부장,과장,대리,사원 만 가능함 '; -- Comment이(가) 생성되었습니다.
    comment on column TBL_JIKWON.EMAIL is '이메일'; -- Comment이(가) 생성되었습니다.
    comment on column TBL_JIKWON.HIRE_DATE is '입사일자 기본값은 sysdate'; -- Comment이(가) 생성되었습니다.
    
    select column_name, comments
    from user_col_comments
    where table_name = 'TBL_JIKWON';
    
    
    
    
    ----------------------------------------------------------------------------------------
    ---- !!!! 테이블 삭제시 휴지통에 버리기 ==> drop 되어진 테이블을 복구가 가능하도록 만들어 주는 것이다.
    
    create table tbl_exam_01
    (name   varchar2(20)); 
    insert into tbl_exam_01(name) values('연습1');
    commit;
    
    
    create table tbl_exam_02
    (name   varchar2(20));
    insert into tbl_exam_02(name) values('연습2');
    commit;    
    
    
    create table tbl_exam_03
    (name   varchar2(20));
    insert into tbl_exam_03(name) values('연습3');
    commit;  
    
    
    create table tbl_exam_04
    (name   varchar2(20));
    insert into tbl_exam_04(name) values('연습4');
    commit;
    
    
    create table tbl_exam_05
    (name   varchar2(20));
    insert into tbl_exam_05(name) values('연습5');
    commit; 
    
    
    create table tbl_exam_06
    (name   varchar2(20));
    insert into tbl_exam_06(name) values('연습6');
    commit;     
    
    drop table tbl_exam_01; --> tbl_exam_01 테이블을 영구히 삭제하는 것이 아니라 휴지통에 버리는 것이다.
    -- Table TBL_EXAM_01이(가) 삭제되었습니다.
    
    
    select * from tab;
    -- BIN$gHuCFR20TkewDnPk6GU3wQ==$0
    -- tbl_exam_01이 완전삭제되지 않고, 남아있는 것이다.
    -- 결과물에서 tname 컬럼에 BIN$ 로 시작하는 것은 휴지통에 버려진 테이블이다.
    
    drop table tbl_exam_02; --> tbl_exam_01 테이블을 영구히 삭제하는 것이 아니라 휴지통에 버리는 것이다.
    -- Table TBL_EXAM_01이(가) 삭제되었습니다.    
    
    select *
    from tbl_exam_01;
    -- ORA-00942: table or view does not exist
    
    select *
    from tbl_exam_02;    
    -- ORA-00942: table or view does not exist
    
    select *
    from "BIN$gHuCFR20TkewDnPk6GU3wQ==$0";
    -- 쌍따옴표를 붙여야 읽을 수 있다.
    
    select *
    from "BIN$cwypAXw6QUqCYhllphV1rg==$0";
    
    
    ----- ===== *** 휴지통 조회하기 *** ===== -----
    select *
    from user_recyclebin;

    ----- ===== *** 휴지통에 있던 테이블을 복원하기 *** ===== ------
    flashback table tbl_exam_01 to before drop;
    -- Flashback을(를) 성공했습니다.
    -- tbl_exam_01 은 original_name 컬럼에 나오는 것이다.
    
    select *
    from tbl_exam_01;    
    -- 복원됨.
    
    
    ----- ===== **** 휴지통에 있던 특정 테이블을 영구히 삭제하기 **** ===== -----
    select *
    from user_recyclebin;    
    
    purge table tbl_exam_02;
    -- Table이(가) 비워졌습니다.
    -- tbl_exam_02 은 original_name 컬럼에 나오는 것이다.
    
    
    
    ----- ===== **** 휴지통에 있던 모든 테이블을 영구히 삭제하기 **** ===== -----
    drop table tbl_exam_03; -- Table TBL_EXAM_03이(가) 삭제되었습니다.
    drop table tbl_exam_04; -- Table TBL_EXAM_04이(가) 삭제되었습니다.
    
    select *
    from user_recyclebin;    
    
    purge recyclebin; -- 휴지통에 있던 모든 테이블을 영구히 삭제하기
    -- Recyclebin이(가) 비워졌습니다.
    
    
    select *
    from tbl_exam_05;
    
    ---- *** 테이블을 영구히 삭제하기 ==> drop 되어진 테이블은 복원이 불가하다.
    drop table tbl_exam_05 purge;
    -- Table TBL_EXAM_05이(가) 삭제되었습니다.

    select *
    from user_recyclebin;   
    
    
    --------------- ============ **** 계층형 쿼리 **** ============ ---------------
    
    /*
        계층형 쿼리는 Spring 프레임워크 시간에 답변형 게시판에서 사용한다.
        또한 전자결재 에서도 사용된다.
    */
    
    /*
        1           이재성
                      |
        2           송동준
                      |
              -------------------
               |       |       |
        3    금길영    장현걸   이순신
               |               |
           ---------           |
           |       |           |        
        4 홍길동   강감찬       김유신
    */
    
    select *
    from employees
    order by employee_id asc;
    
    
    
    -- 결제라인을 만들어 보겠습니다.
    -- 출발 104 ==> 103 ==> 102 ==> 100 ==> null
    -- level 1      2       3       4       
    


    select level
            , employee_id  AS 사원번호
            , first_name || ' ' || last_name AS 사원명
            , manager_id AS 직속결재권자
    from employees
    start with employee_id = 104    --  start with employee_id = 103
    connect by prior manager_id = employee_id;
    --- 사원번호 104번의 행에 manager_id 값이 들어온다.
    --- 즉 103 이 들어온다.  
    -- 사원번호가 103번인 사람, 사원번호가 102번인 사람... -> 결제라인(상관들)
    
    /*
        connect by prior 103 = employee_id;
        connect by prior 102 = employee_id;
        connect by prior 100 = employee_id;
        connect by prior null = employee_id; -- null 이므로 종료
    
    
        connect by prior 103 = employee_id;
        첫번째로는 사원번호 104번과 사원번호 103번을 연결시켜준다.
        끝나면 103이 start with employee_id =  에 들어온다.
        
        그 후에 사원번호 103에 있는 행의 매니저번호를 가져와서 
        manager_id에 넣어주고, 103과 102를 연결해준다.
        끝나면 102가 start with employee_id = 에 들어온다.
        
    
        102번 행의 매니저번호를 가져와서 둘을 연결시켜준다.
        끝나면 100이 start with employee_id = 에 들어온다.
    
    */
    
    
    --- *** !!! prior 다음에 나오는 manager_id 컬럼은 start with 되어지는 행의 manager_id 컬럼의 값이다. !!! *** ----

    select level
            , employee_id  AS 사원번호
            , first_name || ' ' || last_name AS 사원명
            , manager_id AS 직속결재권자
    from employees
    start with employee_id = 100    --  start with employee_id = 100 에는 manager_id가 100인 사람이 온다. 즉, 101
                                    --  manager_id가 101인 사람이 온다. 즉, 108
                                    --  109번이 manager_id인 사람은 없으므로
    connect by prior employee_id = manager_id;
    /*
        prior employee_id = manager_id;의 값은 start with 에 있는 행의 값이다.
        prior 100 = manager_id;
        ==> manager_id가 100인 사람들 ==> 나의 부하직원들
        101번과 100번이 붙는다.
        
        connect by prior 101 = manager_id;
        101을 직속상관으로 모시는 사람이 온다.
        101과 108이 연결된다.
        
        connect by prior 108 = manager_id;
        
        connect by prior 109 = manager_id; ==> 없음 / 끊어진다.
        
        
    */
    
    select *
    from employees
    where manager_id = 109; 
    --> 없음
    
    select level
            , employee_id  AS 사원번호
            , first_name || ' ' || last_name AS 사원명
            , manager_id AS 직속결재권자
    from employees
    start with employee_id = 100    
    connect by prior employee_id = manager_id
    order by level asc;

    
    --------------- ============ **** INDEX(인덱스, 색인) **** ============ ---------------
    
    /* 
       index(==색인)는 예를 들어 설명하면 아주 두꺼운 책 뒤에 나오는 "찾아보기" 와 같은 기능을 하는 것이다.
       "찾아보기" 의 특징은 정렬되어 있는 것인데 index(==색인) 에 저장된 데이터도 정렬되어 저장되어 있다는 것이 특징이다.
    */
    -- index(==색인)를 생성해서 사용하는 이유는 where 절이 있는 select 명령문의 속도를 향상 시키기 위함이다.
    -- index(==색인)은 어떤 컬럼에 만들어 할까요?
    /*
       1. where 절에서 자주 사용되어진 컬럼에 만들어야 한다.
       
       2. 선택도(selectivity)가 높은 컬럼에 만들어야 한다.
       ※ 선택도(selectivity)가 높다라는 것은 고유한 데이터일수록 선택도(selectivity)가 높아진다.
       예: 성별컬럼 --> 선택도(selectivity)가 아주 낮다. 왜냐하면 수많은 사람중 남자 아니면 여자중 하나만 골라야 하므로 선택의 여지가 아주 낮다.
           학번    --> 선택도(selectivity)가 아주 좋다. 왜냐하면 학번은 다양하고 고유하므로 골라야할 대상이 아주 많으므로 선택도가 높은 것이다.
    
       3. 카디널리티(cardinality)가 높은 컬럼에 만들어야 한다.
       ※ 카디널리티(cardinality)의 사전적인 뜻은 집합원의 갯수를 뜻하는 것으로서,
          카디널리티(cardinality)가 높다라는 것은 중복도가 낮아 고유한 데이터일수록 카디널리티(cardinality)가 상대적으로 높다 라는 것이다.
          카디널리티(cardinality)가 낮다라는 것은 중복도가 높아 중복된 데이터가 많을수록 카디널리티(cardinality)가 상대적으로 낮다 라는 것이다.
          
          카디널리티(cardinality)는 "상대적인 개념" 이다.
          예를들어, 주민등록번호 같은 경우는 중복되는 값이 없으므로 카디널리티(cardinality)가 높다고 할 수 있다.
          이에 비해 성명같은 경우는 "주민등록번호에 비해" 중복되는 값이 많으므로, 성명은 "주민등록번호에 비해" 카디널리티가 낮다고 할 수 있다.
          이와같이 카디널리티(cardinality)는 상대적인 개념으로 이해해야 한다.
    */
    
    
    create table tbl_student_1
    (hakbun     varchar2(20) not null
    ,name       varchar2(20)
    ,email      varchar2(30)
    ,address    varchar2(200)
    );
    -- Table TBL_STUDENT_1이(가) 생성되었습니다.
    
    --- *** unique 한 index 생성하기 *** ---
     /* 
        어떤 컬럼에 unique 한 index 생성하면 그 컬럼에 들어오는 값은 중복된 값은 들어올 수 없으며 오로지 고유한 값만 들어오게 된다.
        unique 한 index 가 뒤에 나오는 non-unique 한 index 보다 검색속도가 조금 더 빠르다.
     */ 
     /*
        [문법]
        create unique index 인덱스명
        on 해당테이블명(컬럼명 asc|desc);
     */    
     
    create unique index idx_tbl_student_1_hakbun
    on tbl_student_1(hakbun);    --  on tbl_student_1(hakbun asc); 기본이 asc이다. 
    -- on tbl_student_1(hakbun asc);
    -- on tbl_student_1(hakbun desc);
    -- Index IDX_TBL_STUDENT_1_HAKBUN이(가) 생성되었습니다.
        
    insert into tbl_student_1(hakbun, name, email, address) values('1', '일미자', 'ilmj@naver.com', '서울시 강동구');
    -- 1 행 이(가) 삽입되었습니다.
    insert into tbl_student_1(hakbun, name, email, address) values('1', '이미자', 'twomj@naver.com', '서울시 강서구');
        /*
            오류 보고 -
            ORA-00001: unique constraint (HR.IDX_TBL_STUDENT_1_HAKBUN) violated
        */
    insert into tbl_student_1(hakbun, name, email, address) values('2', '이미자', 'twomj@naver.com', '서울시 강서구');     
    -- 1 행 이(가) 삽입되었습니다.
    
    
    ---- **** tbl_student_1 테이블에 생성되어진 index 조회하기 **** ----
    select *
    from user_indexes
    where table_name = 'TBL_STUDENT_1';
    -- 적용된 컬럼명은 안 나온다.
    
    select *
    from user_ind_columns
    where table_name = 'TBL_STUDENT_1';
    
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	HAKBUN	ASC
    -- 이 테이블에는 유니크한 인덱스가 있는데, 어떤 컬럼에 있으며, 정렬은 어떠하다.
    -- UNIQUE INDEX로 설정된 컬럼에는 고유한 값만 와야하며, 중복은 못 들어온다.
    
    -- 학번가지고도 정보를 찾지만, 이름가지고도 정보를 찾긴 한다.
    -- 학번은 Unique index, 이름은 non-unique index
    
    
    --- *** non-unique 한 index 생성하기 *** ---
  /* 
     어떤 컬럼에 non-unique 한 index 생성하면 그 컬럼에 들어오는 값은 중복된 값이 들어올 수 있다는 것이다.
     non-unique 한 index 는 unique 한 index 보다 검색속도가 다소 늦은 편이다.
  */ 
  /*
    [문법]
    create index 인덱스명
    on 해당테이블명(컬럼명 asc|desc);
  */
  
    create index idx_tbl_student_1_name
    on tbl_student_1(name);
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 생성되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('3', '삼미자', 'threemj@naver.com', '서울시 강서구');   
    -- 1 행 이(가) 삽입되었습니다.
    insert into tbl_student_1(hakbun, name, email, address) values('4', '삼미자', 'threemj2@naver.com', '서울시 강남구');   
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    
    select *
    from tbl_student_1;
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    
    /*
        ----------------------------------------------------------------
        index_name                  uniqueness  column_name     descend
        ----------------------------------------------------------------
        IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	    HAKBUN	        ASC
        IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	NAME	        ASC 
        ----------------------------------------------------------------        
    */
    

    
    select *
    from tbl_student_1
    where hakbun = '2'; --> Unique한 인덱스 IDX_TBL_STUDENT_1_HAKBUN 를 사용하여 빠르게 조회해옴.
                        -- 내부적으로 index로 인해서 검색속도가 향상됐다.
    
    
    
    select *
    from tbl_student_1
    where name = '이미자'; --> non-Unique한 인덱스 IDX_TBL_STUDENT_1_NAME 를 사용하여 빠르게 조회해옴.
                          --> 물론 unique index가 상대적으로 더 빠르다.
                          
                          
    select *
    from tbl_student_1
    where address = '서울시 강동구';  --> address 컬럼에는 인덱스가 없으므로 tbl_student_1 테이블에 있는 모든 데이터를 조회해서
                                     --> address 컬럼의 값이 '서울시 강동구'인 데이터를 가져온다.
                                     --> 이와 같이 인덱스를 사용하지 않고 데이터를 조회해올 때를 Table Full-Scan(인덱스를 사용하지 않고 테이블 전체 조회) 이라고 부른다.
                                     --> Table Full-Scan(인덱스를 사용하지 않고 테이블 전체 조회)이 속도가 가장 느린 것이다.
                                     
    delete from tbl_student_1;  
    --4개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.
    
    -- 학번용 시퀀스
    create sequence seq_tbl_student_1 
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    -- Sequence SEQ_TBL_STUDENT_1이(가) 생성되었습니다.
    
    /*
    declare
       v_cnt  number := 1;
       v_seq  number;
       v_day  varchar2(8);
       
    begin
        loop 
           exit when v_cnt > 10000;
        
           select seq_tbl_student_1.nextval, to_char(sysdate, 'yyyymmdd') 
                  into v_seq, v_day
           from dual;
        
           insert into tbl_student_1(hakbun, name, email, address)
           values(v_day||'-'||v_seq, '이순신'||v_seq, 'leess'||v_seq||'@gmail.com', '서울시 마포구 월드컵로 '||v_seq);
           
           v_cnt := v_cnt + 1;
        end loop;
    end;
    */
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
 
   commit;
   -- 커밋 완료
   
   select *
   from tbl_student_1;
   
   select seq_tbl_student_1.currval AS 최근에사용한시퀀스값 -- 10000
   from dual;
    
   --(seq_tbl_student_1.currval + 1) 
    
   insert into tbl_student_1(hakbun, name, email, address)
   values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 1) , '배수지'||(seq_tbl_student_1.currval + 1) , 'baesuji'||(seq_tbl_student_1.currval + 1) ||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 1) );
   --               '20210728-10001'     
   
   insert into tbl_student_1(hakbun, name, email, address)
   values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 2) , '배수지'||(seq_tbl_student_1.currval + 2) , 'baesuji'||(seq_tbl_student_1.currval + 2) ||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 2) );
   --               '20210728-10002'      
   
   insert into tbl_student_1(hakbun, name, email, address)
   values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 3) , '배수지'||(seq_tbl_student_1.currval + 3) , 'baesuji'||(seq_tbl_student_1.currval + 3) ||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 3) );
    --               '20210728-10003'         
    
   commit;
   -- 커밋 완료.
   
   select count(*)
   from tbl_student_1; -- 10003
   
   select A.index_name, uniqueness, column_name, descend
   from user_indexes A join user_ind_columns B
   on A.index_name = B.index_name
   where A.table_name = 'TBL_STUDENT_1';
    
   /*
        ----------------------------------------------------------------
        index_name                  uniqueness  column_name     descend
        ----------------------------------------------------------------
        IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	    HAKBUN	        ASC
        IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	NAME	        ASC 
        ----------------------------------------------------------------       
   */   
   
    -- ==== *** SQL*Developer 에서 Plan(실행계획) 확인하는 방법 *** ==== --
    /*
      select 문이 실행될 때 인덱스를 사용하여 데이터를 얻어오는지 인덱스를 사용하지 않고 
      Table Full Scan 하여 얻어오는지 알아봐야 한다.
      이럴때 사용하는 것이 SQL Plan(실행계획)이다. 
      
      SQL*Developer 에서는 "SQL편집창(SQL 워크시트)"에 Plan(실행계획) 과 Trace(자동추적) 메뉴가 상단에 있다.
      
      Plan(실행계획) 과 Trace(자동추적) 의 차이는,
      Plan(실행계획) 은 SQL을 실행하기 전에 Oracle Optimizer(옵티마이저, 최적화기)가 SQL을 어떻게 실행할지를 미리 알려주는 것이고,
      Trace(자동추적) 는 SQL을 실행해보고, Oracle Optimizer(옵티마이저, 최적화기)가 SQL을 어떻게 실행했는지 그 결과를 알려주는 것이다.

      그러므로, 정확도로 말하자면, Trace(자동추적)가 Plan(실행계획) 보다 훨씬 정확한 것이다.
      Plan(실행계획) 은 말그대로 계획이라서 Oracle Optimizer가 계획은 그렇게 세우긴 했으나 
      실제 실행할때는 여러가지 이유로 다르게 실행할 수도 있기 때문이다.
      그래서 Trace(자동추적)가 정확하기는 하나 Trace(자동추적)는 한번 실행해봐야 하는것이라서 
      시간이 오래 걸리는 SQL인 경우에는 한참 기다려야 하는 단점이 있기는 하다.
   */       
   
   
      /* 
      실행해야할 SQL문을 블럭으로 잡은 후에
      "SQL 워크시트" 의 상단 아이콘들중에 3번째 아이콘( 계획 설명... (F10) )을 클릭하면 현재 SQL의 Plan(실행계획)을 아래에 보여준다.
      COST(비용)의 값이 적을 수록 속도가 빠른 것이다.
   */
   
   
   
    select *
    from tbl_student_1
    where hakbun = '20210728-6789';  --> unique한 인덱스 IDX_TBL_STUDENT_1_HAKBUN 를 사용하여 빠르게 조회해온다.
   
    
    select *
    from tbl_student_1
    where name = '이순신5783';        --> non-unique한 인덱스 IDX_TBL_STUDENT_1_NAME 를 사용하여 빠르게 조회해옴
                        
                                           
    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 3987';  --> address 컬럼에는 인덱스가 없으므로 tbl_student_1 테이블에 있는 모든 데이터를 조회해서
                                                 --> address 컬럼의 값이 '서울시 마포구 월드컵로 3987'인 데이터를 가져온다.
                                                 --> 이와 같이 인덱스를 사용하지 않고 데이터를 조회해올 때를 Table Full-Scan(인덱스를 사용하지 않고 테이블 전체 조회) 이라고 부른다.
                                                 --> Table Full-Scan(인덱스를 사용하지 않고 테이블 전체 조회)이 속도가 가장 느린 것이다.
    
    
    select *
    from tbl_student_1
    where email = 'leess2654@gmail.com'; -- email 컬럼에는 인덱스가 없으므로 Table Full-Scan(인덱스를 사용하지 않고 테이블 전체 조회)하여 조회해 오는 것임.
    
    -- 똑같이 한 행만 읽어오는 것이지만, COST가 서로 다르다. (인덱스 사용 유/무 에 따라서)
    -- Unique한 INDEX가 속도가 가장 빠르며, 그 다음은 non-Unique한 INDEX, 제일 느린건 Table Full-Scan이다.
    
    
    -----------------------------------------------------------------------------------------------------------
    -- *** Trace(자동추적)을 하기 위해서는 SYS 또는 SYSTEM 으로 부터 권한을 부여 받은 후 HR은 재접속을 해야 한다. *** --
    show user;
    -- USER이(가) "SYS"입니다.
    
    grant SELECT_CATALOG_ROLE to HR;
    -- Grant을(를) 성공했습니다.
    
    grant SELECT ANY DICTIONARY to HR;
    -- Grant을(를) 성공했습니다.
    -----------------------------------------------------------------------------------------------------------   

    /* 
      실행해야할 SQL문을 블럭으로 잡은 후에
      "SQL 워크시트" 의 상단 아이콘들중에 4번째 아이콘( 자동 추적... (F6) )을 클릭하면 현재 SQL의 Trace(자동추적)을 아래에 보여준다.
      
      Trace(자동추적)을 하면 Plan(실행계획) 도 나오고, 동시에 아래쪽에 통계정보도 같이 나온다.

      오른쪽에 Plan(실행계획)에서는 보이지 않던 LAST_CR_BUFFER_GETS 와 LAST_ELAPSED_TIME 컬럼이 나온다.
      LAST_CR_BUFFER_GETS 는 SQL을 실행하면서 각 단계에서 읽어온 블록(Block) 갯수를 말하는 것이고,
      LAST_ELAPSED_TIME 은 경과시간 정보이다.
      즉, 이 정보를 통해서 어느 구간에서 시간이 많이 걸렸는지를 확인할 수 있으므로, 이 부분의 값이 적게 나오도록 SQL 튜닝을 하게 된다.
    */     
      
    
    
    
    ---- *** DML(insert, update, delete)이 빈번하게 발생하는 테이블에 index가 생성되어 있으면
    ---      DML(insert, update, delete) 작업으로 인해 Index 에 나쁜 결과를 초래하므로  
    ---      index 가 많다고 해서 결코 좋은 것이 아니기에 테이블당 index 의 개수는 최소한의 개수로 만드는 것이 좋다.
    
    ---- *** index 가 생성되어진 테이블에 insert 를 하면 Index Split(인덱스 쪼개짐) 가 발생하므로
    ----     index 가 없을시 보다 insert 의 속도가 떨어지게 된다.
    ----     그러므로 index 가 많다고 결코 좋은 것이 아니므로 최소한의 개수로 index 를 만드는 것이 좋다.
    ----     Index Split(인덱스 쪼개짐)란 Index 의 block(블럭)들이 1개에서 2개로 나뉘어지는 현상을 말한다.
    ----     Index Split(인덱스 쪼개짐)이 발생하는 이유는 Index 는 정렬이 되어 저장되기 때문에 
    ---      Index 의 마지막 부분에 추가되는 것이 아니라 정렬로 인해 중간 자리에 끼워들어가는 현상이
    ----     발생할 수 있기 때문이다. 
    
    
    ---- *** index 가 생성되어진 테이블에 delete 를 하면 테이블의 데이터는 삭제가 되어지지만 
    ----     Index 자리에는 데이터는 삭제되지 않고서 사용을 안한다는 표시만 하게 된다.
    ----     그래서 10만 건이 들어있던 테이블에 9만건의 데이터를 delete 를 하면 테이블에는 데이터가 삭제되어 지지만
    ----     Index 자리에는 10만 건의 정보가 그대로 있고 1만건만 사용하고 9만건은 사용되지 않은채로 되어있기에
    ----     사용하지 않는 9만건의 Index 정보로 인해서 index를 사용해서 select를 해올 때 index 검색속도가 떨어지게 된다.   
    ----     이러한 경우 Index Rebuild 작업을 해주어 사용하지 않는 9만건의 index 정보를 삭제해주어야만 
    ----     select를 해올 때 index 검색속도가 빨라지게 된다. 
    
    
    ---- *** index 가 생성되어진 테이블에 update 를 하면 테이블의 데이터는 "수정" 되어지지만 
    ----     Index 는 "수정" 이라는 작업은 없고 index 를 delete 를 하고 새로이 insert 를 해준다.
    ----     그러므로 index 를 delete 할 때 발생하는 단점 및 index 를 insert 를 할 때 발생하는 Index Split(인덱스 쪼개짐) 가 발생하므로
    ----     Index 에는 최악의 상황을 맞게 된다. 
    ----     이로 인해 테이블의 데이터를 update를 빈번하게 발생시켜 버리면 select를 해올 때 index 검색속도가 현저히 느려지게 된다. 
    ----     이러한 경우도 select를 해올 때 index 검색속도가 빨라지게끔 Index Rebuild 작업을 해주어야 한다.  
    
    
    ---- **** Index(인덱스)의 상태 확인하기 **** ----
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';  
    /*
        인덱스상태(Balance)
        -----------------
             0
        
        인덱스의 값이 0에 가까울 수록 인덱스 상태가 좋은 것이다.
    */
    
    
    
    select count(*)
    from tbl_student_1; 
    -- 10003
    
    delete from tbl_student_1
    where hakbun between '20210728-400' and '20210728-9400';
    -- 6,001개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select count(*)
    from tbl_student_1; 
    -- 4002
 
 
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';  
    /*
        인덱스상태(Balance)
        -----------------
             0
        
        인덱스의 값이 0에 가까울 수록 인덱스 상태가 좋은 것이다.
        -- delete 하기 전의 index 를 분석한 것이므로 계속해서 똑같은 값이 나온다.
        -- 다시 분석해야 최신값이 반영된다.
    */   
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';  
    /*
        인덱스상태(Balance)
        -----------------
             61.00796586616561955649501888712739514219
        
        delete를 한 이후에 다시 분석해서 나온 값이다.
        index 밸런스가 대략 61% 정도가 깨진 것이다.
    */      
    
    update tbl_student_1 set name = '홍길동'
    where hakbun between '20210728-9400' and '20210728-9901';
    -- 556개 행 이(가) 업데이트되었습니다.
    
    commit;
    
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';  
    /*
        인덱스상태(Balance)
        -----------------
            62.31077453839430061031738050852046381027
        
        delete를 한 이후에 다시 분석해서 나온 값이다.
        index 밸런스가 대략 62% 정도가 깨진 것이다.
    */          
    
    
    ----- **** ==== Index Rebuild(인덱스 재건축) 하기 ==== **** -----
    -- 인덱스 밸런스가 대략 62% 정도 깨진 IDX_TBL_STUDENT_1_NAME 을 Index Rebuild(인덱스 재건축) 하기
    
    alter index IDX_TBL_STUDENT_1_NAME rebuild;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 변경되었습니다.
    
    
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';  
    /*
        인덱스상태(Balance)
        -----------------
               0
   인덱스의 값이 0에 가까울 수록 인덱스 상태가 좋은 것이다.
        
    */          
    
   

   
    ---- **** index 삭제하기 **** ----
    ---- drop index 인덱스명;
    
   select A.index_name, uniqueness, column_name, descend
   from user_indexes A join user_ind_columns B
   on A.index_name = B.index_name
   where A.table_name = 'TBL_STUDENT_1';    
    
    
    drop index IDX_TBL_STUDENT_1_NAME;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 삭제되었습니다.
    
    drop index IDX_TBL_STUDENT_1_HAKBUN;
    -- Index IDX_TBL_STUDENT_1_HAKBUN이(가) 삭제되었습니다.
    
    
    -- 07월 29일 오전수업
    ------- **** !!!!!! 복합인덱스(Composite Index) 생성하기 !!!!! **** -------
    
    -- 복합인덱스(composite index)란? 
    -- 2개 이상의 컬럼으로 묶어진 인덱스를 말하는 것으로서
    -- where 절에 2개의 컬럼이 사용될 경우 각각 1개 컬럼마다 각각의 인덱스를 만들어서 사용하는 것보다
    -- 2개의 컬럼을 묶어서 하나의 인덱스로 만들어 사용하는 것이 속도가 좀 더 빠르다.   
    
    
    select * 
    from tbl_student_1
    where name like '배수지10001' and address = '서울시 마포구 월드컵로 10001';
    
    
    
    -- !!!!  중요  !!!! --
    -- 복합인덱스(composite index) 생성시 중요한 것은 선행컬럼을 정하는 것이다.
    -- 선행컬럼은 맨처음에 나오는 것으로 아래에서는 name 이 선행컬럼이 된다.
    -- 복합인덱스(composite index)로 사용되는 컬럼중 선행컬럼으로 선정되는 기준은 where 절에 가장 많이 사용되는 것이며 
    -- 선택도(selectivity)가 높은 컬럼이 선행컬럼으로 선정되어야 한다.    
    
    create index idex_tbl_student_1_name_add
    on tbl_student_1(name, address);    -- name 컬럼이 선행컬럼이 된다.
--  Index IDEX_TBL_STUDENT_1_NAME_ADD이(가) 생성되었습니다.    
    
--  create index idex_tbl_student_1_name_add
--  on tbl_student_1(address, name);    -- address 컬럼이 선행컬럼이 된다.


    select A.index_name, uniqueness, column_name, descend, B.column_position
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- user_ind_columns 의 column_position은 선행컬럼이 무엇인지 알려준다.
    
    /*
        --------------------------------------------------------------------------------------
        index_name                  uniqueness  column_name     descend     column_position
        --------------------------------------------------------------------------------------
        IDEX_TBL_STUDENT_1_NAME_ADD	NONUNIQUE	ADDRESS	        ASC	                2
        IDEX_TBL_STUDENT_1_NAME_ADD	NONUNIQUE	NAME	        ASC	                1 (숫자 1이 선행컬럼)
    
    */
    
    
    select * 
    from tbl_student_1
    where name like '배수지10001' and address = '서울시 마포구 월드컵로 10001';
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(Composite Index)인 
    -- IDEX_TBL_STUDENT_1_NAME_ADD 을 사용하여 빨리 조회해온다.
    
    
    select * 
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 10001' and name = '배수지10001'; 
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(Composite Index)인 
    -- IDEX_TBL_STUDENT_1_NAME_ADD 을 사용하여 빨리 조회해온다.
    
    
    select * 
    from tbl_student_1
    where name = '배수지10001'; 
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(Composite Index)인 
    -- IDEX_TBL_STUDENT_1_NAME_ADD 을 사용하여 빨리 조회해온다.
    
    
    select * 
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 10001';    
    -- 선행컬럼이 where 절에 없으면 무조건 Table Full Scan을 한다.
    -- 선행컬럼이 없으면 복합인덱스(Composite Index)를 사용하지 못해서 조회속도가 떨어진다.

    
    
    
    
    create table tbl_member 
    (userid         varchar2(20)
    ,passwd         varchar2(30)    NOT NULL
    ,name           varchar2(20)    NOT NULL
    ,address        varchar2(100)
    ,email          varchar2(50)    NOT NULL
    ,constraint     PK_tbl_member_userid primary key(userid)    -- Unique한 index가 자동생성
    ,constraint     UQ_tbl_member_email  unique(email)          -- Unique한 index가 자동생성
    );
    -- Table TBL_MEMEBER이(가) 생성되었습니다.
    
    declare -- 변수 선언
        v_cnt   number := 1; -- 반복횟수 측정용, 초기치는 := 로 넣는다.
    begin
        loop
            exit when v_cnt > 10000;       -- Java의 break와 같다. 10001이 되어지면 반복문 종료
            
            insert into tbl_member(userid, passwd, name, address, email)
            values('hongkd'||v_cnt, 'qwer1234$', '홍길동'||v_cnt, '서울시 마포구 '||v_cnt, 'hongkd'||v_cnt||'@gmail.com');
            
            v_cnt := v_cnt +1;
        end loop;
    end;
    
    commit;
    -- 커밋 완료.
    
    
    select *
    from tbl_member;
    
    
    -- 로그인을 하는데 로그인이 성공되어지면 그 회원의 성명만을 보여주도록 한다.
    select name
    from tbl_member
    where userid = 'hongkd201' and passwd = 'qwer1234$';
    
    
    --- **** userid, passwd, name 컬럼을 가지고 복합인덱스(Composite Index)를 생성해 봅니다. **** ---
    create index idx_tbl_member_id_pwd_name
    on tbl_member(userid, passwd, name);
    -- Index IDX_TBL_MEMBER_ID_PWD_NAME이(가) 생성되었습니다.
    
    
    select name
    from tbl_member
    where userid = 'hongkd201' and passwd = 'qwer1234$';
    -- 테이블은 읽지 않고, 인덱스만 읽어서 COST가 엄청 떨어진다.
    -- 자동추적에서도 버퍼수가 작아진다.
    -- select한 컬럼도 name이여서 굳이 테이블에 안 가고 인덱스에 가면 찾고자 하는 정보가 다 있어서 조회속도가 향상된다.
    
    -- where 절 및 select 에 복합인덱스(Composite Index)인 IDX_TBL_MEMBER_ID_PWD_NAME 에 사용되어진 컬럼만 있어서 
    -- 테이블 tbl_member 에는 접근하지 않고 인덱스 IDX_TBL_MEMBER_ID_PWD_NAME 에만 접근해서 조회하므로 속도가 빠르다.
    
    
    select name, address
    from tbl_member
    where userid = 'hongkd201' and passwd = 'qwer1234$';
    -- where 절에 userid 및 passwd가 사용되었으므로 복합인덱스(Composite Index)인 IDX_TBL_MEMBER_ID_PWD_NAME 을 사용하는데
    -- select 절에 복합인덱스에 없는 address 컬럼이 있어서 테이블 tbl_member 에는 접근해야 한다.
    -- 그래서 인덱스 IDX_TBL_MEMBER_ID_PWD_NAME 만 접근하는 것 보다는 조회 속도가 조금 떨어진다. 
    
    drop index IDX_TBL_MEMBER_ID_PWD_NAME;
    -- Index IDX_TBL_MEMBER_ID_PWD_NAME이(가) 삭제되었습니다.
    -- 다음 실습을 위해 삭제
    
    
    
    
    ------- **** 함수기반 인덱스(Function based Index) 생성하기 **** -------
    drop index IDEX_TBL_STUDENT_1_NAME_ADD;
    -- Index IDEX_TBL_STUDENT_1_NAME_ADD이(가) 삭제되었습니다.
    
    
    
    select *
    from tbl_student_1
    where name = '배수지10002';
    
    create index idx_tbl_student_1_name
    on tbl_student_1(name);
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 생성되었습니다.
    
    select A.index_name, uniqueness, column_name, descend, B.column_position
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';    
    
    select *
    from tbl_student_1
    where name = '배수지10002'; 
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하여 조회해온다.
    
    select *
    from tbl_student_1
    where substr(name, 2, 2) = '수지';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하지 않고 Table Full Scan 하여 조회해온다.
    
    
    create index idx_func_tbl_student_1_name
    on tbl_student_1( substr(name, 2, 2) ); -- 함수기반 인덱스(Function based Index) 생성
    -- Index IDX_FUNC_TBL_STUDENT_1_NAME이(가) 생성되었습니다.
    
    select *
    from tbl_student_1
    where substr(name, 2, 2) = '수지';   
    -- 함수기반 인덱스인 IDX_FUNC_TBL_STUDENT_1_NAME 을 사용하여 조회해온다.
    
    
    drop index IDX_FUNC_TBL_STUDENT_1_NAME;
    -- Index IDX_FUNC_TBL_STUDENT_1_NAME이(가) 삭제되었습니다.
    
    
    
    
    select *
    from tbl_student_1
    where name = '배수지10002';     
    -- 인덱스 IDX_TBL_STUDENT_1_NAME 을 사용하여 조회해온다.
    
    select *
    from tbl_student_1
    where name like '배수지10002';     
    -- 인덱스 IDX_TBL_STUDENT_1_NAME 을 사용하여 조회해온다.
    
    select *
    from tbl_student_1
    where name like '배수지%';        
    -- 인덱스 IDX_TBL_STUDENT_1_NAME 을 사용하여 조회해온다.
     
    select *
    from tbl_student_1
    where name like '%배수지%';
    -- 맨 앞에 % 또는 _ 가 나오면  Table Full Scan 하여 조회해온다.
    -- 인덱스 IDX_TBL_STUDENT_1_NAME 을 사용하지 않는다.
    
    
    ------- **** 어떤 테이블의 어떤 컬럼에 Primary Key 제약 또는 Unique 제약을 주면 **** -------
    --          자동적으로 그 컬럼에는 unique 한 index가 생성되어진다.
    --          인덱스명은 제약조건명이 된다. ****
    
    create table tbl_student_2
    (hakbun      varchar2(10) 
    ,name        varchar2(20)
    ,email       varchar2(20) not null
    ,address     varchar2(20)
    ,constraint PK_tbl_student_2_hakbun primary key(hakbun)
    ,constraint UQ_tbl_student_2_email unique(email)
    );    
    -- Table TBL_STUDENT_2이(가) 생성되었습니다.
    
    
   select A.index_name, uniqueness, column_name, descend
   from user_indexes A join user_ind_columns B
   on A.index_name = B.index_name
   where A.table_name = 'TBL_STUDENT_2'; 
   -- 인덱스를 따로 만들지 않았지만, Primary Key나 Unique 제약조건을 생성함과 동시에 Unique한 인덱스들이 생성됐다.
   -- 인덱스명은 제약조건명과 똑같이 만들어진다.
   
   
    -- Primary Key 제약 또는 Unique 제약으로 생성되어진 index 의 제거는 
    -- drop index index명; 이 아니라
    -- alter table 테이블명 drop constraint 제약조건명; 이다.
    -- 제약조건을 삭제하면 자동적으로 index 도 삭제가 된다.   
    
    
    drop index PK_TBL_STUDENT_2_HAKBUN;
    /*
        오류 보고 -
        ORA-02429: cannot drop index used for enforcement of unique/primary key
    */
    
    -- 제약조건으로 만들어진 인덱스는 이렇게 drop으로는 못 지운다.
    
    drop index UQ_TBL_STUDENT_2_EMAIL;    
    -- ORA-02429: cannot drop index used for enforcement of unique/primary key
    
    /*
        alter table tbl_student_2
        drop constraint PK_TBL_STUDENT_2_HAKBUN;
    */
    
    -- 또는 아래와 같이 한다.
    
    alter table tbl_student_2
    drop Primary Key;
    -- Table TBL_STUDENT_2이(가) 변경되었습니다.
    
    
   select constraint_name, constraint_type, search_condition, status
   from user_constraints
   where table_name = 'TBL_STUDENT_2';        

    
   select A.index_name, uniqueness, column_name, descend
   from user_indexes A join user_ind_columns B
   on A.index_name = B.index_name
   where A.table_name = 'TBL_STUDENT_2';
   -- 자동적으로 PK_TBL_STUDENT_2_HAKBUN 인덱스는  삭제됐다.
    
    
    alter table tbl_student_2
    drop constraint UQ_TBL_STUDENT_2_EMAIL; 
    -- Table TBL_STUDENT_2이(가) 변경되었습니다.
    
    
   select constraint_name, constraint_type, search_condition, status
   from user_constraints
   where table_name = 'TBL_STUDENT_2';
   
   select A.index_name, uniqueness, column_name, descend
   from user_indexes A join user_ind_columns B
   on A.index_name = B.index_name
   where A.table_name = 'TBL_STUDENT_2';   
   
   
   
   ---------- ========== **** 데이터 사전(Data Dictionary) **** ========== ----------
   
   ---- **** ORACLE DATA DICTIONARY VIEW(오라클 데이터 사전 뷰) **** ----    
   
   show user;
   -- USER이(가) "HR"입니다.
   
   select *
   from dictionary;
   -- 또는
   
   select *
   from dict;  
   /*
    USER_CONS_COLUMNS
    ALL_CONS_COLUMNS
   */
   
   
   -- ========= SYS로 접속한 것 ======== --
   show user;
   -- USER이(가) "SYS"입니다.
   

   select *
   from dictionary;
   -- 또는
   
   select *
   from dict;  
   
   /*
    USER_CONS_COLUMNS
    ALL_CONS_COLUMNS
    DBA_CONS_COLUMNS
   */  
   
   /*
     DBA_로 시작하는 것 
     ==> 관리자만 조회가능한 것으로 모든오라클사용자정보, 모든테이블, 모든인덱스, 모든데이터베이스링크 등등등 의 정보가 다 들어있는 것.
     
     USER_로 시작하는 것 
     ==> 오라클서버에 접속한 사용자 소유의 자신의오라클사용자정보, 자신이만든테이블, 자신이만든인덱스, 자신이만든데이터베이스링크 등등등 의 정보가 다 들어있는 것.
     
     ALL_로 시작하는 것 
     ==> 오라클서버에 접속한 사용자 소유의 즉, 자신의오라클사용자정보, 자신이만든테이블, 자신이만든인덱스, 자신이만든데이터베이스링크 등등등 의 정보가 다 들어있는 것
         과(와)
         자신의 것은 아니지만 조회가 가능한 다른사용자의오라클사용자정보, 다른사용자소유의테이블, 다른사용자소유의인덱스, 다른사용자소유의데이터베이스링크 등등등 의 정보가 다 들어있는 것. 
  */  
   


   
    select *
    from dba_tables;
    
    select *
    from dba_tables
    where owner in ('HR','ORAUSER1');
   
   
   
   -- ========= SYS로 접속 끝 ======== --
   
   
    select *
    from user_tables;
    
    select *
    from ALL_tables;   
    
    -- *** 자신이 만든 테이블에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%table%';
    --> 무슨 테이블로 조회해야 하는지 알려준다.
    
    select *
    from USER_TABLES;
   
    ---- **** USER_TABLES 에서 보여지는 컬럼에 대한 설명을 보고 싶으면 아래와 같이하면 됩니다. **** ----
    
    select *
    from dict_columns
    where table_name = 'USER_TABLES';
    
    -- *** 자신이 만든 테이블의 컬럼에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%column%';
    --> 무슨 테이블로 조회해야 하는지 알려준다.
    
    select *
    from USER_TAB_COLUMNS;
    
    select *
    from USER_TAB_COLUMNS
    where table_name = 'EMPLOYEES';
    
    ---- **** USER_TAB_COLUMNS 에서 보여지는 컬럼에 대한 설명을 보고 싶으면 아래와 같이하면 됩니다. **** ----
    
    select *
    from dict_columns
    where table_name = 'USER_TAB_COLUMNS';
    
    -- *** 자신이 만든 테이블의 제약조건에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%constraint%';
    --> 무슨 테이블로 조회해야 하는지 알려준다.

    select *
    from USER_CONSTRAINTS
    where table_name = 'EMPLOYEES';
    
    
    select constraint_name, column_name, position
    from USER_CONS_COLUMNS
    where table_name = 'EMPLOYEES';
    
    -- *** 자신이 만든 데이터베이스 링크에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---    
        
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%database link%';
    --> 무슨 테이블로 조회해야 하는지 알려준다.
        
    select *
    from USER_DB_LINKS;
    
    -- *** 자신이 만든 시퀀스에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---        
    
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%sequence%';
    --> 무슨 테이블로 조회해야 하는지 알려준다.
    
    select *
    from USER_SEQUENCES;
    
    -- *** 자신이 만든 인덱스에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---   
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%index%'; 
    --> 무슨 테이블로 조회해야 하는지 알려준다.
    
    select *
    from USER_INDEXES
    where table_name = 'EMPLOYEES';
    
    
    select *
    from USER_IND_COLUMNS
    where table_name = 'EMPLOYEES';
    
    
    -- *** 자신이 만든 테이블 'tbl_board_test_1' 에서 어떤 컬럼에 default 값을 부여했는지 조회하고 싶다. 어디서 보면 될까요? *** ---  
    select *
    from tbl_board_test_1;
    
    select *
    from USER_TAB_COLS
    where table_name = 'TBL_BOARD_TEST_1';
    
    select column_name, data_default
    from USER_TAB_COLS
    where table_name = 'TBL_BOARD_TEST_1';
    
    
    select *
    from dict
    where table_name like 'USER_%' and lower(comments) like '%column%'; 
    
    -- default 값 변경하기 --    
    alter table tbl_board_test_1
    modify REGISTERDATE default sysdate + 1;
    -- Table TBL_BOARD_TEST_1이(가) 변경되었습니다.

    -- default 값 삭제하기 -- 
    alter table tbl_board_test_1
    modify REGISTERDATE default null;
    -- Table TBL_BOARD_TEST_1이(가) 변경되었습니다.
    
    alter table tbl_board_test_1
    modify REGISTERDATE default sysdate;
    -- Table TBL_BOARD_TEST_1이(가) 변경되었습니다.
    
    
    
    
    
    
    
    
    
    
    --------------------------------------------------------------------------------------------------------
                        --- *** PL/SQL(Proceduer Language / Structured Query Language) *** ---
                        
    
    ---- **** PL/SQL 구문에서 변수의 사용법 **** ----
    
    exec pcd_empInfo(101);
    /*
        <결과물>
        --------------------------------------------
        사원번호    사원명     성별      월급
        --------------------------------------------
        101       ....      ...      ...
    
    
    */
    

    
    exec pcd_empInfo(103);
    /*
        <결과물>
        --------------------------------------------
        사원번호    사원명     성별      월급
        --------------------------------------------
        103       ....      ...      ...
    
    
    */    
    
    select lpad('-', 40, '-')
    from dual;
    
    create or replace procedure pcd_empInfo
    (p_employeeid IN number) -- 파라미터 설정
                             -- IN 은 입력모드를 말한다.
                             -- number(3) 과 같이 자리수를 넣어주면 오류가 난다.
    is
        -- 변수의 선언부
        v_employee_id number(5);    -- is 다음에 변수의 선언부는 자리수를 넣어줘야 한다.
        v_ename       varchar2(50);
        v_gender      varchar2(10);
        v_monthsal    varchar2(15);
    
    begin
            -- 실행부
    
        select employee_id
             , first_name || ' ' || last_name
             , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end
             , to_char(nvl(salary + (salary * commission_pct), salary), '$9,999,999')
             INTO
             v_employee_id, v_ename, v_gender, v_monthsal   -- select 되어진 정보들은 변수에 담아야 한다.
        from employees
        where employee_id = p_employeeid;
        
        -- 조회한 정보를 출력해줘야 한다.
        dbms_output.put_line( lpad('-', 40, '-') ); -- java의 system.out.println과 비슷하다.
        dbms_output.put_line('사원번호    사원명     성별      월급');
        dbms_output.put_line( lpad('-', 40, '-') );
        
        dbms_output.put_line(v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal);
    
    end pcd_empInfo;
    -- Procedure PCD_EMPINFO이(가) 컴파일되었습니다.
    
    
    /* === SQL Developer 의 메뉴의 보기를 클릭하여 DBMS 출력을 클릭해주어야 한다. ===
     === 이어서 하단부에 나오는 DBMS 출력 부분의 녹색 + 기호를 클릭하여 local_hr 로 연결을 해준다. === 
    */
    
    exec pcd_empInfo(101);
    /*
        ----------------------------------------
        사원번호    사원명     성별      월급
        ----------------------------------------
        101 Neena Kochhar 남     $17,000
    */
    
    exec pcd_empInfo(103);
    
    /*
        ----------------------------------------
        사원번호    사원명     성별      월급
        ----------------------------------------
        103 Alexander Hunold 남      $9,000
    */
    
    
    
    create or replace procedure pcd_empInfo
    (p_employeeid IN number) -- 파라미터 설정
                             -- IN 은 입력모드를 말한다.
                             -- number(3) 과 같이 자리수를 넣어주면 오류가 난다.
    is
        -- 변수의 선언부
        v_employee_id number(5);    -- is 다음에 변수의 선언부는 자리수를 넣어줘야 한다.
        v_ename       varchar2(50);
        v_gender      varchar2(10);
        v_monthsal    varchar2(15);
        v_age         number(3);
    
    begin
            -- 실행부
    
        select employee_id
             , first_name || ' ' || last_name
             , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end
             , to_char(nvl(salary + (salary * commission_pct), salary), '$9,999,999')
             , extract(year from sysdate) - ( case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2)) ) + 1
             INTO
             v_employee_id, v_ename, v_gender, v_monthsal, v_age   -- select 되어진 정보들은 반드시 변수에 담아야 한다.
        from employees
        where employee_id = p_employeeid;
        
        -- 조회한 정보를 출력해줘야 한다.
        dbms_output.put_line( lpad('-', 50, '-') ); -- java의 system.out.println과 비슷하다.
        dbms_output.put_line('사원번호    사원명     성별      월급    나이');
        dbms_output.put_line( lpad('-', 50, '-') );
        
        dbms_output.put_line(v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal ||' ' || v_age);
    
    end pcd_empInfo;    
    
    exec pcd_empInfo(104);
    /*
        --------------------------------------------------
        사원번호    사원명     성별      월급    나이
        --------------------------------------------------
        104 Bruce Ernst 여      $6,000 61
    */
    
    
    ------------ ***** 생성되어진 프로시저의 소스를 조회해봅시다. ***** ------------
    
    select LINE, TEXT
    from user_source
    where type = 'PROCEDURE' and name = 'PCD_EMPINFO';
    
/*
"procedure pcd_empInfo
"
"    (p_employeeid IN number) -- 파라미터 설정
"
"                             -- IN 은 입력모드를 말한다.
"
"                             -- number(3) 과 같이 자리수를 넣어주면 오류가 난다.
"
"    is
"
"        -- 변수의 선언부
"
"        v_employee_id number(5);    -- is 다음에 변수의 선언부는 자리수를 넣어줘야 한다.
"
"        v_ename       varchar2(50);
"
"        v_gender      varchar2(10);
"
"        v_monthsal    varchar2(15);
"
"        v_age         number(3);
"
"
"
"    begin
"
"            -- 실행부
"
"
"
"        select employee_id
"
"             , first_name || ' ' || last_name
"
"             , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end
"
"             , to_char(nvl(salary + (salary * commission_pct), salary), '$9,999,999')
"
"             , extract(year from sysdate) - ( case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2)) ) + 1
"
"             INTO
"
"             v_employee_id, v_ename, v_gender, v_monthsal, v_age   -- select 되어진 정보들은 반드시 변수에 담아야 한다.
"
"        from employees
"
"        where employee_id = p_employeeid;
"
"
"
"        -- 조회한 정보를 출력해줘야 한다.
"
"        dbms_output.put_line( lpad('-', 50, '-') ); -- java의 system.out.println과 비슷하다.
"
"        dbms_output.put_line('사원번호    사원명     성별      월급    나이');
"
"        dbms_output.put_line( lpad('-', 50, '-') );
"
"
"
"        dbms_output.put_line(v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal ||' ' || v_age);
"
"
"
    end pcd_empInfo;



*/
    
    
    create or replace procedure pcd_empInfo_2
    (p_employeeid IN employees.employee_id%type) -- p_employeeid 변수의 타입은 employees 테이블에 있는 employee_id 컬럼의 데이터타입과 동일하게 쓰겠다는 말이다. 
                             
    is
        -- 변수의 선언부
        v_employee_id employees.employee_id%type;    
        v_ename       varchar2(50);
        v_gender      varchar2(10);
        v_monthsal    varchar2(15);
        v_age         number(3);
    
    begin
            -- 실행부
    
        select employee_id
             , first_name || ' ' || last_name
             , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end
             , to_char(nvl(salary + (salary * commission_pct), salary), '$9,999,999')
             , extract(year from sysdate) - ( case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2)) ) + 1
             INTO
             v_employee_id, v_ename, v_gender, v_monthsal, v_age   -- select 되어진 정보들은 반드시 변수에 담아야 한다.
        from employees
        where employee_id = p_employeeid;
        
        -- 조회한 정보를 출력해줘야 한다.
        dbms_output.put_line( lpad('-', 50, '-') ); -- java의 system.out.println과 비슷하다.
        dbms_output.put_line('사원번호    사원명     성별      월급    나이');
        dbms_output.put_line( lpad('-', 50, '-') );
        
        dbms_output.put_line(v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal ||' ' || v_age);
    
    end pcd_empInfo_2;  
    -- Procedure PCD_EMPINFO_2이(가) 컴파일되었습니다.
    
    exec pcd_empInfo_2(105);
    /*
        --------------------------------------------------
        사원번호    사원명     성별      월급    나이
        --------------------------------------------------
        105 David Austin 남      $4,800 57
    */
    
    

    
    
    
    
    
    
    
     create or replace procedure pcd_empInfo_3
    (p_employeeid IN employees.employee_id%type) 
    is
       --- record 타입 생성 ---
       type myEmpType is record
       (employee_id   employees.employee_id%type     
       ,ename         varchar2(50)   
       ,gender        varchar2(10) 
       ,monthsal      varchar2(15)
       ,age           number(3)
       );
       
       v_rcd  myEmpType; 
       
    begin
       select employee_id, first_name || ' ' || last_name,
              case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end,
              to_char( nvl(salary + salary * commission_pct, salary), '$9,999,999'),
              extract(year from sysdate) - ( case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun, 1, 2)) ) + 1 
              INTO
              v_rcd
       from employees
       where employee_id = p_employeeid;
       
       dbms_output.put_line( lpad('-', 50, '-') );
       dbms_output.put_line('사원번호    사원명    성별    월급    나이');
       dbms_output.put_line( lpad('-', 50, '-') );
       
       dbms_output.put_line( v_rcd.employee_id || ' ' || v_rcd.ename || ' ' || v_rcd.gender || ' ' || v_rcd.monthsal || ' ' || v_rcd.age); 
    
    end pcd_empInfo_3;  
    -- Procedure PCD_EMPINFO_3이(가) 컴파일되었습니다.
    
    exec pcd_empInfo_3(106);
    
    
    
    /*
    
    --------------------------------------------------
    사원번호    사원명    성별    월급    나이
    --------------------------------------------------
    106 Valli Pataballa 남      $4,800 62
    
    */
    
    
    create or replace procedure pcd_empInfo_4
    (p_employeeid IN employees.employee_id%type) 
    is
        v_all       employees%rowtype;  -- v_all 변수의 타입은 employees 테이블의 모든 컬럼을 받아주는 행타입이다.
        v_result    varchar2(1000); -- V_all에서 추출한 컬럼들을 다시 이곳에 모두 넣는다.
       
    begin
        select *
            into v_all
        from employees
        where employee_id = p_employeeid;  
       
        v_result := v_all.employee_id || ' ' || 
                    v_all.first_name || ' ' ||  v_all.last_name || ' ' ||
                    case when substr(v_all.jubun, 7, 1) in('1','3') then '남' else '여' end || ' ' ||
                    to_char( nvl(v_all.salary + v_all.salary * v_all.commission_pct, v_all.salary), '$9,999,999') || ' ' ||
                    
                    ( extract(year from sysdate) - ( case when substr(v_all.jubun, 7, 1) in('1','2') then 1900 else 2000 end + to_number(substr(v_all.jubun, 1, 2)) ) + 1 );
             
       
       dbms_output.put_line( lpad('-', 50, '-') );
       dbms_output.put_line('사원번호    사원명    성별    월급    나이');
       dbms_output.put_line( lpad('-', 50, '-') );
       
       dbms_output.put_line( v_result ); 
    
    end pcd_empInfo_4;  
    -- Procedure PCD_EMPINFO_4이(가) 컴파일되었습니다.
    
    exec pcd_empInfo_4(107);
    
    
    
    
    ----------------------------------------------------------------------------------------
                            --------**** 사용자 정의 함수 ****---------
    ----------------------------------------------------------------------------------------
    
    ----- 주민번호를 입력받아서 성별을 알려주는 함수 func_gender(주민번호)를 생성해보겠습니다.
    /*
        [문법]
        create or replace function 함수명
        (파라미터명  IN  파라미터변수의타입)
        return 리턴되어질타입
        is
            변수의 선언;
        begin
            실행문
            return 리턴되어질값;
        end 함수명;
    
    
    */
    
     
    create or replace function func_gender
    (p_jubun  IN  varchar2)     -- 파라미터 선언에서는 varchar2(2)와 같이 자리수를 쓰면 오류이다.!!!
    return varchar2             -- varchar2(6) 와 같이 자리수를 쓰면 오류이다.!!!
    is
        v_result varchar2(6);
    begin
        select case when substr(p_jubun, 7, 1) in('1', '3') then '남' else '여' end
            INTO
            v_result
        from dual;
        
        return v_result;
    end func_gender;
    -- Function FUNC_GENDER이(가) 컴파일되었습니다.
    
    
    
    create or replace function func_age
    (p_jubun  IN  varchar2)     
    return number           
    is
        v_result number(3);
    begin
        select extract(year from sysdate) - ( to_number(substr(p_jubun, 1, 2)) + case when substr(p_jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1
            INTO
            v_result
        from dual;
        
        return v_result;
    end func_age;
    -- Function FUNC_AGE이(가) 컴파일되었습니다.
    
    
    
    
    
    
    
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , jubun AS 주민번호
         , func_gender(jubun) AS 성별
         , func_age(jubun) AS 나이
    from employees
    order by 1;
    
    
    
    
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , jubun AS 주민번호
         , func_gender(jubun) AS 성별
         , func_age(jubun) AS 나이
    from employees
    where func_age(jubun) <= 25
    order by 1;
    

    create or replace function func_gender_2
    (p_jubun  IN  varchar2)    
    return varchar2          
    is
        v_result varchar2(6);
    begin
        v_result := case when substr(p_jubun, 7, 1) in('1', '3') then '남' else '여' end;
        return v_result;
    end func_gender_2;
    -- Function FUNC_GENDER_2이(가) 컴파일되었습니다.
    

    create or replace function func_age_2
    (p_jubun  IN  varchar2)     
    return number           
    is
        v_result number(3);
    begin
            v_result := extract(year from sysdate) - ( to_number(substr(p_jubun, 1, 2)) + case when substr(p_jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1;
        return v_result;
    end func_age_2;    
    -- Function FUNC_AGE_2이(가) 컴파일되었습니다.
    
    
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , jubun AS 주민번호
         , func_gender_2(jubun) AS 성별
         , func_age_2(jubun) AS 나이
    from employees
    order by 1;    
    
    
    
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , jubun AS 주민번호
         , func_gender_2(jubun) AS 성별
         , func_age_2(jubun) AS 나이
    from employees
    where func_age_2(jubun) <= 25
    order by 1;
    
    
    ----- ***** 생성되어진 함수의 소스를 조회해봅니다. ***** -----
    
    select TEXT
    from user_source
    where type = 'FUNCTION' and name = 'FUNC_AGE';    
    
    
    /*
    "function func_age
    "
    "    (p_jubun  IN  varchar2)     
    "
    "    return number           
    "
    "    is
    "
    "        v_result number(3);
    "
    "    begin
    "
    "        select extract(year from sysdate) - ( to_number(substr(p_jubun, 1, 2)) + case when substr(p_jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1
    "
    "            INTO
    "
    "            v_result
    "
    "        from dual;
    "
    "
    "
    "        return v_result;
    "
        end func_age;
    */
    
    
    
    ----- [ 퀴즈 ] 아래와 같은 결과물이 나오도록 프로시저( pcd_employees_info )를 생성하세요...
    -----       성별과 나이는 위에서 만든 함수를 사용하세요..
    
    exec pcd_employees_info(101);       -- 여기서 숫자 101은 사원번호이다.
    
    /*
        -------------------------------------------------------------------
        사원번호        부서명        사원명      입사일자        성별      나이
        -------------------------------------------------------------------
        101           .....        ....        ...          ...
    
    */
    
    
   create or replace procedure pcd_employees_info
   (p_employee_id  IN  employees.employee_id%type)
   is
      v_employee_id        employees.employee_id%type;
      v_department_name    departments.department_name%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
   
   begin
        
        with E as
        (
          select department_id   -- join 시키기 위해서는 필요하다. // 킴벨리그랜트는 어떻게 조인시켜야할까?
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE -- 별칭으로 해놔줘야 밖에서 부르기 편하다.
          from employees
          where employee_id = p_employee_id
        )
        select E.employee_id, D.department_name, E.ename, E.hiredate, E.gender, E.age
               into
               v_employee_id, v_department_name, v_ename, v_hiredate, v_gender, v_age 
        from departments D right join E -- right join으로 킴벨리그랜트도 보여준다.
        on D.department_id = E.department_id;
        
        dbms_output.put_line( lpad('-',50,'-') );
        dbms_output.put_line( '사원번호    부서명    사원명    입사일자   성별   나이' );
        dbms_output.put_line( lpad('-',50,'-') );
        
        dbms_output.put_line( v_employee_id || ' ' || v_department_name || ' ' || 
                              v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );
        
   end pcd_employees_info;
   
   -- Procedure PCD_EMPLOYEES_INFO이(가) 컴파일되었습니다.
   
   execute pcd_employees_info(101);
/*
    ------------------------------------------------------------
    사원번호    부서명      사원명          입사일자     성별   나이
    ------------------------------------------------------------
    101        Executive  Neena Kochhar  2005-09-21   남    37
*/


   execute pcd_employees_info(337); -- 337은 없는 사원 번호
   
   /*
    오류 보고 -
    ORA-01403: no data found        ==> 프로시저에서 데이터(행)가 없으면 이와 같이 no data found 라는 오류가 발생한다.
   */
   
   

   
   -- [데이터(행)가 없을 경우 해결책] --
   --> 예외절(Exception)처리를 해주면 된다.
   create or replace procedure pcd_employees_info
   (p_employee_id  IN  employees.employee_id%type)
   is
      v_employee_id        employees.employee_id%type;
      v_department_name    departments.department_name%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
   
   begin
        
        with E as
        (
          select department_id   -- join 시키기 위해서는 필요하다. // 킴벨리그랜트는 어떻게 조인시켜야할까?
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE -- 별칭으로 해놔줘야 밖에서 부르기 편하다.
          from employees
          where employee_id = p_employee_id
        )
        select E.employee_id, D.department_name, E.ename, E.hiredate, E.gender, E.age
               into
               v_employee_id, v_department_name, v_ename, v_hiredate, v_gender, v_age 
        from departments D right join E -- right join으로 킴벨리그랜트도 보여준다.
        on D.department_id = E.department_id;
        
        dbms_output.put_line( lpad('-',50,'-') );
        dbms_output.put_line( '사원번호    부서명    사원명    입사일자   성별   나이' );
        dbms_output.put_line( lpad('-',50,'-') );
        
        dbms_output.put_line( v_employee_id || ' ' || v_department_name || ' ' || 
                              v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );
        
        EXCEPTION   
            WHEN no_data_found THEN     --- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임.
                dbms_output.put_line('>> 사원번호 ' || p_employee_id || '은 존재하지 않습니다. <<');
        
        
   end pcd_employees_info; 
   -- Procedure PCD_EMPLOYEES_INFO이(가) 컴파일되었습니다.
   
   execute pcd_employees_info(101);
   
   execute pcd_employees_info(337);
   -- >> 사원번호 337은 존재하지 않습니다. <<
   
   
   
   
   
   ----------- ========== **** 제어문(IF 문) **** ========= ----------
   /*
    ※ 형식
    
    if      조건1   then 실행문장1;
    elsif   조건2   then 실행문장2;
    elsif   조건2   then 실행문장3;
    else                실행문장4;
    end if;
   
   */
   
   
   delete from departments;
   /*
        오류 보고 -
        ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
        -02292 이 오류번호 이다.
   */
   
   
   update employees set employee_id = 101
   where employee_id = 102;
   /*
    오류 보고 -
    ORA-00001: unique constraint (HR.EMP_EMP_ID_PK) violated
   */
   
   
   create or replace function func_age_3
   (p_jubun  IN  varchar2)
   
   return number
   is
        v_age           number(3);   
        v_year          number(4);
        v_genderNum     varchar2(1) := substr(p_jubun,7,1); 
        -- 여기에는 '1', '2', '3', '4' 중에 한 개가 들어간다.
        
        error_jubun     EXCEPTION;   -- error_jubun; 은 사용자가 정의하는 예외절(Exception)임을 선언한다.
        
   begin
        if      v_genderNum in('1','2') then v_year := 1900;
        elsif   v_genderNum in('3','4') then v_year := 2000;
        else    RAISE error_jubun;          -- error_jubun; 은 사용자가 정의하는 예외절(Exception)이다. 
        end if;
        
        v_age := extract(year from sysdate) - ( v_year + to_number( substr(p_jubun,1,2) ) ) + 1;

        return v_age;
        
        EXCEPTION 
            when error_jubun then
                RAISE_APPLICATION_ERROR(-20001, '>> 올바르지 않은 주민번호 입니다. <<');    
                -- 항상 에러넘버 먼저쓴다, 그리고 출력하고 싶은 말을 쓴다.
                -- -20001 은 오류번호로써, 사용자가 정의해주는 Exception 에 대해서는 오류번호를 -20,001 ~ -20,999 까지만 사용하도록 오라클에서 비워뒀다.
        
   end func_age_3;
   -- Function FUNC_AGE_3이(가) 컴파일되었습니다.
   
   
   select employee_id AS 사원번호
   , first_name || ' ' || last_name AS 사원명
   , jubun AS 주민번호
   , func_age_3(jubun) AS 나이
   from employees
   order by 1;
   
   
   
   select '9510032234567', func_age_3('9510032234567')
   from dual;
   
   
   select '9510039234567', func_age_3('9510039234567')
   from dual;   
   -- ORA-20001: >> 올바르지 않은 주민번호 입니다. <<
   
   
   
   ----------- ========== **** 반복문 **** ========= ----------   
   /*
        반복문에는 종류가 3가지가 있다.
        
        1. 기본 LOOP 문
        2. FOR LOOP 문
        3. WHILE LOOP 문
   
   
   
   
   */
   
    ----------- ========== **** 1. 기본 LOOP문 **** ========= ----------   
    /*
        [문법]
        LOOP
            실행문장;
        EXIT WHEN 탈출조건;     -- 탈출조건이 참 이라면 LOOP 를 탈출한다.
        END LOOP;
    
    
    
    */
   
   
   
   create table tbl_looptest_1
   (bunho       number
   ,name        varchar2(50)
   );
   -- Table TBL_LOOPTEST_1이(가) 생성되었습니다.
   
   -- tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다.
   
   
   create or replace procedure pcd_tbl_looptest_1_insert -- 프로시저 명도 반드시 30 글자 이내여야 한다.
   (p_name      IN       tbl_looptest_1.name%type
   ,p_count     IN       number)        -- p_count 에 20000 을 넣을 것이다.
   is
    v_bunho  tbl_looptest_1.bunho%type := 0;   -- 변수의 초기화!!!(변수에 값을 처음부터 넣어주기)
   
   
   begin
        LOOP
            v_bunho := v_bunho + 1; -- v_bunho 은 반복할때 마다 1씩 증가한다.       
            
            
            
            EXIT WHEN v_bunho > p_count;    ----- 20001 > 20000 탈출조건이 참이라면 LOOP 를 탈출한다.
            
            insert into tbl_looptest_1(bunho, name) values(v_bunho, p_name||v_bunho);
            
        END LOOP;
        
        
   end pcd_tbl_looptest_1_insert;
   
   exec pcd_tbl_looptest_1_insert('엄정화', 50000);
   -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
   
   
   select *
   from tbl_looptest_1
   order by bunho;
   
   
   select count(*)
   from tbl_looptest_1; -- 50000
   
   rollback;
   -- 롤백 완료.
   
   commit;
   -- 커밋 완료.
   
   
   exec pcd_tbl_looptest_1_insert('이순신', 30000);
   -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
   
   commit;
   -- 커밋 완료. 
   
   select count(*)
   from tbl_looptest_1; -- 80000   
   
   
   delete from tbl_looptest_1;
   -- 80,000개 행 이(가) 삭제되었습니다.
   
   -- 또는
   
   -- truncate table tbl_looptest_1;
   
   
   -- 이름이 없는 익명 프로시저(Anonymous Procedure)로 tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다.   
    
    
   declare
    v_bunho number          := 0;        -- 변수의 선언 및 초기화
    p_count number          := 20000;        -- 변수의 선언 및 초기화
    p_name  varchar2(50)    := '이혜리';        -- 변수의 선언 및 초기화
   
   begin
        LOOP
            v_bunho := v_bunho + 1; -- v_bunho 은 반복할때 마다 1씩 증가한다.       
            
            
            
            EXIT WHEN v_bunho > p_count;    ----- 20001 > 20000 탈출조건이 참이라면 LOOP 를 탈출한다.
            
            insert into tbl_looptest_1(bunho, name) values(v_bunho, p_name||v_bunho);
            
        END LOOP;
   end;
   -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    
   select *
   from tbl_looptest_1
   order by bunho;
   
   
   select count(*)
   from tbl_looptest_1; -- 20000    
   
   
   rollback;
   -- 롤백 완료.
    
    
    
    
    -- 07월 30일
    ----------- ========== **** 2. FOR LOOP문 **** ========= ----------   
    /*
        [문법]
        
        for 변수 in [reverse] 시작값.. 마지막값  loop
                실행문장;
        end loop;
        
    */
    
   select count(*)
   from tbl_looptest_1; -- 0
   
-- 이름이 없는 익명 프로시저(Anonymous Procedure)로 tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다.      
   

   declare
    v_name  varchar2(50)    := '강감찬';        -- 변수의 선언 및 초기화
   
   begin
        for i in 1..20000  loop     -- 변수 i에 맨처음 1 이 들어가고 매번 1씩 증가된 값이 i에 들어가는데 20000 까지 i에 들어간다.
                insert into tbl_looptest_1(bunho, name) values(i, v_name||i);             -- 즉, 20000 번 반복하는 것이다.
        end loop;    
   end;   
   -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
   
   select *
   from tbl_looptest_1
   order by bunho;
   
   
   select count(*)
   from tbl_looptest_1; -- 20000       
   
   rollback;
   
   
   
    
   declare
    v_name  varchar2(50) := '강감찬';        -- 변수의 선언 및 초기화
   
   begin
        for i in reverse 1..100  loop     -- 변수 i에 맨처음 20000 이 들어가고 매번 1씩 감소된 값이 i에 들어가는데 1 까지 i에 들어간다.
                insert into tbl_looptest_1(bunho, name) values(i, v_name||i);             -- 즉, 20000 번 반복하는 것이다.
        end loop;    
   end;  
   -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
   
   
   select *
   from tbl_looptest_1;

   select count(*)
   from tbl_looptest_1; -- 100       
   
   rollback;   
   
   
   
   
   truncate table tbl_looptest_1;
   -- Table TBL_LOOPTEST_1이(가) 잘렸습니다.
   -- insert 번호가 계속 깨져서 초기화용도로 했다.
   
    ----------- ========== **** 3. WHILE LOOP문 **** ========= ---------- 
    /*
    
        [문법]
        while   조건   loop
            실행문장;   -- 조건이 참이라면 실행한다. 조건이 거짓이 되어지면 반복문을 빠져나온다.
        end loop;
    */
    
    
   declare
        v_name  varchar2(50)  := '유관순';   -- 변수의 선언 및 초기화        
        v_cnt   number := 1;                -- 변수의 선언 및 초기화
   begin
        while not(v_cnt > 20000) loop    -- not(탈출조건)   탈출조건이 참이라면 전체가 거짓이 되어지므로 반복문을 빠져나간다.
           insert into tbl_looptest_1(bunho, name) values(v_cnt, v_name||v_cnt);
           
           v_cnt := v_cnt + 1;
        end loop;    
   end;       
   -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
   
   
   select *
   from tbl_looptest_1
   order by bunho asc;

   select count(*)
   from tbl_looptest_1; -- 20000       
   
   rollback;       
    
   
   
   
   ---------------------------------------------------------------------------------------
   
   create table tbl_member_test1
   (userid      varchar2(20)
   ,passwd      varchar2(20) not null
   ,name        varchar2(30) not null
   ,constraint  PK_tbl_member_test1_userid primary key(userid)
   );
   -- Table TBL_MEMBER_TEST1이(가) 생성되었습니다.
   
   
   -- [퀴즈] tbl_member_test1 테이블에 insert 해주는 pcd_tbl_member_test1_insert 프로시저를 작성하세요.

   exec pcd_tbl_member_test1_insert('hongkd','qwer1234$','홍길동');    --> 정상적으로 insert 되어진다.
   
   exec pcd_tbl_member_test1_insert('eomjh','a3$','유관순');    --> 오류메시지 '-20002 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' 이 뜬다.  
   exec pcd_tbl_member_test1_insert('eomjh','abc1234','유관순');    --> 오류메시지 '-20002 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' 이 뜬다.    
   

create or replace procedure pcd_tbl_member_test1_insert
  (p_userid    IN   tbl_member_test1.userid%type
  ,p_passwd    IN   tbl_member_test1.passwd%type
  ,p_name      IN   tbl_member_test1.name%type
  )
  is
      v_length           number(20);
      error_insert       exception;
      v_ch               varchar2(1);
      v_flag_alphabet    number(1) := 0;
      v_flag_number      number(1) := 0;
      v_flag_special     number(1) := 0;
  begin
        v_length := length(p_passwd);
        
        if(v_length < 5 OR  v_length > 20) then
            raise  error_insert;   -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
        else
            for i in 1..v_length loop
                v_ch := substr(p_passwd, i, 1);
                
                if( (v_ch between 'a' and 'z') OR (v_ch between 'A' and 'Z') ) then  -- 영문자 이라면 
                    v_flag_alphabet := 1;
                elsif( v_ch between '0' and '9' ) then  -- 숫자 이라면 
                    v_flag_number := 1;
                else  -- 특수문자 이라면 
                    v_flag_special := 1;
                end if;
            end loop;
            
            if(v_flag_alphabet * v_flag_number * v_flag_special = 1) then
                 insert into tbl_member_test1(userid, passwd, name) values(p_userid, p_passwd, p_name);
            else  
                 raise error_insert;  -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
            end if;     
            
        end if;
        
        exception  
            when  error_insert  then
                  raise_application_error(-20002, '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.');
  
  end pcd_tbl_member_test1_insert;
   
   
   
   
   
  select *
  from tbl_member_test1;
  
  exec pcd_tbl_member_test1_insert('eomjh','a3$','유관순');      
  /*
    오류 보고 -
    ORA-20002: 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.
  */
  
  exec pcd_tbl_member_test1_insert('eomjh','abc1234','유관순');  
  /*
    오류 보고 -
    ORA-20002: 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.
  */
  
  exec pcd_tbl_member_test1_insert('hongkd','qwer1234$','홍길동');  
  -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
  
  select *
  from tbl_member_test1;
  -- hongkd   qwer1234$   홍길동
  
  commit;
  
  delete from tbl_member_test1;
  
  
  
  
  -------------------- ****** 사용자 정의 예외절(EXCEPTION) ***** ------------------
  
  예외절 = 오류절
  
  ※ 형식
  
  
    exception
        when    익셉션이름1  [or 익셉션이름2]    then  -- 여러개의 익셉션을 묶어서 같은 실행문이 나오게 할 수 있다.
                실행문장1;
                실행문장2;
                실행문장3;
                
        when    익셉션이름3  [or 익셉션이름4]    then
                실행문장4;
                실행문장5;
                실행문장6;
                
        when    others   then   -- 기타 익셉션이라면
                실행문장7;
                실행문장8;
                실행문장9;
  
  ---------------------------------------------------------------------------------
   /*
 
   ==== tbl_member_test1 테이블에 insert 할 수 있는 요일명과 시간을 제한해 두겠습니다. ====
   
        tbl_memeber_test1 테이블에 insert 할 수 있는 요일명은 월,화,수,목,금 만 가능하며
        또한 월,화,수,목,금 중에 오후 2시 부터 오후 5시 이전까지만(오후 5시 정각은 안돼요) insert가 가능하도록 하고자 한다.
        만약에 insert 가 불가한 요일명(토,일)이거나 불가한 시간대에 insert 를 시도하면 
        '영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!' 이라는 오류메시지가 뜨도록 한다.
   */
   
   
    create or replace procedure pcd_tbl_member_test1_insert
    (p_userid    IN   tbl_member_test1.userid%type
    ,p_passwd    IN   tbl_member_test1.passwd%type
    ,p_name      IN   tbl_member_test1.name%type
    )
    is
      error_dayTime      exception;
      v_length           number(20);
      error_insert       exception;
      v_ch               varchar2(1);
      v_flag_alphabet    number(1) := 0;
      v_flag_number      number(1) := 0;
      v_flag_special     number(1) := 0;
      
    begin
        
        -- 입력(insert)이 불가한 요일명과 시간대를 알아본다. --
        if( to_char(sysdate, 'd') in('1','7') OR        -- to_char(sysdate, 'd') ==> '1'(일), '2'(월), '3'(화), '4'(수), '5'(목), '6'(금), '7'(토)
            to_char(sysdate, 'hh24') < '14' OR to_char(sysdate, 'hh24') > '16'
        )  then raise error_dayTime;   
        
        
        else  
            v_length := length(p_passwd);
            
            if(v_length < 5 OR  v_length > 20) then
                raise  error_insert;   -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
            else
                for i in 1..v_length loop
                    v_ch := substr(p_passwd, i, 1);
                    
                    if( (v_ch between 'a' and 'z') OR (v_ch between 'A' and 'Z') ) then  -- 영문자 이라면 
                        v_flag_alphabet := 1;
                    elsif( v_ch between '0' and '9' ) then  -- 숫자 이라면 
                        v_flag_number := 1;
                    else  -- 특수문자 이라면 
                        v_flag_special := 1;
                    end if;
                end loop;
                
                if(v_flag_alphabet * v_flag_number * v_flag_special = 1) then
                     insert into tbl_member_test1(userid, passwd, name) values(p_userid, p_passwd, p_name);
                else  
                     raise error_insert;  -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
                end if;     
                
            end if;
            
        
        end if;
        
        
        
        exception  
            when error_dayTime then
                raise_application_error(-20003, '영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!');
            
            when  error_insert  then
                  raise_application_error(-20002, '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.');
    
    end pcd_tbl_member_test1_insert;  
    -- Procedure PCD_TBL_MEMBER_TEST1_INSERT이(가) 컴파일되었습니다.
    
    select *
    from tbl_member_test1;
    -- hongkd	qwer1234$	홍길동
    
    
    
    exec pcd_tbl_member_test1_insert('eomjh','abcd1234$','엄정화');
    /*
        오류 보고 -
        ORA-20003: 영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!
        ORA-06512: at "HR.PCD_TBL_MEMBER_TEST1_INSERT", line 56
        ORA-06512: at line 1    
    */
    
    
    --------- **** 오라클에서는 배열이 없습니다만 배열처럼 사용되어지는 table 타입 변수가 있다. **** -----------
    --             그래서 table 타입 변수를 사용하여 자바의 배열처럼 사용합니다. --
    
    
   create or replace procedure pcd_employees_info_deptid -- 내가 입력한 부서번호의 근무하는 사람들을 보여준다.
   (p_department_id  IN  employees.department_id%type)
   is
   
      v_department_id      employees.department_id%type;
      v_department_name    departments.department_name%type;
      v_employee_id        employees.employee_id%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
   
   begin
        
        with E as
        (
          select department_id   -- join 시키기 위해서는 필요하다. // 킴벨리그랜트는 어떻게 조인시켜야할까?
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE -- 별칭으로 해놔줘야 밖에서 부르기 편하다.
          from employees
          where department_id = p_department_id
        )
        select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
               into
               v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age 
        from departments D right join E -- right join으로 킴벨리그랜트도 보여준다.
        on D.department_id = E.department_id;
        
        dbms_output.put_line( lpad('-',60,'-') );
        dbms_output.put_line( '부서번호   부서명    사원번호      사원명    입사일자   성별   나이' );
        dbms_output.put_line( lpad('-',60,'-') );
        
        dbms_output.put_line( v_department_id || ' ' ||v_department_name || ' ' || v_employee_id || ' ' || 
                              v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );
        
        EXCEPTION   
            WHEN no_data_found THEN     --- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임.
                dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        
        
   end pcd_employees_info_deptid;    
   -- Procedure PCD_EMPLOYEES_INFO_DEPTID이(가) 컴파일되었습니다.
   
   exec pcd_employees_info_deptid(9000);
   -- >> 부서번호 9000 은 존재하지 않습니다 << 
   
   exec pcd_employees_info_deptid(10); 
   /*
   ------------------------------------------------------------
    부서번호   부서명    사원번호      사원명    입사일자   성별   나이
    ------------------------------------------------------------
    10  200 Jennifer Whalen 2003-09-17 여 44
   */
   
   exec pcd_employees_info_deptid(30);   
   
   /*
    오류 보고 -
    ORA-01422: exact fetch returns more than requested number of rows
   */
   
   /*
    6개 행이 나와야 하는데 프로시저에서 select 되어진 컬럼의 값을 담을 변수(v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age )는
    데이터 값을 1개 밖에 담지 못하므로 위와 같은 오류가 발생한다.
   */
   
   
   /*
    자바를 예를 들면
    int jumsu = 0;
    
    변수 jumsu 예 90, 95, 88, 75, 91, 80 이라는 6개의 정수를 입력하고자 한다.
    돼요? 안돼요?
    
    jumsu = 90;
    jumsu = 95;
    jumsu = 88;
    jumsu = 75;
    jumsu = 91;
    jumsu = 80;
    
    최종적으로 변수 jumsu 에 담긴 값은 80 이 된다. 
    변수는 한 번에 하나의 값밖에 못받아준다.
    
    그래서 자바에서는 아래와 같이 배열로 만들어서 쓴다.
    int[] jumsuArr = new int[6];
    
    jumsuArr[0] = 90;
    jumsuArr[1] = 95;
    jumsuArr[2] = 88;
    jumsuArr[3] = 75;
    jumsuArr[4] = 91;
    jumsuArr[5] = 80;
    
    -------------------------------
    | 90 | 95 | 88 | 75 | 91 | 80 |
    -------------------------------
    
    배열을 90도로 틀면 마치 column 1개인 table로 보여지는데 이것이 바로 table 타입 변수라고 한다.
    배열과 흡사하다.
    
    자바같은 경우는 0  1  2  3  4  5  index지만,
    데이터베이스는 0번째 행은 없다. 그래서 1  2  3  4  5  6 번째 행으로 표현한다.
   */
   
   
   select employee_id
   from employees
   where department_id = 30;
   
   /*
        아래의 모양은 자바에서 사용되던 배열의 모양을 90도 회전한 것과 같다.
        그래서 오라클에서는 자바의 배열처럼 컬럼을 1개만 가지는 table 타입 변수를 사용하여 쓴다.
   
   
        EMPLOYEE_ID
        ----------- 
        |   114   |
        -----------           
        |   115   |
        -----------           
        |   116   |
        -----------            
        |   117   |
        -----------            
        |   118   |
        -----------            
        |   119   |
        -----------           
   */
   
   -------------- **** [위에서 만든 pcd_employees_info_deptid 을 올바르게 작동하도록 해결하기] **** --------------
   
   
   
   
   create or replace procedure pcd_employees_info_deptid -- 내가 입력한 부서번호의 근무하는 사람들을 보여준다.
   (p_department_id  IN  employees.department_id%type)
   is
      type department_id_type
      is table of employees.department_id%type index by binary_integer;
      -- 얘는 테이블타입의 변수인데 들어오는 데이터타입은 부서번호 컬럼의 데이터타입과 같다.
      
      type department_name_type
      is table of departments.department_name%type index by binary_integer;
      -- 얘는 테이블타입의 변수인데 들어오는 데이터타입은 부서명 컬럼의 데이터타입과 같다.
      
      type employee_id_type
      is table of employees.employee_id%type index by binary_integer;
      
      type ename_type
      is table of varchar2(30) index by binary_integer;    
      
      type hiredate_type
      is table of varchar2(10) index by binary_integer;   
      
      type gender_type
      is table of varchar2(6) index by binary_integer;   
      
      type age_type
      is table of number(3) index by binary_integer;      
      
      
      v_department_id      department_id_type;
      v_department_name    department_name_type;
      v_employee_id        employee_id_type;
      v_ename              ename_type;
      v_hiredate           hiredate_type;
      v_gender             gender_type;
      v_age                age_type;
      
      i binary_integer := 0;     -- i가 마치 배열의 방번호 용도 처럼 쓰인다.
                                 -- 그런데 자바에서 배열의 시작은 0 번 부터 시작하지만
                                 -- 오라클에서는 1 번 부터 시작한다.
   
   begin
        

        FOR v_rcd IN ( select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
                       from departments D right join ( select department_id   -- join 시키기 위해서는 필요하다. // 킴벨리그랜트는 어떻게 조인시켜야할까?
                                                           , employee_id
                                                           , first_name || ' ' || last_name AS ENAME
                                                           , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                                                           , func_gender(jubun) AS GENDER
                                                           , func_age(jubun) AS AGE -- 별칭으로 해놔줘야 밖에서 부르기 편하다.
                                                      from employees
                                                      where department_id = p_department_id ) E
                                                      on D.department_id = E.department_id ) LOOP
                     -- select 되어진 행이 1줄씩 v_rcd에 들어간다.
                     -- 행의 끝까지가 1줄씩 v_rcd에 들어간다.
                     -- 반복횟수는 행 갯수만큼
            
            i := i + 1;
            
          v_department_id(i) :=  v_rcd.department_id;  -- 자바는 v_department_id[i]로 쓰지만 오라클은 이렇게 쓴다.
          v_department_name(i) := v_rcd.department_name;
          v_employee_id(i) := v_rcd.employee_id;
          v_ename(i) := v_rcd.ename;
          v_hiredate(i) := v_rcd.hiredate;
          v_gender(i) := v_rcd.gender;
          v_age(i) := v_rcd.age;
          
          
        END LOOP;
    
        if ( i = 0 )  then 
            raise no_data_found;
        else 
        
            dbms_output.put_line( lpad('-',60,'-') );
            dbms_output.put_line( '부서번호   부서명    사원번호      사원명    입사일자   성별   나이' );
            dbms_output.put_line( lpad('-',60,'-') );
            
            -- dbms_output.put_line('i => ' || i);
            FOR k IN 1..i LOOP
            dbms_output.put_line( v_department_id(k) || ' ' || v_department_name(k) || ' ' || v_employee_id(k) || ' ' || 
                                  v_ename(k) || ' ' || v_hiredate(k) || ' ' || v_gender(k) || ' ' || v_age(k) );
            END LOOP;
        
        end if;
        
        EXCEPTION   
            WHEN no_data_found THEN     --- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임.
                dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        
        
   end pcd_employees_info_deptid; 
   -- Procedure PCD_EMPLOYEES_INFO_DEPTID이(가) 컴파일되었습니다.
   
   exec pcd_employees_info_deptid(9000);
   -- >> 부서번호 9000 은 존재하지 않습니다 << 
   
   exec pcd_employees_info_deptid(10); 
   /*
   ------------------------------------------------------------
    부서번호   부서명    사원번호      사원명    입사일자   성별   나이
    ------------------------------------------------------------
    10  200 Jennifer Whalen 2003-09-17 여 44
   */
   
   exec pcd_employees_info_deptid(30);   
   /*
   ------------------------------------------------------------
    부서번호   부서명    사원번호      사원명    입사일자   성별   나이
    ------------------------------------------------------------
    30 Purchasing 114 Den Raphaely 2002-12-07 여 55
    30 Purchasing 115 Alexander Khoo 2003-05-18 남 61
    30 Purchasing 116 Shelli Baida 2005-12-24 남 62
    30 Purchasing 117 Sigal Tobias 2005-07-24 여 61
    30 Purchasing 118 Guy Himuro 2006-11-15 남 44
    30 Purchasing 119 Karen Colmenares 2007-08-10 남 43
   */
   
   
   --------------------------------------------------------------------------------------
   
   
   ---- ===== **** CURSOR **** ===== -----
              
  --  PL/SQL 에서 SELECT 되어져 나오는 행의 개수가 2개 이상인 경우에는 위에서 한 것처럼
  --  table 타입의 변수를 사용하여 나타낼 수 있고, 또는 CURSOR 를 사용하여 나타낼 수도 있다. 
  --  table 타입의 변수를 사용하는 것 보다 CURSOR 를 사용하는 것이 더 편하므로 
  --  대부분 CURSOR 를 많이 사용한다.
  
  
  ----- *** 명시적 CURSOR 만들기 *** -----
  ※ 형식

  1.단계 -- CURSOR 의 선언(정의)
     
    CURSOR 커서명
    IS
    SELECT 문;  

  2.단계 -- CURSOR 의 OPEN

    OPEN 커서명;

  3.단계 -- CURSOR 의 FETCH
           (FETCH 란? SELECT 되어진 결과물을 끄집어 내는 작업을 말한다)
    
    FETCH  커서명 INTO 변수;

  4.단계 -- CURSOR 의 CLOSE

    CLOSE 커서명;
      


 ※ ==== 커서의 속성변수 ==== ※

 1. 커서명%ISOPEN   ==> 커서가 OPEN 되어진 상태인가를 체크하는 것.
                       만약에 커서가 OPEN 되어진 상태이라면 TRUE.

 2. 커서명%FOUND    ==> FETCH 된 레코드(행)이 있는지 체크하는 것.
                       만약에 FETCH 된 레코드(행)이 있으면 TRUE.

 3. 커서명%NOTFOUND ==> FETCH 된 레코드(행)이 없는지 체크하는 것.
                       만약에 FETCH 된 레코드(행)이 없으면 TRUE.

 4. 커서명%ROWCOUNT ==> 현재까지 FETCH 된 레코드(행)의 갯수를 반환해줌.
   
   
   
   
   
   create or replace procedure pcd_employees_deptid_cursor
   (p_department_id  IN  employees.department_id%type)
   is
   
      -- 1단계 ==> CURSOR의 선언(정의)
      cursor cur_empinfo
      is
      select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
      from departments D right join ( 
                                      select department_id   
                                           , employee_id
                                           , first_name || ' ' || last_name AS ENAME
                                           , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                                           , func_gender(jubun) AS GENDER
                                           , func_age(jubun) AS AGE 
                                       from employees
                                       where department_id = p_department_id 
                                    ) E
       on D.department_id = E.department_id;

      v_department_id      employees.department_id%type;
      v_department_name    departments.department_name%type;
      v_employee_id        employees.employee_id%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
      
      v_cnt                number := 0;
   begin
        
      -- 2단계 ==> CURSOR의 OPEN
      OPEN cur_empinfo;
      
      -- 3단계 ==> CURSOR의 FEITCH ( select 되어진 결과물을 끄집어 내는 작업 )     
      -- fetch 작업은 나온 행 갯수만큼 반복해야 한다.
      LOOP 
          FETCH cur_empinfo 
          INTO v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age;
          --- select 되어진 값들을 이 변수들에 각각 넣겠다.
          
          -- dbms_output.put_line('확인용 fetch 되어진 행의 개수 => ' || cur_empinfo%ROWCOUNT);
          v_cnt := cur_empinfo%ROWCOUNT;

          EXIT WHEN cur_empinfo%notfound; -- 다음에 읽어들일(select된) 행이 없거나, 아예 조회된 행이 없다면 탈출

          if (cur_empinfo%ROWCOUNT = 1) then 
              dbms_output.put_line( lpad('-',60,'-') );
              dbms_output.put_line( '부서번호   부서명    사원번호      사원명    입사일자   성별   나이' );
              dbms_output.put_line( lpad('-',60,'-') );
          end if;
          
          dbms_output.put_line( v_department_id || ' ' || v_department_name || ' ' || 
                                v_employee_id || ' ' || v_ename || ' ' || 
                                v_hiredate || ' ' || v_gender || ' ' || v_age );      
      END LOOP;
      


      -- 4단계 ==> CURSOR 의 CLOSE        
      CLOSE cur_empinfo;
      
      if( v_cnt = 0 ) then
        dbms_output.put_line('>> 부서번호 ' || p_department_id || '는 존재하지 않습니다. <<');
      else
        dbms_output.put_line(' ');
        dbms_output.put_line('>> 조회된 행의 개수 : ' || v_cnt || ' 개 입니다. <<');
      end if;

   end pcd_employees_deptid_cursor;       
   -- Procedure PCD_EMPLOYEES_DEPTID_CURSOR이(가) 컴파일되었습니다.
   
   
   exec pcd_employees_deptid_cursor(30);
   /*
       ------------------------------------------------------------
        부서번호   부서명    사원번호      사원명    입사일자   성별   나이
        ------------------------------------------------------------
        30 Purchasing 119 Karen Colmenares 2007-08-10 남 43
        30 Purchasing 118 Guy Himuro 2006-11-15 남 44
        30 Purchasing 117 Sigal Tobias 2005-07-24 여 61
        30 Purchasing 116 Shelli Baida 2005-12-24 남 62
        30 Purchasing 115 Alexander Khoo 2003-05-18 남 61
        30 Purchasing 114 Den Raphaely 2002-12-07 여 55
         
        >> 조회된 행의 개수 : 6 개 입니다. <<
   */
   
   
   exec pcd_employees_deptid_cursor(10);
   /*
        ------------------------------------------------------------
        부서번호   부서명    사원번호      사원명    입사일자   성별   나이
        ------------------------------------------------------------
        10 Administration 200 Jennifer Whalen 2003-09-17 여 44
         
        >> 조회된 행의 개수 : 1 개 입니다. <<   
   */
   
   exec pcd_employees_deptid_cursor(9000);
   -- >> 부서번호 9000는 존재하지 않습니다. <<
   
   
   
   
   
   ----------------------- ******* FOR LOOP CURSOR 만들기 ******* -----------------------
   /*
        FOR LOOP CURSOR 문을 사용하면
        커서의 OPEN, 커서의 FETCH, 커서의 CLOSE 가 자동적으로 발생되어지기 때문에 
        우리는 커서의 OPEN, 커서의 FETCH, 커서의 CLOSE 문장을 기술할 필요가 없다.
   */
   
   ※ 형식
   FOR 변수명(select 되어진 행의 정보가 담기는 변수) IN 커서명 LOOP
        실행문장;
   END LOOP;
   
    
   create or replace procedure pcd_employees_deptid_forcursor
   (p_department_id  IN  employees.department_id%type)
   is

   
      -- 1단계 ==> CURSOR의 선언(정의)
      cursor cur_empinfo
      is
      select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
      from departments D right join ( 
                                      select department_id   
                                           , employee_id
                                           , first_name || ' ' || last_name AS ENAME
                                           , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                                           , func_gender(jubun) AS GENDER
                                           , func_age(jubun) AS AGE 
                                       from employees
                                       where department_id = p_department_id 
                                    ) E
       on D.department_id = E.department_id;
       v_cnt     number := 0;
   begin
   
   
    /*
       -- 2단계
        
       FOR 변수명(select 되어진 행의 정보가 담기는 변수) IN 커서명 LOOP
            실행문장;
       END LOOP;
    */
    
       FOR v_rcd IN cur_empinfo LOOP
       
              v_cnt := cur_empinfo%ROWCOUNT;
              if( v_cnt = 1 ) then
                  dbms_output.put_line( lpad('-',60,'-') );
                  dbms_output.put_line( '부서번호   부서명    사원번호      사원명    입사일자   성별   나이' );
                  dbms_output.put_line( lpad('-',60,'-') );
              end if;
              dbms_output.put_line( v_rcd.department_id || ' ' || v_rcd.department_name || ' ' ||
                                    v_rcd.employee_id || ' ' || v_rcd.ename || ' ' ||
                                    v_rcd.hiredate || ' ' || v_rcd.gender || ' ' || v_rcd.age );
       END LOOP;    
       
      if( v_cnt = 0 ) then
        dbms_output.put_line('>> 부서번호 ' || p_department_id || '는 존재하지 않습니다. <<');
      else
        dbms_output.put_line(' ');
        dbms_output.put_line('>> 조회된 행의 개수 : ' || v_cnt || ' 개 입니다. <<');
      end if;
       

   end pcd_employees_deptid_forcursor;
   -- Procedure PCD_EMPLOYEES_DEPTID_FORCURSOR이(가) 컴파일되었습니다.
   
   
   exec pcd_employees_deptid_forcursor(30);
   /*
        ------------------------------------------------------------
        부서번호   부서명    사원번호      사원명    입사일자   성별   나이
        ------------------------------------------------------------
        30 Purchasing 119 Karen Colmenares 2007-08-10 남 43
        30 Purchasing 118 Guy Himuro 2006-11-15 남 44
        30 Purchasing 117 Sigal Tobias 2005-07-24 여 61
        30 Purchasing 116 Shelli Baida 2005-12-24 남 62
        30 Purchasing 115 Alexander Khoo 2003-05-18 남 61
        30 Purchasing 114 Den Raphaely 2002-12-07 여 55
   */

   exec pcd_employees_deptid_forcursor(10);
   /*
        ------------------------------------------------------------
        부서번호   부서명    사원번호      사원명    입사일자   성별   나이
        ------------------------------------------------------------
        10 Administration 200 Jennifer Whalen 2003-09-17 여 44   
   */
   
   
   exec pcd_employees_deptid_forcursor(9000);
   
   
   
   
   
   -------------------------- ******** PACKAGE(패키지) ******** --------------------------
   --->     PACKAGE(패키지)란? 여러개의 Procedure 와 여러개의 Function 들의 묶음
   
   ----- 1. PACKAGE(패키지)의 선언
   create or replace package employee_pack
   is
        --> 패키지에 들어올 프로시저 또는 함수를 선언한다.
        procedure pcd_emp_info(p_deptno IN employees.department_id%type);
        procedure pcd_dept_info(p_deptno IN departments.department_id%type);
        function  func_gender(p_jubun IN employees.jubun%type) return varchar2;
   end employee_pack;
   -- Package EMPLOYEE_PACK이(가) 컴파일되었습니다.
   
   
    ---- 2. PACKAGE(패키지)의 Body(본문) 생성하기
   create or replace package body employee_pack
   is
       procedure pcd_emp_info(p_deptno IN employees.department_id%type)
       is
           cursor  cur_empinfo
           is
           select D.department_id, D.department_name, 
                  E.employee_id, E.first_name || ' ' || E.last_name AS ENAME
           from departments D join employees E
           on D.department_id = E.department_id
           where E.department_id = p_deptno;
           
           v_cnt number := 0;
       begin
           for v_rcd in cur_empinfo loop
              v_cnt := cur_empinfo%rowcount; 
              if(v_cnt = 1) then
                 dbms_output.put_line( lpad('-',60,'-') );
                 dbms_output.put_line('부서번호  부서명       사원번호    사원명');
                 dbms_output.put_line( lpad('-',60,'-') );
              end if;
              
              dbms_output.put_line(v_rcd.department_id || ' ' || v_rcd.department_name || ' ' || 
                                   v_rcd.employee_id || '  ' || v_rcd.ENAME);
           end loop;
           
           if(v_cnt = 0) then 
              dbms_output.put_line('>> 부서번호 ' || p_deptno || '은 없습니다. <<');
           else
              dbms_output.put_line(' ');
              dbms_output.put_line('>> 조회건수 : ' || v_cnt || '개');
           end if;
       end pcd_emp_info;
       
       procedure pcd_dept_info(p_deptno IN departments.department_id%type)
       is
          v_department_id      departments.department_id%type;
          v_department_name    departments.department_name%type;
       begin
             select department_id, department_name
                    into
                    v_department_id, v_department_name
             from departments
             where department_id = p_deptno;
             
             dbms_output.put_line( lpad('-',40,'-') );
             dbms_output.put_line('부서번호  부서명');
             dbms_output.put_line( lpad('-',40,'-') );
             
             dbms_output.put_line(v_department_id || ' ' || v_department_name);
             
             exception
                 when no_data_found then 
                      dbms_output.put_line('>> 부서번호 ' || p_deptno || '은 없습니다. <<');
             
       end pcd_dept_info;
       
       function  func_gender(p_jubun IN employees.jubun%type) 
       return varchar2
       is
           v_gender_num  varchar2(1);
           v_result      varchar2(100);
       begin
           if( length(p_jubun) = 13 ) then      
       
               v_gender_num := substr(p_jubun, 7, 1);
               if( v_gender_num in('1','3') ) then
                   v_result := '남';
               elsif( v_gender_num in('2','4') ) then 
                   v_result := '여';
               else 
                   v_result := '주민번호가 올바르지 않습니다.';
               end if;    
               

           
           else
               v_result := '주민번호의 길이가 13자리가 아닙니다.';
           end if;
           
           return v_result;
       end func_gender;
 
   end employee_pack;
   -- Package Body EMPLOYEE_PACK이(가) 컴파일되었습니다.
   
   
   begin
        employee_pack.pcd_emp_info(30);
   end;
   
/*
------------------------------------------------------------
부서번호  부서명       사원번호    사원명
------------------------------------------------------------
30 Purchasing 114  Den Raphaely
30 Purchasing 115  Alexander Khoo
30 Purchasing 116  Shelli Baida
30 Purchasing 117  Sigal Tobias
30 Purchasing 118  Guy Himuro
30 Purchasing 119  Karen Colmenares
 
>> 조회건수 : 6개
*/
   
   begin
        employee_pack.pcd_emp_info(9000);
   end;   
   -- >> 부서번호 9000은 없습니다. <<
   
   
   
   begin
        employee_pack.pcd_dept_info(30);
   end;
/*
    ----------------------------------------
    부서번호  부서명
    ----------------------------------------
    30 Purchasing
*/

   begin
        employee_pack.pcd_dept_info(9000);
   end;
   -- >> 부서번호 9000은 없습니다. <<
   
   
   select employee_pack.func_gender('9007301234567')
   ,      employee_pack.func_gender('0107303234567')
   ,      employee_pack.func_gender('9107302234567')
   ,      employee_pack.func_gender('0207304234567')
   from dual;
   -- 남    남     여     여
   
   select employee_pack.func_gender('90073012345')
   ,      employee_pack.func_gender('0107307234567')
   from dual;   
   -- 주민번호의 길이가 13자리가 아닙니다.	   주민번호가 올바르지 않습니다.
   
   select employee_id, first_name, employee_pack.func_gender(jubun)
   from employees
   order by 1;
   
   
   
   
   -------- ***** 패키지 소스 보기 ***** --------
   select line, text
   from user_source
   where type = 'PACKAGE' and name = 'EMPLOYEE_PACK';
   
   -------- ***** 패키지 BODY(본문) 소스 보기 ***** --------   
   select line, text
   from user_source
   where type = 'PACKAGE BODY' and name = 'EMPLOYEE_PACK';
   
   -----------------------------------------------------------------------------
   
   select * from tab;
   /*
    TNAME            TABTYPE   
    ------------------------
    COUNTRIES	      TABLE	
    DEPARTMENTS	      TABLE	
    EMPLOYEES	      TABLE	
    EMP_DETAILS_VIEW  VIEW    (VIEW는 테이블은 아니지만 select 되어진 결과물을 마치 테이블 처럼 보는 것)	
    JOBS	          TABLE	
    JOB_HISTORY	      TABLE	
    LOCATIONS	      TABLE	
    REGIONS	          TABLE	
    */
    
    
    select * 
    from regions;
    
    desc regions;
    
    select * 
    from countries; 
    
    desc countries;
    
    select * 
    from locations;
    
    desc locations;
    
    select * 
    from departments;
    
    desc departments;
    
    select *
    from jobs;
    
    desc jobs;
    
    select * 
    from job_history;
    
    desc job_history;
    
    
    select *
    from employees;
    -- job_id --> foreign key
    
    select *
    from user_constraints
    where table_name = 'JOB_HISTORY';
    
    desc employees;
    
    
    select * 
    from job_history;
    -- employee_id --> foreign key 
    
    select count(*) 
    from employees;
    
    ----------------------------------------------------------------------------
    ---- 10월 27일
    select E.department_id, D.department_name, E.employee_id, 
              E.first_name || ' ' || E.last_name AS fullname,
              to_char(E.hire_date, 'yyyy-mm-dd') AS hire_date,
              nvl(E.salary + E.salary*E.commission_pct, E.salary) AS monthsal,
              func_gender(E.jubun) AS gender,
              func_age(E.jubun) AS age 
    from employees E left join departments D
    on E.department_id = D.department_id
    
    
    select *
    from employees;
    
    select nvl(D.department_name, '부서없음') AS department_name
           , count(*) AS cnt 
           , round(count(*) / (select count(*) from employees) * 100, 2) AS percentage 
    from employees E left join departments D 
    on E.department_id = D.department_id 
    group by nvl(D.department_name, '부서없음')
    order by department_name
    
    select func_gender(jubun) AS gender, count(*) AS cnt,  round(count(*) / (select count(*) from employees) * 100, 2) AS percentage 
    from employees
    group by func_gender(jubun)
    
    select count(*) 
    from employees

    select func_gender(jubun) AS gender
        , count(*) AS cnt
        , round(count(*) / (select count(*) from employees) * 100, 2) AS percentage 
    from employees E left join departments D
    ON E.department_id = D.department_id
    where D.department_name = 'Shipping'
    group by func_gender(jubun)
    order by gender
    
    select func_gender(jubun) AS gender
        , count(*) AS cnt
        , round(count(*) / (select count(*) from employees) * 100, 2) AS percentage 
    from employees E left join departments D
    ON E.department_id = D.department_id
    where D.department_id is null
    group by func_gender(jubun)
    order by gender
    