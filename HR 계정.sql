SELECT e1.ename ||'의 매니저는 '||e2.ename ||'입니다'
FROM emp e1 join emp e2 on e1.mgr = e2.ename