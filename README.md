# Oracle

# DDL
# TABLE

1] 생성 방법
---
    Create tabel 테이블명{
     컬러명1 자료형1 [not null],
     컬러명2 자료형2 [not null]

2] 테이블 이름 미 컬러 명명규칙
---
  - 문자로 시작한다
  
  - 30자 이내로 지정 한다
  
  - 대소문자를 구별하지 않는다

  - 동일하 이름으 사용할 수 없다. 또하 예역어도 사용할 수 없다

3] 테이블 제약 조건
---
[1] 기본키(pk) (Not Null + Unique)

  - 참조무결성을 유지하기 위해 제약조긴이다

  - 하나의 테이블에느 하나의 pkaks whswogksek.

  - PK로 설정되면 그 칼럼은 값이 중복되거나 NULL을 허용하지 않는다.

[2] NOT NULL

  - NULL값을 절대로 허용하지 않는 컬럼
  
[3] UINQUE 

  - 중복을 허용하지 않는다. NULL은 허용한다(여러번)

[4] DEFAULT

[5] FK 

  - 컬럼 옆에 
  
  - creat문 마지막에

4] Check
---
  - WHERE절 이라고 생각하면 된다.
    
        create table chktbl(
        col1 number primary key,
        col2 Char(1) constraint chk_chktbl_col2 check(col2 IN ('F','M')),
        col3 number check(col3 >= 100 and col3 <= 200),
        col4 date check(col4 >= To_DATE('2021-02-24' and col4 <= TO_DATE('2021-08-23)),
        col5 char(14) check(regexp_like(col5,'^[0-9]{6}-[1-4]{7}$');

5] 테이블 변경
---
  - 안하는게 낫다,

  - 테이블 구조와 데이터는 그대로 복사되지만, 제약조건(pk,fk,unique등)은 복사가 안된다.

        Create table emp_copy
        as 
        select empno, ename, sal, job, hiredate, deptno
        from emp

6] Alter
---
  - 새로운 칼럼, 제약조건 추가

        Alter Table 테이블명 Add 컬럼명 자료형 Not Null    //가장 위험하다 칼럼 not null 하려면 그 행 다 지워야 한다,,
        alter table emp_copy add comm number(6,2)
        alter table emp_copy add constraint PK_emp_copy primary key(empno)
        alter table emp_copy drop constraint PK_emp_copy;
        alter table emp_copy drop column comm;
        alter table emp_copy modify empno NUMBER(2)  // 컬럼 자료형 바꿀때 반드시 더 큰 자료형으로 바꿔야 한다. 
        원본 데이터는 number(4) 2로바꾸면 오류 6을 바꾸면 성공
        alter table emp_copy rename column sal to salary // sal -> salar로 칼럼 명 변경
        rename emp_copy to EMP2    // 테이블 명 변경
 
 7] DROP 
 ---
  - 부모 테이블은 삭제가 안된다 (삭제하려면 함수 다름)

        Drop table emp2 // emp2 삭제
        Flashback table emp2 to before drop // 삭제한 테이블 복원
        Drop table emp2 pudge // 복원 불가능 완전 삭제
        
        Drop table 부모테이블 Cascade constraint // 부모 테이블 삭제
        
# 시퀀스

 - 테이블의 필드에 일련번호 부여
 - 테이블 생성 후 시퀀스(일련번호)를 따로 만들어야 한다.

      
# DCL
# select

1]  || : 문장과 열 합칠 때
  
2]  '' : 문장
  
3]  AS : 별칭 (생략 가능)
---
    SELECT ename || '의 연봉은 ' || sal
    FROM emp;
    
    SELECT sal * 1.5 AS 연봉, sal
    FROM emp;
    
    SELECT sal * 1.5 연봉, sal
    FROM emp; //"" 생략 가능
    
    SELECT sal * 1.5 2021년의 연봉, sal
    FROM emp; //오류 별칭에 빈 공백이 나와서
    
    SELECT sal * 1.5 "2021년의 연봉", sal
    FROM emp; //" " 로 감싸줘면 된다.
    
    SELECT sal * 1.5 "2021's 연봉", sal //'를 사용하고 싶으면 무조건 "" 넣어야한다.
    FROM emp; 
    
    SELECT ename || '의 연봉은' || sal || '입니다.'.
    FROM emp;
    // 셀 이름이 ename || '의 연봉은' || sal || '입니다.'.   
 
    SELECT ename || '의 연봉은' || sal || '입니다.' 연봉
    FROM emp;
    // 셀 이름이 연봉
  
4] distinct : 중복행 제거 (키워드는 항상 SELECT 바로 다음에 기술한다.)
---
모든 칼럼이 영향 받는다.
    
    SELECT DISTINCT job 
    FROM emp; 
    
    SELECT DISTINCT job.deptno // 칼럼.칼럼 => & 연산
    FROM emp;

  
5] where절 : 특정행의 검색
---
  and, or, not은 그대로 기술
  
  Between a and b, in, like
    
    SELECT ename, sal
    FROM emp
    WHERE sal >=2000;

    SELECT enam, sal, job
    FROM emp
    WHERE sal >= 1500 and jab = 'SALESMAM'
    
    SELECT enam, sal, job
    FROM emp
    WHERE sal >= 1500 or jab = 'SALESMAM'
    
    SELECT ename, sal, job
    FROM emp
    WHERE jab <> 'SALESMAM';
    
    SELECT ename,sal
    FROM emp
    WHERE sal Between 2000 and 3000;
    
    SELECT ename,sal
    FROM emp
    WHERE sal >= 2000 and sal <= 3000;
    
    SELECT SYSDATE+1 //날짜 더하기 가능! Java는 안된다.
    FROM dual;
    
    SELCET ename.sal.hiredate
    FROM emp
    WHERE hiredate BETWEEN TO_DATE('81/01/01') AND TO_DATE('81/12/31') AND sal >= 2000;
    
    SELCET ename.sal.hiredate
    FROM emp
    WHERE hiredate BETWEEN '81/01/01' AND '81/12/31' AND sal >= 2000;
    
    SELECT empno,ename,job
    FROM emp
    WHERE job in('SALESMAN','CLERK');
    
    SELECT ename, job, deptno
    FROM emp
    WHERE (job,deptno) in (('CLERK',20),('SALESMAN',30))
    
    //위에거랑 똑같이 고급
    SELECT ename, job, deptno
    FROM emp
    WHERE job = 'CLERK' and deptno=20 or job='SALESMAN' and deptno=30
    
6] Like 연산자 : 검색 스트링 값에 대한 와일드 카드 검색
---
% : 임의의 0개이상의 문자열

_ : 임의의 한 글자
    
    SELECT ename
    FROM emp
    WHERE ename LIKE 'S%';
    
    SELECT ename
    FROM emp
    WHERE ename LIKE '%S';
    
    SELECT ename
    FROM emp
    WHERE ename LIKE '%A%';
    
    SELECT ename
    FROM emp
    WHERE ename LIKE '_A%';
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NULL;
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NOT NULL;
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NOT NULL and comm != 0;
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NOT NULL and NOT comm = 0;
    
    //문1
    SELECT empno, ename, job, sal
    FROM emp
    WHERE job = 'MANAGER' and sal Between 2500 and 3000;

    //문2
    SELECT ename,deptno sal, job
    FROM emp
    WHERE job != 'SALESMAN' and deptno = 30 and sal>=1500;
    
    //문3
    SELECT *
    FROM emp
    WHERE deptno in ('20','30') and sal < 2000;
    
    //문4
    SELECT *
    FROM emp
    WHERE comm IS NOT NULL and sal >= 1500;
    
    //문5
    SELECT FIRST_NAME || ' ' || LAST_NAME "성명", COMMISSION_PCT,SALARY
    FROM employees
    WHERE COMMISSION_PCT IS NOT NULL and SALARY >= 5000 and LAST_NAME LIKE 'S%'
    
    //문6
    SELECT FIRST_NAME || ' ' || LAST_NAME "성명", COMMISSION_PCT,SALARY
    FROM employees
    WHERE COMMISSION_PCT IS NOT NULL and SALARY >= 5000 and LAST_NAME LIKE '_a%'
    
    //문7
    SELECT FIRST_NAME || ' ' || LAST_NAME "성명", COMMISSION_PCT,SALARY
    FROM employees
    WHERE phone_number LIKE '011%'

7] Order By 절 사용한다
---
  
    SELECT ename, job, sal
    FROM emp;
    ORDER BY sal;
    
    SELECT ename, job,deptno
    FROM emp;
    ORDER BY job DESC, deptno;
    
    //문8
    SELECT *
    FROM emp
    ORDER BY sal DESC;
    
    //문9
    SELECT name, deptno, sal, comm
    FROM emp
    WHERE comm >= 100
    ORDER BY sal;
    
    //문10
    SELECT *
    FROM emp
    WHERE ename LIKE '%A%'
    ORDER BY sal,depto DESC;
    
8] Gropu by절
---
그룹함수는 Select문에서 단독으로 쓸 수 있으나, 다른 칼럼정보를 함께 출력할 수 없다.

Select절에서 group by절 이외 모든 컬럼 group by 해야한다.

ORDER BY절 전에 기술해야 한다

그룹에 대한 조건은 HAVING절에서 기술해야 한다.

쿼리 실행 순서 : FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
  
     SELCECT count(sal)
     FROM emp;
     
     SELCECT avg(sal)
     FROM emp; 
     
     SELCECT sum(sal)
     FROM emp;
     
     SELCECT max(sal)
     FROM emp;
     
     SELECT job,MAX(sal)
     From emp;
     Group by job;
     
     SELECT deptno,job,min(sal)
     FROM emp
     GROUP BY deptno, job;
     
     SELECT deptno,min(sal)
     FROM emp
     GROUP BY deptn;
     
     SELECT deptno,min(sal)
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno;
     //순서가 Where -> Gruop by
  
9] HAVING절 
---
GROUP BY절에 대한 조건

     SELECT deptno,min(sal)
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno
     HAVING min(sal) >= 2000;
     
     SELECT deptno,min(sal) 최소연봉 // (4) 별칭
     FROM emp // (1)
     WHERE sal >= 1000 // (2)
     GROUP BY deptno // (3)
     ORDER BY 최소연봉; // (5)
     
     
     SELECT deptno,min(sal) 최소연봉
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno
     HAVING 최소연봉 >= 1000
     ORDER BY 최소연봉;
     //오류난다  why? HAVING절이 SELECT절보다 먼저 읽는다. 최소연봉이라는 별칭이 들어오기전에 HAVING함
     
     SELECT deptno,min(sal) 최소연봉
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno
     HAVING min(sal) >= 1000
     ORDER BY 최소연봉; 
     //가능하다
     
     //문11
     SELECT count(*)
     FROM emp
     WHERE sal>=1000 and ename LIKE '%S';
  
# join

1] inner join
---

2개 이상의 테이블로부터 자료를 검색하기 위해서 Join을 사용한다.

일반적으로 pk와 fk을 사용하여 join하는 경우가 대부분

가장 많이 사용되는 조인문으로 테이블 간에 연결 조건을 모두 만족하는 행을 검색하는데 사용한다

검색시 검색되는 컬럼이 조인하는 테이블 모두에 존재한다면 반드시 컬럼명에 테이블 이름을 "테이블명.컬럼명'의 형태로 기술

자식테이블 레코드 10개, 부모테이블 레코드 100개 inner join하면 레코드 수는 10개
PK : 중복 X, Null X

테이블 칭을 명부여하여 긴 테이블 명을 간단하게 사용 (as 사용 불가)

    [정규 표현]
    SELECT 칼럼명
    FROM 테이블1 join 테이블2 On 테이블1.pk = 테이블2.fk
    join 테이블3 on 테이블2.pk = 테이블3.fk

    SELECT ename,sal,job,dname
    FROM emp e JOIN dept d ON e.deptno = d.deptno;

2] outer join
---
어느 한쪽 테이블에서 결과값을 모두 가져오는 join문이다.

어느 쪽 테이블에서 가져올지 즉 왼쪽인지 오른쪽인지 아니면 양쪽 테이블인지 반드시 기술해야 한다.

자식테이블 left outer join 부모테이블은 ineer join과 같다

RDMS는 full outer join 의미가 없다.

자식에 없는 부모 튜플도 outer join으로 알 수 있다. 
      
        SELECT 부모테이블 칼럼
        FROM 부모테이블 부 left outer join 자식테이블 자 on 부.pk = 자.fk;
        WHERE 자.pk is null


3] self join
---

# 서브쿼리 (SUBQUERY)

서브쿼리는 다른 하나의 SQL문장에 기술된 SELECT문장을 말한다

서브쿼리는 괄호로 묶어야 한다.

서브쿼리만을 단독 실행시 실행이 된다.

서브쿼리는 연산자의 오른쪽에 기술 되어야 한다.

단일행 서브 쿼리에는 단일행 연산자를 다중행 서브쿼리에는 복수행 연산자를 사용한다

서브쿼리는 SELECT, FROM, WHERE절 등에 위치할 수 있다

FROM절 서브쿼리를 쓸 때 SELECT이랑 칼럼이 같거나 더 커야함


    //문12
    SELECT sal, ename, job
    FROM emp
    where sal in ((select max(sal) from emp), (select min(sal) from emp))
    order by sal  
    
    //문13
    SELECT ename, sal, d.deptno, dname, hiredate
    from dept d join emp e on d.deptno = e.deptno
    where (e.deptno,sal) in (select e.deptno, max(sal) from emp e group by e.deptno)


# TOP쿼리

반드시 정렬되어야 한다

얻어진 질의 결과에서 위에서부터 순서대로 몇 개만 가져오는 경우에 사용함

데이터가 입력된 순서대로 혹은 서브쿼리에 의해 생성된 테이블에 레코드가 생성된 순서대로 내부적으로 번호가 순차적으로 부여되고 그 부여된 번호는 ROWNUM이라는 컬럼에 내부적으로 저장되어 있다.

    기본 구조
    Select * 
    from (select * from 테이블명 order by PK컬러명)
    where rownum <= n;
  
    select ename, sal, job
    from (select * from emp order by sal desc)
    where rownum <=3

1] 특정 구간에 있는 레코드
---

STEP 1] 서브쿼리안의 서브쿼리는 특정 컬럼으로 ORDER BY DESC 그리고 생성된 테이블 별칭을 부여

STEP 2] 서브쿼리안의 SELECT절에서 STEP1의 별칭.*,ROWNUM 컬럼별칭을 기술한다

STEP 3] 밖의 WHERE절에서 ROWNUM을 별칭한 이름으로 between a and b


혹시 top로 구해서 Not in 구하면 되는지,,
    SELECT * 
    FROM (SELECT T.*, ROWNUM R FROM(SELECT * FROM emp ORDER BY sal DESC)T)
    WHERE R BETWEEN 4 AND 6
    
    SELECT LAST_NAME || ' ' || FIRST_NAME name , SALARY, department_name, city
    FROM(SELECT T.*,ROWNUM R FROM(SELECT * FROM employees ORDER BY salary desc)T)e
    join departments d on e.department_id = d.department_id 
    join locations l on d.location_id = l.location_id
    WHERE R BETWEEN 11 and 20
    
    SELECT ename, sal, e.deptno, dname, hiredate
    FROM(SELECT T.*,ROWNUM R FROM(select * from emp order by sal)T)e
    join dept p on e.deptno = p.deptno
    WHERE R between 6 and 10
    

