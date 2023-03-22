SELECT * FROM sharktankdatabase.st;

SELECT * FROM sharktankdatabase.st;

-- total episodes
select count(distinct epno) as Total_Episodes from sharktankdatabase.st;

-- pitches / Unique_brands
select count(distinct brand) as Pitches from sharktankdatabase.st;

-- pitches converted 
select sum(a.converted_not_converted) as converted_pitches, count(*) as Total_pitches from (
select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as
 converted_not_converted from sharktankdatabase.st) a;

-- total male
select sum(male)as Total_male from sharktankdatabase.st;

-- total female
select sum(female) as Total_female from sharktankdatabase.st;

-- gender ratio
select sum(female)/sum(male) as Gender_ratio from sharktankdatabase.st;

-- total invested amount
select sum(amountinvestedlakhs) from sharktankdatabase.st;

-- avg equity taken
select avg(a.EquityTaken) from
(select * from sharktankdatabase.st where EquityTaken>0) a;

-- highest deal taken
select max(amountinvestedlakhs) from sharktankdatabase.st;
select * from sharktankdatabase.st where amountinvestedlakhs = (select max(amountinvestedlakhs) from sharktankdatabase.st);

-- highest equity taken
select max(EquityTaken) from sharktankdatabase.st;
select * from sharktankdatabase.st where EquityTaken = (select max(EquityTaken) from sharktankdatabase.st);

-- startups having at least women
select sum(a.female_count) startups_having_at_least_women from (
select female,case when female>0 then 1 else 0 end as female_count from sharktankdatabase.st) a;

-- pitches converted having atleast one women
select sum(b.female_count) from(
select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from sharktankdatabase.st where deal!='No Deal')) a)b;

-- avg team members
select avg(teammembers) from sharktankdatabase.st;

-- amount invested per deal
select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from sharktankdatabase.st where deal!='No Deal') a;

-- avg age group of contestants
select avgage,count(avgage) cnt from sharktankdatabase.st group by avgage order by cnt desc;

-- location group of contestants
select location,count(location) cnt from sharktankdatabase.st group by location order by cnt desc;

-- sector group of contestants
select sector,count(sector) cnt from sharktankdatabase.st group by sector order by cnt desc;


-- partner deals
select partners,count(partners) cnt from sharktankdatabase.st  where partners!='-' 
group by partners order by cnt desc;

-- startup in which the highest amount has been invested in each domain/sector
select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 
from sharktankdatabase.st) c
where c.rnk=1;

select sum(c.amountinvestedlakhs) Total_invested,c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 
from sharktankdatabase.st) c
where c.rnk=1 group by c.sector order by Total_invested desc;