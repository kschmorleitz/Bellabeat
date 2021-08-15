-- Clean the data & select column names to use for analysis. Note: I had to alter the data types in Excel for the Weight and Minutes_sleep tables because the CSV files would not load into BigQuery otherwise.

-- Clean daily_activity table by removing unwanted columns and rows. Note - I already dropped a few columns I wasn't interested in while previewing the data in Excel. 

SELECT * FROM daily_activity;

SELECT * FROM daily_activity
WHERE TotalSteps = 0;

DELETE FROM daily_activity
WHERE TotalSteps = 0; 

-- Clean Weight table by removing unwanted columns.

SELECT * FROM weight;

ALTER TABLE Weight
        DROP COLUMN Fat,
        DROP COLUMN WeightKg,
        DROP COLUMN LogID;

SELECT * FROM weight;

SELECT * FROM weight 
WHERE WeightPounds IS NULL;

-- Looks like the Weight table is all good to go! As previously mentioned I already ensured the data types were correct in Excel PowerQuery before uploading to SQL, so those should all be fine. 

-- Time for cleaning our final set of data in the Minutes_sleep table

SELECT * FROM minutes_sleep;

ALTER TABLE minutes_sleep
    DROP COLUMN TotalSleepRecords;

DELETE FROM minutes_sleep
WHERE TotalMinutesAsleep = 0;

ALTER TABLE minutes_sleep
MODIFY COLUMN SleepDay DATE;
	
-- In total I've uploaded 3 tables that I'll be using for my analysis

SELECT Id, AVG(TrackerDistance) AS AvgDistance, AVG(Calories) AS AvgCalories
FROM daily_activity
GROUP BY Id;

-- It looks like the average distance someone walks in a day doesn't necessarily have an impact on their calories burned

-- Let's see how sleep impacts the amount of calories one burns, as well as how much one weighs. Time to join tables!

SELECT * FROM daily_activity da
	LEFT JOIN minutes_sleep ms
    ON da.id = ms.id AND da.activitydate = ms.sleepday;
    
ALTER TABLE minutes_sleep
	RENAME COLUMN id TO id2;
    
CREATE TABLE da_sleep
	AS (SELECT * FROM daily_activity da
	LEFT JOIN minutes_sleep ms
    ON da.id = ms.id2 AND da.activitydate = ms.sleepday); 

ALTER TABLE da_sleep
	DROP COLUMN id2;

SELECT * FROM da_sleep;
    
-- Now the sleep data is connected well with the daily activity data, which means we can analyze it. However, before doing so we are going to join the weight table. 

ALTER TABLE weight
	RENAME COLUMN id TO id3;

SELECT * FROM da_sleep das
	LEFT JOIN weight w
    ON das.id = w.id3 AND das.activitydate = w.date;
    
-- Now all the tables are joined! Let's make this table official. Then we'll clean up the columns as there are multiple dates and IDs

CREATE TABLE all_activity
	AS (SELECT * FROM da_sleep das
	LEFT JOIN weight w
    ON das.id = w.id3 AND das.activitydate = w.date);
    
ALTER TABLE all_activity
	DROP COLUMN id3,
    DROP COLUMN sleepday,
    DROP COLUMN date;
    
SELECT * FROM all_activity;

-- Right away we can tell that weight isn't being recorded frequently by Bellabeat users. This could be something Bellabeat could work on in terms of improving their products or creating new ones. Or perhaps users aren't interested in recording their weight.

SELECT AVG(TotalSteps), AVG(WeightPounds), AVG(Calories) 
FROM all_activity
GROUP BY id;

-- At first glance it appears as though there's not a huge correlation between average steps taken per day and average calories burned in a day. 

-- Perhaps it'd be beneficial for Bellabeat to request age and weight info so they could better portray "active" versus "non-active" calories as this would help people better understand how their exerise efforts are impacting their health. 

ALTER TABLE all_activity
ADD COLUMN TotalActiveMinutes INT;

SELECT (VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes) AS TotalMinutes
FROM all_activity;

UPDATE all_activity
	SET TotalActiveMinutes = (VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes);

-- STATS

SELECT AVG(SedentaryMinutes/TotalActiveMinutes)*100 AS AvgInactivity
FROM all_activity;

-- "Sedentary" minutes isn't a very important thing for the company to keep records of because people don't want to see how inactive they are! It's not motivating. In addition, "sedentary" is connotated with being "lazy," so I think instead of having this recorded that BellaBeat should remove it from their tracking.

SELECT TotalMinutesAsleep, Calories
FROM all_activity;

-- It looks like time asleep is not necessarily correlated with how many calories users burn. In addition, a lot of users aren't wearing there watches while they sleep, so that could be an area of focus for future Bellabeat products.

SELECT Id, MAX(TrackerDistance), MIN(TrackerDistance), AVG(TrackerDistance)
FROM all_activity
GROUP BY id;

SELECT AVG(Calories)
FROM all_activity;

SELECT AVG(TrackerDistance)
FROM all_activity;

SELECT AVG(WeightPounds), MAX(WeightPounds), MIN(WeightPounds)
FROM all_activity;

SELECT Id, AVG(WeightPounds), MAX(WeightPounds), MIN(WeightPounds)
FROM all_activity
GROUP BY id;

SELECT Id, AVG(TotalMinutesAsleep)
FROM all_activity
WHERE TotalMinutesAsleep IS NOT NULL
GROUP BY Id

SELECT AVG(TotalMinutesAsleep/60) AS TotalHrAsleep
FROM all_activity;

-- Additonal observations about weight

SELECT Id, AVG(WeightPounds), AVG(TotalMinutesAsleep), AVG(VeryActiveMinutes), AVG(TotalDistance), AVG(TotalSteps), AVG(Calories)
FROM all_activity
GROUP BY Id;

CREATE VIEW AvgTotalsById AS(
	SELECT Id, AVG(WeightPounds), AVG(TotalMinutesAsleep), AVG(VeryActiveMinutes), AVG(TotalDistance), AVG(TotalSteps), AVG(Calories)
	FROM all_activity
	GROUP BY Id
);

CREATE VIEW AvgWeight AS(
SELECT Id, AVG(WeightPounds), AVG(TotalMinutesAsleep), AVG(VeryActiveMinutes), AVG(TotalDistance), AVG(TotalSteps), AVG(Calories)
FROM all_activity
WHERE WeightPounds IS NOT NULL
GROUP BY Id
);
