/* SQL (Structured Query Language)
- 구조화 된 질의 언어
- RDBMS에서 저장된 데이터를 관리, 조작 하거나
   DB 구조를 제어할 대 사용하는 언어

## SQL 종료
- DQL(Data Query Language) 데이터 질의어 : 테이블의 데이터를 검색/조회 ex) SELECT
- DML(Data Manipulation Language) 데이터 조작 언어 : 테이블에 저장된 값을 삽입, 수정, 삭제
   ex) INSERT, UPDATE, DELETE
- DDL(Data Definition Language) 데이터 정의 언어
- DCL(Data Control Language) 데이터 제어 언어
- TCL(Transaction Control Language) 트랜잭션 제어 언어
*/

# DQL구조
/*
    select 컬럼명 (5)  -- 필수
    from 테이블 (1)  -- 필수
    where 조건절(필터링) (2)
    group by 그룹핑 (3)
    having 조건절(그룹핑에 대해 필터링) (4)
    order by 정렬기준 (6)
    limit 행수제한 (7)

    1. SELECT : 조회하고자 하는 컬럼명을 기술함. 여러개를 기술하고자 하면 쉼표(,)로 구분하고 모든 컬럼 조회시 '*'을 사용
    2. FROM : 조회 대상 컬럼이 포함된 테이블명을 기술
    3. WHERE :
        행을 선택하는 조건을 기술함.
        여러 개의 제한 조건을 포함할 수 있으며, 각각의 제한 조건은 논리 연산자로 연결함
        제한조건을 만족시키는 행들만 Result Set에 포함됨
    4. ORDER BY : 정렬할 컬럼을 기준으로 오름/내림차순 지정
    5. GROUP BY : 행을 그룹핑함
    6. HAVING : 그룹핑된 행을 선택하는 조건을 기술함
*/

#tbl_menu(메뉴 테이블)dml ahems(*) 컬럼 조회
select
    *
from
    tbl_menu;

# 메튜 테이블에서 메뉴명 ,가격 조회

select
    menu_name, menu_price

from
    tbl_menu;


## 조회되는 컬럼의 연산 가능
# 메뉴 테이블에서 메뉴명, 가격, 부가세 (10%), 부가세거 포함된 전체가격
select
    menu_name,
    menu_price,
    menu_price*0.1,
    menu_price + menu_price*0.1

from tbl_menu;


#============================
# ResulySet : SELECT 조회결과 행의 집합
# 컬럼명 as 별칭 : ResulySet에 표기 되는 컬럼명에 별칭(alias) 부여가능
#============================

select
    menu_name as 메뉴명,
    menu_price as "메뉴 가격", # 쌍따옴표를 이용해서 띄어쓰기된 컬럼 묶기
    menu_price*0.1 부가세, # as 생략 가능
    menu_price + menu_price*0.1
"메뉴 가격(부가세 포함)"

from tbl_menu;



# 산술 연산
select
    10 + 3,
    10 - 3,
    10 * 3,
    10 / 3,
    10 div 3, # python == //(목)
    10 % 3,
    10 mod 3 # % == modulo(나머지)

# 문자열 연결 처리
# 'abc' + 'def' =='abcdef' -> 파이썬에서만 가능
#concat('abc','def' =='abcdef'
# 메뉴 테이블에서 메뉴명, 메뉴 가격(원) 조회
select
    menu_name as "메뉴명",
    concat('금 ',menu_price,'원') as "메뉴 가격(원)"

from
    tbl_menu


# Distinct 컬럼 값 중복 제거
# 지정된 컬럼의 값이 중복되는 행을 제거해서 조회
select
    distinct category_code

from tbl_menu

# ==========================================================
# order by 절
-- 조회 결과(Resultset)의 정렬 순서를 지정하는 구문
-- 특정 컬럼을 기준으로 삼아서 오름차순(ASC), 내림차순(DESC) 지정
-- 기준으로 삼은 컬럼이 여러게 존재하면 그룹화 된 정렬이 수행이 됨.

# 메뉴 테이블을 조회( 가격 오름차순)
select
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_price asc;

# 메뉴 테이블을 조회( 가격 내림차순)
select
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_price desc;

# 문자열(유니코드 순서), 날짜(과거~미래)도 정렬 기준이 될 수 있다.
select
    menu_name
from
    tbl_menu
order by
    menu_name asc;

# Select 절에 작성되지 않은 컬럼도 정렬 기준이 될 수 있다.
select
    menu_name
from
    tbl_menu
order by
    menu_price asc;

# 기준으로 삼은 컬럼이 여러게 존재하면 그룹화 된 정렬이 수행이 됨.
# 메뉴테이블에서 메뉴명, 카테고리코드, 가격을 조회
# 단, 카테고리 코드 오름차순, 가격 내림차순으로 조회
# 1)카테고리 코드 오름차순 정렬 먼저수행
# 2) 같은 카테고리 코드를 지닌 행들끼리 붙어있게 됨
# 3) 같은 카테고리 코드를 지닌 행 내에서 가격 내림차수 정렬 수행
select
    menu_name,
    category_code,
    menu_price
from
    tbl_menu
order by
    category_code asc,
    menu_price desc;

#=======================================
# WHERE 행 필터링
# - 각행별로 제시한 조건을 검사하고, TRUE인 행만 결과집합에 포함시킨다.

# WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과중에 하나 (TRUE/FALSE/NULL)가 됨
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 함

-- --------------------------------------------------------------------------------
-- 연산자                    설명
-- --------------------------------------------------------------------------------
-- =                        같다
-- >,<                        크다/작다
-- >=,<=                    크거나 같다/작거나 같다
-- <>,!=                    같지 않다 (^= 없음)
-- BETWEEN AND                특정 범위에 포함되는지 비교
-- LIKE / NOT LIKE            문자 패턴 비교
-- IS NULL / IS NOT NULL    NULL 여부 비교
-- IN / NOT IN                비교 값 목록에 포함/미포함 되는지 여부 비교
-- --------------------------------------------------------------------------------


# WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&,|| 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR ||    여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참
#=======================================



# 메뉴테이블에서 가격이 13000원 이상인 메뉴의 메뉴코드, 메뉴켱, 가격 조회(내림차순)

select
    menu_code,
    menu_name,
    menu_price

from
    tbl_menu

where
    menu_price >= 13000
order by
    menu_price desc;


# 메뉴테이블에서 카테고리 코드가 10번인 메뉴만 조회
# 카테고리 코드, 메뉴명, 메뉴가격 조회
#메뉴명 오름차순

select
    category_code,
    menu_name,
    menu_price

from tbl_menu

where
    category_code = 10
order by
    menu_name asc;

# 메뉴 테이블에서 가격이 1만원 이상, 2만원 이하인 메뉴의 메뉴명, 가격, 카테고리 코드를 가격 내림차순

select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
   # menu_price >= 10000 and menu_price<= 20000
    menu_price between 10000 and 20000
order by menu_price desc;

# 반대
# 10000원 미만, 20000초과
# menu_price not between 10000 and 20000
select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
   # menu_price < 10000 and menu_price > 20000
    menu_price not between 10000 and 20000
order by menu_price desc;


# 메뉴테이블에서
#카테고리 코드가 4,6,10인 메뉴의 메뉴명, 카테고리코드 조회, 카테고리코드 오름차순
select
    menu_name,
    category_code
from tbl_menu
where
   # category_code = 4 or category_code = 6 or category_code = 10
   # category_code in (4,6,10)
    category_code not in (4,6,10) # 4,6,10 제외
order by category_code asc;

# like
# 문자열 패턴 검사 연산자
#패턴을 나타내는 기호(와일드카드) %, _ 를사용한다.
# '%' : 포함 , 0개 이상
# '_' : 문자 1개(한 칸)
select
    menu_name
from
    tbl_menu
where
    # '아'로 시작하는 메뉴 조회
    #menu_name like '아%';
    #menu_name like '%밥'; #'밥'으로 끝나는 메뉴 조회
    #menu_name like '%마늘%'; #마늘이 포함된 메뉴 조회
    menu_name like '_____'; #메뉴명이 5글자인 메뉴


# =====================================================================
# DB에서 NULL == 저장된 데이터가 없다.
# 비교하는 두 값(data)이 같으면 true
# 카테고리 테이블에서 ref_category_code가 null(data 없음)인 행 조회
select
    *
from
    tbl_category
where
    #ref_category_code 컬럼안에 null이라는 값이 있으면 True
    #-> null은 값(data)가 아님
    #컬럼이 비었음을 나타내는 기호
    #ref_category_code = null #모든행 false
    #ref_category_code is null; #ref_category_code 컬럼 값이 비어있는지 물어보는 것
    ref_category_code is not null; #ref_category_code 컬럼 값이 들어있는지 물어보는 것

#---------------------------------------------------------------
#limit
# - 조회 결과 (Resultset) 에서 지정된 크기만큼의 행만 조회
# limit n : 0번 인덱스(1행) 부터 n행 만큼 조회
# limit start(==offset), n : start(==offset==건너뛰기)행 만큼 건너 뛰고  n행 만큼 조회
select * from tbl_menu;
select * from tbl_menu limit 5;
select * from tbl_menu limit 5, 10;
select * from tbl_menu limit 20, 3;

#페이징 처리 시 limite 사용
# - 메뉴 테이블을 이용해서 메뉴판을 만든다고 하였을 때
# 한 페이지 당 메뉴 4개씩만 조회
# 순서는 메뉴코드 역순

# 1페이지
select * from tbl_menu
order by menu_code desc
limit 0, 4;

# 2페이지
select * from tbl_menu
order by menu_code desc
limit 4, 4;

# 3페이지
select * from tbl_menu
order by menu_code desc
limit 8, 4;


