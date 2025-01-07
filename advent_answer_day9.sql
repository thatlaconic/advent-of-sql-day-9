SELECT reindeer_name, AVG(speed_record)::NUMERIC(5,2) AS avg_speed
FROM (SELECT rs.reindeer_id, 
				rs.reindeer_name, 
				ts.exercise_name, 
				ts.speed_record,
				ROW_NUMBER() OVER(PARTITION BY ts.exercise_name ORDER BY rs.reindeer_id)
		FROM reindeers rs
		JOIN training_sessions ts ON rs.reindeer_id = ts.reindeer_id
		WHERE rs.reindeer_id !=  9
		)
GROUP BY reindeer_name, exercise_name
ORDER BY avg_speed DESC
LIMIT 3 ;