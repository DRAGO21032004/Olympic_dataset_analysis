--How many olympics games have been held?
select count(distinct games) as tot_olympic_games from olympic_history;

--List down all Olympics games held so far.
select year,season,city from olympic_history
group by year,season,city
order by year;

--Mention the total no of nations who participated in each olympics game?
select games,count(distinct team) as tot_no_of_nations from olympic_history
group by games;

--Which year saw the highest and lowest no of countries participating in olympics?
WITH country_count AS (
    SELECT year, COUNT(DISTINCT team) AS num_countries
    FROM olympic_history
    GROUP BY year
)
SELECT year, num_countries 
FROM country_count
WHERE num_countries = (SELECT MAX(num_countries) FROM country_count)
UNION
SELECT year, num_countries 
FROM country_count
WHERE num_countries = (SELECT MIN(num_countries) FROM country_count);

--Identify the sport which was played in all summer olympics.
SELECT sport,COUNT(DISTINCT games) as count__
FROM olympic_history
WHERE season = 'Summer'
GROUP BY sport
HAVING COUNT(DISTINCT games) = (SELECT COUNT(DISTINCT games) FROM olympic_history WHERE season = 'Summer');

--Which Sports were just played only once in the olympics?
select sport,count(distinct games) as sport_count from olympic_history
group by sport
having count(distinct games)=1;
--Fetch the total no of sports played in each olympic games.
select games,count(distinct sport) as tot_no_of_sports from olympic_history
group by games;
--Fetch details of the oldest athletes to win a gold medal.
select name,cast(case when age = 'NA' then '0' else age end as int) as age
from olympic_history
where medal='Gold'
order by age desc
limit 1;

--Fetch the top 5 athletes who have won the most gold medals.
select name ,count(medal) as med_count from olympic_history
where medal='Gold'
group by medal,name
order by med_count desc
limit 5;
--Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
select name,count(medal) as med_count from olympic_history
where medal='Gold' or medal='Bronze' or medal='Silver'
group by name
order by med_count desc
limit 5;

--List down total gold, silver and broze medals won by each country.
select n.region,
count(case when o.medal='Gold' then 1 end) as gold_count,
count(case when o.medal='Silver' then 1 end) as silver_count,
count(case when o.medal='Bronze' then 1 end) as bronz_count
from olympic_history o
left join noc_reg n on o.noc=n.noc
group by n.region
order by gold_count desc;

--List down total gold, silver and broze medals won by each country corresponding to each olympic games.
select n.region,o.games,
count(case when o.medal='Gold' then 1 end) as gold_count,
count(case when o.medal='Silver' then 1 end) as silver_count,
count(case when o.medal='Bronze' then 1 end) as bronz_count
from olympic_history o
left join noc_reg n on o.noc=n.noc
group by n.region,o.games
order by gold_count desc;

--Which countries have never won gold medal but have won silver/bronze medals?
select n.region,o.games,
count(case when o.medal='Gold' then 1 end) as gold_count,
count(case when o.medal='Silver' then 1 end) as silver_count,
count(case when o.medal='Bronze' then 1 end) as bronz_count
from olympic_history o
left join noc_reg n on o.noc=n.noc
group by n.region,o.games
having count(case when o.medal='Gold' then 1 end)=0 and ((count(case when o.medal='Silver' then 1 end)>0) or (count(case when o.medal='Bronze' then 1 end)>0)) ;

--In which Sport/event, India has won highest medals.
select o.sport,count(o.medal) as med_count from olympic_history o
left join noc_reg n on o.noc=n.noc
where n.region='India'
group by n.region,o.sport
order by med_count desc
limit 1;

--Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
select o.sport,count(o.medal) as med_count,o.games from olympic_history o
left join noc_reg n on o.noc=n.noc
where n.region='India' and o.sport='Hockey'
group by n.region,o.sport,o.games
order by med_count desc;
