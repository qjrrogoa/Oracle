# Oracle

# 기본

1] 
---
DDL
DML
DCL


2]
---
[1] select
  || : 문장과 열 합칠 때
  '' : 문장 
  AS : 별칭
  
    SELECT ename || '의 연봉은 ' || sal
    FROM emp;
    
    SELECT sal * 1.5 AS 연봉, sal
    FROM emp;
