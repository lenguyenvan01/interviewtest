--create table BSSexam (
--	agency varchar
--	,link_on_clutch varchar
--	,short_des varchar 
--	,website_link varchar
--	,rating float
--	,review_count varchar
--	,project_price varchar
--	,hourly_rate varchar
--	,staff varchar
--	,location varchar
--	,service_focus varchar 
--	,top_review_des varchar
--	,top_review_owner varchar
--)

--select * from bssexam b 

--copy bssexam from 'C:\Users\Public\Clutch.csv' delimiter ',' csv header

--rating trung binh cua cac agency co service focus vao web dev >= 50%

select avg(rating) 
from bssexam b
where substring(service_focus,1,length(service_focus)-17)::float >=50;


--Tong so review cua cac agent den tu Ukraine va  co staff >= 50
with location_1 as (
	select right(location,position(',' in reverse(location))-2) as location_1
	from bssexam
)
select * from location_1


-- Tach so trong review_count
with reviewcount as(
	select left(review_count,position('re' in review_count)-2)::int as reviewcount 
	from bssexam
)

select * from reviewcount

-- Xem cac TH xay ra de dua vao case when
select distinct staff
from bssexam b 
--
with staff_value as (
	select *, 
	(case
		when staff = '2-9' then 9
		when staff = '10-49' then 49
		when staff = '50 - 249' then 249
		when staff = '250 - 999' then 999
		when staff = '1,000 - 9,999' then 9999
		when staff = '10,000+' then 10000
		else 1
	end) as staff_value
from bssexam b
)

select sum(left(review_count,position('re' in review_count)-2)::int) 
from staff_value
where staff_value >=50
and right(location,position(',' in reverse(location))-2) = 'Ukraine' -- and location like '%Ukraine'
