-- SET OPERATOR -- 
-- 합집합
-- UNION : 중복되는 부분을 제거하여 합친다.
-- UNION ALL : UNION과 동일하나 중복되는 결과를 그대로 보여준다.
-- 교집합
-- INTERSECT : 겹치는 결과만 조회
-- 차집합
-- MINUS : 두 개 이상의 테이블 정보 중 제일 앞에 선언된 결과를 기준으로 중복을 제외한 앞테이블의 결과만을 조회

-- JOIN --
-- JOIN : 두 개 이상의 테이블의 결과를 하나의 테이블 형태로 합쳐서 사용하는 방법
-- INNER JOIN : 합치려는 테이블의 데이터를 각각 모두 일치하는 정보만 연결지어 조회

-- OUTER JOIN 
-- 				LEFT : 좌측 테이블의 정보를 모두 포함
--				RIGHT : 우측 테이블의 정보를 모두 포함
--				FULL : 양측 테이블의 정보를 모두 포함

--CROSS JOIN, SELF JOIN, 다중 JOIN

-- SUB QUERY : 메인쿼리 안에 또 하나의 쿼리를 추가

-- 인라인 뷰
-- FROM 위치에 사용되는 서브쿼리
-- 서브쿼리의 RESULT SET을 활용하여 데이터를 조회할 때 사용 할 수 있다.
-- 이 때 기존의 테이블을 대체한다는 의미에서 FROM 구문의 서브쿼리를 Inline View라고 부른다.

-- 마치 데이터의 일부분만 가져와서 조회하는 느낌
SELECT *
FROM (
				SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
				FROM EMPLOYEE
				JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID )
				JOIN JOB USING(JOB_CODE));

-- TOP-N 분석 조회
-- 맛있는 음식 상위 5개
-- 가장 많이 팔린 아이스크림 6개
-- 가장 조건에 부합하는 내용을 순위화하여 특정 순번까지 조회하는 방식

-- ROWNUM : 데이터를 조회할 때 각 행의 번호를 매겨주는 함수
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <6;

-- 연습
-- 급여기준으로 가장 높은 급여를 받는 사원
-- 상위 5명 조회하여 사번, 사원명, 급여를 출력
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM (SELECT EMP_ID, EMP_NAME, SALARY 
				FROM EMPLOYEE
				ORDER BY 3 DESC)
WHERE ROWNUM < 6;

-- 강사님 버전 (INLINE VIEW)
SELECT ROWNUM, A.*
FROM (SELECT EMP_ID, EMP_NAME, SALARY 
				FROM EMPLOYEE
				ORDER BY 3 DESC) A
WHERE ROWNUM < 6;

-- RANK() : 순위를 매기는 함수 <==> DENSE_RANK() : 순위를 매기는 함수																
-- 1															1
-- 2															2
-- 2															2
-- 4															3

-- RANK()
SELECT EMP_NAME, SALARY,
				RANK() OVER(ORDER BY SALARY DESC)  "순위"
FROM EMPLOYEE;

-- RANK()에서 순위에 조건을 걸 경우
SELECT * 
FROM (SELECT EMP_NAME, SALARY,
				RANK() OVER(ORDER BY SALARY DESC)  "순위"
				FROM EMPLOYEE)
WHERE 순위 <4;

--DENSE_RANK()
SELECT EMP_NAME, SALARY,
			DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE

-- 실습 5.
-- EMPLOYEE 테이블에서 보너스를 포함한 연봉이 가장 높은 사원 상위 5명을 RANK()함수를 활용하여 조회
-- 사번, 사원명, 부서명, 직급명, 입사일, 연봉(보너스 포함)
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE, (SALARY + (SALARY*NVL(BONUS,0)))*12 "연봉",
							RANK() OVER(ORDER BY (SALARY + (SALARY+NVL(BONUS,0)))*12 DESC)"순위" 
			FROM EMPLOYEE, DEPARTMENT
			WHERE EMPLOYEE.DEPT_CODE  = DEPARTMENT.DEPT_ID 
			)
WHERE 순위 < 6;

-- 강사님 버전 
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE, (SALARY + (SALARY*NVL(BONUS,0)))*12 "연봉",
							RANK() OVER(ORDER BY (SALARY + (SALARY*NVL(BONUS,0)))*12 DESC)"순위" 
			FROM EMPLOYEE, 
			JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID )
			JOIN JOB USING(JOB_CODE))
WHERE 순위 < 6;

-- WITH AS 구문
-- 동일한 서브쿼리를 중복해서 사용할 때 이를 별칭화하여 사용하도록 하는 구문
-- 사용형식 : WITH 별칭 AS(서브쿼리)
-- **인라인 뷰에서만 가능
--선언을 하고 다음 메인쿼리에서 사용 가능( WITH AS 괄호 다음에 오는 구문)
WITH TOP_N_SAL AS (
					SELECT EMP_NAME, SALARY
					FROM EMPLOYEE
					ORDER BY SALARY DESC
) SELECT *
	FROM TOP_N_SAL;
SELECT * FROM TOP_N_SAL;


-- 부서 별 급여 합계가 전체 부서 급여 총합의 20%보다 많은 부서의 부서명과 부서급여 합계를 조회   
-- (잘 안된듯)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY)  > (SELECT SUM(SALARY) 
												FROM EMPLOYEE);

-- 2) 인라인 뷰 활용하여 해결
-- 서브쿼리
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE

-- 인라인 뷰
SELECT DEPT_CODE, SUMSAL
FROM (SELECT DEPT_CODE, SUM(SALARY) SUMSAL
				FROM EMPLOYEE
				GROUP BY DEPT_CODE)
WHERE SUMSAL > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

-- 3) WITH AS를 이용
WITH TOPSAL 
AS(SELECT DEPT_CODE, SUM(SALARY) SUMSAL
		FROM EMPLOYEE
		GROUP BY DEPT_CODE
)SELECT DEPT_CODE , SUMSAL
FROM TOPSAL
WHERE SUMSAL > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

-- WITH AS 여러개 등록하여 사용
WITH SUM_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
			AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT *
FROM SUM_SAL
UNION ALL
SELECT *
FROM AVG_SAL
UNION ALL
SELECT *
FROM SUM_SAL;


-- 상호 연관 쿼리 : 상관 쿼리
-- 일반적으로 서브쿼리는 서브쿼리, 메인쿼리는 서브쿼리의 결과만 받아서 실행하는 방식과 다르게
-- 메인쿼리가 사용하는 컬럼값, 계산식 등을 서브쿼리에 적응하여 서브쿼리 실행 시 메인 쿼리의 값도 함께 사용하는 방식

-- 사원의 직급에 따른 급여 평균 보다 많이 받는 사원의 정보를 조회
SELECT JOB_CODE, TRUNC(AVG(SALARY),-3)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY)
									FROM EMPLOYEE E2
									WHERE E.JOB_CODE  = E2.JOB_CODE
									--직급이 같은 애들을 조회해서 그것의 평균을 구하자 ...
									);
									
-- 스칼라 서브쿼리
-- 단일행 + 상호 연관 서브쿼리
-- SELECT, WHERE, ORDER BY 절에 사용
-- 보통은 SELECT에서 많이 사용하기 때문에 SELECT LIST라고도 한다.

								
-- 연습2
-- 모든 사원의 사번, 사원명, 관리자 사번, 관리자명을 조회하되, 관리자가 없을 경우 '없음'이라고 표시하시오.
-- 단, SELECT문에 서브쿼리를 삽입하는 형식으로 구현
SELECT EMP_ID,
				EMP_NAME,
				MANAGER_ID,
				NVL((SELECT EMP_NAME FROM EMPLOYEE M 
							WHERE E.MANAGER_ID = M.EMP_ID),'없음') 관리자이름
FROM EMPLOYEE E
ORDER BY 관리자이름,EMP_ID;

-- 데이터 사전
-- 데이터 베이스안에서 사용자 정보등을 설정을 관리하는 테이블

-- SELECT 시에 참고해야 하는 정보
-- 테이블 : 표, 행과 열로 이루어져 있다. 특정 데이터들을 저장하는 데이터베이스의 객체





















