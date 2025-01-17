-- 국가별 테러 수 집계
select country_txt, count(*) as cnt 
from myterror
group by country_txt
order by cnt desc ;

-- 임시 테이블 생성(CTAS 문법)
-- drop table country_summary ;
create table country_summary
as
select country_txt, count(*) as cnt 
from myterror
group by country_txt
order by cnt desc ;

select * from country_summary ;

-- 랭킹 컬럼 만들기
select country_txt, cnt, rank() over ( order by cnt desc ) as ranking
from country_summary ;

-- 상위 10개만 추려 내기
-- drop table country_summary_top_10
-- drop table country_summary_top_10;
create view country_summary_top_10
as 
select country_txt, cnt
from ( 
		select country_txt, cnt, rank() over ( order by cnt desc ) as ranking
		from country_summary 
	)
where ranking <= 10 ;


-- 상위 10개 국가
select * from country_summary_top_10  ;

-- 년도별 국가 집계
select country_txt, iyear, count(*) as cnt 
from myterror
group by country_txt, iyear
order by cnt desc, iyear asc ;

-- 관리자가 뷰 생성 권한 부여
grant create view to scott ;

-- 3개국(Iraq, Pakistan, Afghanistan) 년도별 국가 집계
-- 뷰 three_conunty를 작성하시오.
-- drop view three_conunty;
create or replace view three_country
as
select country_txt, iyear, count(*) as cnt 
from myterror
where country_txt in('Iraq', 'Pakistan', 'Afghanistan')
group by country_txt, iyear
order by country_txt desc, iyear asc ;

-- 뷰 조회
select * from three_country ;

-- 년도/월별 국가 집계
select country_txt, iyear, imonth, count(*) as cnt
from myterror
group by country_txt, iyear, imonth
order by country_txt desc, iyear asc, imonth asc ;


-- 월별 국가 집계
select country_txt, imonth, count(*) as cnt
from myterror
group by country_txt, imonth
order by country_txt desc, imonth asc ;

-- 분기별 국가 집계
drop table bungi ;
create table bungi
as
select country_txt, 
case imonth 
	when 1 then '일사분기'
	when 2 then '일사분기'
	when 3 then '일사분기'
	when 4 then '이사분기'
	when 5 then '이사분기'
	when 6 then '이사분기'
	when 7 then '삼사분기'
	when 8 then '삼사분기'
	when 9 then '삼사분기'
	when 10 then '사사분기'
	when 11 then '사사분기'
	when 12 then '사사분기'
end as result
from myterror ;

-- 국가별, 분기별 집계
select country_txt, result, count(*) as cnt
from bungi
group by country_txt, result
order by cnt desc ;

-- 아프카니스탄과 알제리만 보겠다
select country_txt, result, count(*) as cnt
from bungi
where country_txt in('Algeria', 'Afghanistan')
group by country_txt, result
order by country_txt, result ;

select country_txt, result
from bungi
where country_txt = 'Afghanistan'
and result = '일사분기' ;

-- 국가 상관 없이 분기별 집계
create or replace view bungiview
as 
select result, count(*) as cnt
from bungi
group by result
order by cnt desc ;

-- 분기 뷰 조회
select * from bungiview ;