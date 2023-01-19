
SELECT * FROM sharktankdatabase.st;

-- total episodes

select max(Epno) from sharktankdatabase.st
select count(distinct epno) from sharktankdatabase.st

-- pitches 

select count(distinct brand) from sharktankdatabase.st

--pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from sharktankdatabase.st) a

-- total male

select sum(male) from sharktankdatabase.st

-- total female

select sum(female) from sharktankdatabase.st

--gender ratio

select sum(female)/sum(male) from sharktankdatabase.st

-- total invested amount

select sum(amountinvestedlakhs) from sharktankdatabase.st

-- avg equity taken

select avg(a.EquityTaken) from
(select * from sharktankdatabase.st where EquityTaken>0) a

--highest deal taken

select max(amountinvestedlakhs) from sharktankdatabase.st

--higheest equity taken

select max(EquityTaken) from sharktankdatabase.st

-- startups having at least women

select sum(a.female_count) startups having at least women from (
select female,case when female>0 then 1 else 0 end as female_count from sharktankdatabase.st) a

-- pitches converted having atleast ne women

SELECT * FROM sharktankdatabase.st;


select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from sharktankdatabase.st where deal!='No Deal')) a)b

-- avg team members

select avg(teammembers) from sharktankdatabase.st

-- amount invested per deal

select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from sharktankdatabase.st where deal!='No Deal') a

-- avg age group of contestants

select avgage,count(avgage) cnt from sharktankdatabase.st group by avgage order by cnt desc

-- location group of contestants

select location,count(location) cnt from sharktankdatabase.st group by location order by cnt desc

-- sector group of contestants

select sector,count(sector) cnt from sharktankdatabase.st group by sector order by cnt desc


-- partner deals

select partners,count(partners) cnt from sharktankdatabase.st  where partners!='-' group by partners order by cnt desc

-- making the matrix


select * from sharktankdatabase.st

select 'Ashnner' as keyy,count(AshneerAmountInvested) from sharktankdatabase.st where AshneerAmountInvested is not null


select 'Ashnner' as keyy,count(AshneerAmountInvested) from sharktankdatabase.st where AshneerAmountInvested is not null AND AshneerAmountInvested!=0

SELECT 'Ashneer' as keyy,SUM(C.AshneerAmountInvested),AVG(C.AshneerEquityTaken) 
FROM (SELECT * FROM sharktankdatabase.st  WHERE AshneerEquityTaken!=0 AND AshneerEquityTaken IS NOT NULL) C


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(AshneerAmountInvested) total_deals_present from sharktankdatabase.st where AshneerAmountInvested is not null) a

inner join (
select 'Ashneer' as keyy,count(AshneerAmountInvested) total_deals from sharktankdatabase.st
where AshneerAmountInvested is not null AND AshneerAmountInvested!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.AshneerAmountInvested) total_amount_invested,
AVG(C.AshneerEquityTaken) avg_equity_taken
FROM (SELECT * FROM sharktankdatabase.st  WHERE AshneerEquityTaken!=0 AND AshneerEquityTaken IS NOT NULL) C) n

on m.keyy=n.keyy
/*not working*/
-- which is the startup in which the highest amount has been invested in each domain/sector




select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from sharktankdatabase.st) c

where c.rnk=1