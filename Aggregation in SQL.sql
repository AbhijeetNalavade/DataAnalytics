##select world Database to solve the following questions 
##(Hint : World Database is inbuilt in SQL Workbench so use code “use world;” to make use of the database)

##Question 1 : Count how many cities are there in each country?
use world;
select c.country_name, count(ct.city_name) as citycount
from country c join city_new ct
on c.`code` = ct.countrycode 
group by c.country_name
order by citycount desc;

##Question 2 : Display all continents having more than 30 countries. 
select 
continent, 
count(*) as country_count
from country
group by continent
having count(country_name)>30
order by country_count desc;

###Question 3 : List regions whose total population exceeds 200 million.
select
region,
sum(Population) as total_population
from country
group by region
having (total_population > 20000000)
order by total_population desc;

###Question 4 : Find the top 5 continents by average GNP per country.
select
continent , 
round(avg(gnp),2) as avg_gnp_per_country
from country
group by  continent
order by avg_gnp_per_country desc
limit 5;

###Question 5 : Find the total number of official languages spoken in each continent.
select
c.continent,
count(cl.`language`) as  No_of_language
from country c join countrylanguage cl
on c.`code` = cl.countrycode
group by c.Continent,cl.Language
order by No_of_language desc;

###Question 6 : Find the maximum and minimum GNP for each continent.
select 
continent,
max(GNP) as maximumGNP,
min(GNP) as minimumGNP
from country
group by Continent
order by continent;
## WE CAN ALSO SEE NON ZERO MIN VALUES FOR EACH CONTINENT
select 
continent,
max(GNP) as maximumGNP,
min(nullif(GNP,0)) as minimumGNP
from country
group by Continent
order by continent;

###Question 7 : Find the country with the highest average city population.
select
c.country_name,
round(avg(ct.city_pop),0) as avg_population
from country c inner join city_new ct
on c.`code` = ct.countrycode
group by c.country_name
order by avg_population desc
limit 1;

###Question 8 : List continents where the average city population is greater than 200,000.
select
c.Continent,
round(avg(ct.city_pop),0) as avg_population
from country c inner join city_new ct
on c.`code` = ct.countrycode
group by c.Continent
having avg_population > 200000
order by avg_population desc;

###Question 9 : Find the total population and average life expectancy for each continent, ordered by average life expectancy descending.
select 
continent,
sum(population) as total_population,
round(avg(lifeexpectancy),0) as avg_life_expectancy
from country
group by continent
order by avg_life_expectancy desc;

###Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
##the total population is over 200 million.

select 
continent,
sum(population) as total_population,
round(avg(lifeexpectancy),0) as avg_life_expectancy
from country
group by continent
having (total_population) > 20000000
order by avg_life_expectancy desc
limit 3



















