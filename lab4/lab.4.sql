SELECT ename FROM emp 
WHERE sal=(SELECT MAX(sal) FROM emp);


SELECT e.ename, e.job, e.empno FROM emp e 
WHERE e.job=(SELECT s.job FROM emp s WHERE s.empno=7369) 
AND e.sal>(SELECT sal t FROM emp t 
WHERE t.empno=7876); 


SELECT d.dname, d.deptno FROM dept d 
WHERE d.deptno IN(SELECT deptno FROM emp e WHERE e.job='CLERK');


SELECT ename, sal, deptno FROM emp 
JOIN (SELECT MAX(sal) AS maxsal, dname, AVG(deptno) AS deptno FROM dept d 
JOIN emp e USING (deptno) GROUP BY dname) AS foo USING (deptno) 
WHERE sal=maxsal;


SELECT dname, deptno FROM dept d 
FULL JOIN emp e USING (deptno) 
WHERE empno IS NULL;


SELECT ename, dname FROM emp 
JOIN dept USING (deptno);


SELECT dname, SUM(sal) FROM emp 
FULL JOIN dept USING (deptno) 
GROUP BY dname;


SELECT ename, dname FROM emp 
FULL JOIN dept USING (deptno);


SELECT w.ename, t.ename, t.grade FROM (SELECT * FROM emp e 
JOIN salgrade d ON e.sal BETWEEN d.losal AND d.hisal) AS w 
JOIN (SELECT * FROM emp e JOIN salgrade d ON e.sal BETWEEN d.losal AND d.hisal) AS t 
ON w.mgr=t.empno 
WHERE w.grade=t.grade;


SELECT e.ename, s.ename, e.dname FROM (SELECT * FROM emp 
JOIN dept USING (deptno)) AS e 
JOIN emp s ON e.mgr=s.empno 
WHERE e.deptno=s.deptno;


SELECT DISTINCT job FROM emp 
WHERE comm IS NULL;
 

SELECT DISTINCT least (e.ename, s.ename) AS eename, greatest (e.ename, s.ename) AS sename FROM emp e 
JOIN emp s USING (mgr) 
WHERE e.ename<>s.ename 
ORDER BY eename;


SELECT * FROM (SELECT * FROM emp e WHERE job='MANAGER') AS manager 
JOIN (SELECT e.mgr, COUNT(*) AS how_many FROM emp e 
JOIN emp s ON e.mgr=s.empno 
GROUP BY e.mgr) AS mgr_count 
ON manager.empno=mgr_count.mgr 
WHERE how_many=1;


(SELECT MAX(average), MIN(average) FROM (SELECT deptno, AVG(sal) AS average FROM emp e 
GROUP BY (deptno)) AS averages);
