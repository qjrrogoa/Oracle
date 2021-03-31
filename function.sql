create or replace function getsum(num1 number, num2 in number)
            --반환타입 정의
            return number  --자리수 지정, 세미콜론 X
            --함수 시작
            is
            --변수 선언
                hap number :=0;
            begin
                for i  in num1 .. num2 loop
                    hap := hap + i;
                end loop;
             return hap;
            end;
            /

            --호출 2가지 방법
            select getsum(1,10)
            from dual;

            var hap number;
            exec :hap := getsum(1,10)
            print hap;



            create or replace function get(en_ varchar2)
            return varchar2
            IS
            begin
               return  RPAD(substr(en_,1,1),length(en_),'*');
            end;
            /

            var ename_ varchar2;
            exec :ename_ := get('abcde')
            print ename_;

            select ename,get(ename)
            from emp;
            
            
            
            create or replace function getday(en_ date)
            return varchar2
            IS
            begin
               return  to_char(en_,'yyyy-mm-dd');
            end;

            select getday('21-08-13')
            from dual;

            select hiredate,getday(hiredate)
            from emp;
