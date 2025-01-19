# [Reindeer Training Records 🦌](https://adventofsql.com/challenges/9)

## Description
The North Pole faced a pivotal moment as Rudolph, aged and weary after centuries of leading Santa's sleigh, announced he could no longer fulfill his legendary role. The choice of his successor was critical, with Santa emphasizing merit over sentimentality to ensure Christmas traditions endured.

At the Training Academy, Elf Windsworth took on the weighty task of finding the next leader. Scouring performance records, he sought not just speed but proof of exceptional skill under pressure. Using the North Pole's advanced database, he designed a precise query to highlight each reindeer's finest achievements, aiming to identify the one reindeer capable of embodying Rudolph's legacy on the most critical night of the year: Christmas Eve.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-9/blob/main/advent_of_sql_day_9.sql)

Rudolph is retiring as lead reindeer, and Santa needs to analyze each reindeer's speed records to choose the new leader.

To do this you need to:
* Calculate the average speed for each reindeer in each exercise type, excluding Rudolf.
* Find the highest average speed for each reindeer amongst those average speeds.
* Select the top 3 reindeer based on their highest average speed. Round the score to 2 decimal places.

## Dataset
This dataset contains 1 tables with 4 columns and 100000 rows. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM reindeers ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-9/blob/main/reindeers.PNG)

**input**
```sql
SELECT *
FROM training_sessions;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-9/blob/main/training.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-9/blob/main/advent_answer_day9.sql)

**input**
```sql
SELECT reindeer_name, AVG(speed_record)::NUMERIC(5,2) AS avg_speed
FROM (SELECT rs.reindeer_id, 
				 rs.reindeer_name, 
				 ts.exercise_name, 
				 ts.speed_record,
				 ROW_NUMBER() OVER(PARTITION BY ts.exercise_name ORDER BY rs.reindeer_id)
		FROM reindeers rs
		JOIN training_sessions ts ON rs.reindeer_id = ts.reindeer_id
		WHERE rs.reindeer_id != 9)
GROUP BY reindeer_name, exercise_name
ORDER BY avg_speed DESC
LIMIT 3 ;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-9/blob/main/d9.PNG)
