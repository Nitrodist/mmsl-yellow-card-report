-- \d infractions
--                               Table "public.infractions"
--           Column          |           Type           | Collation | Nullable | Default
-- --------------------------+--------------------------+-----------+----------+---------
--  id                       | character varying(255)   |           | not null |
--  team_name                | character varying(255)   |           |          |
--  first_name               | character varying(255)   |           |          |
--  last_name                | character varying(255)   |           |          |
--  datetime_of_infraction   | timestamp with time zone |           |          |
--  player_number            | integer                  |           |          |
--  infraction_code          | character varying(255)   |           |          |
--  infraction_series_number | integer                  |           |          |
-- Indexes:
--     "infractions_pkey" PRIMARY KEY, btree (id)
\copy (

SELECT i.team_name, 
       concat(i.first_name, ' ', i.last_name) as name,
      infract1_date,
      ' ' as placeholder,
      infract2_date,
      ' ' as placeholder,
      infract3_date,
      ' ' as placeholder,
      infract4_date,
      ' ' as placeholder,
      infract5_date,
      ' ' as placeholder,
      infract6_date,
      ' ' as placeholder,
      infract7_date,
      ' ' as placeholder
FROM infractions i
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract1_date FROM infractions WHERE infraction_series_number = 1) infract1 ON i.team_name = infract1.team_name AND i.first_name = infract1.first_name AND i.last_name = infract1.last_name
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract2_date FROM infractions WHERE infraction_series_number = 2) infract2 ON i.team_name = infract2.team_name AND i.first_name = infract2.first_name AND i.last_name = infract2.last_name
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract3_date FROM infractions WHERE infraction_series_number = 3) infract3 ON i.team_name = infract3.team_name AND i.first_name = infract3.first_name AND i.last_name = infract3.last_name
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract4_date FROM infractions WHERE infraction_series_number = 4) infract4 ON i.team_name = infract4.team_name AND i.first_name = infract4.first_name AND i.last_name = infract4.last_name
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract5_date FROM infractions WHERE infraction_series_number = 5) infract5 ON i.team_name = infract5.team_name AND i.first_name = infract5.first_name AND i.last_name = infract5.last_name
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract6_date FROM infractions WHERE infraction_series_number = 6) infract6 ON i.team_name = infract6.team_name AND i.first_name = infract6.first_name AND i.last_name = infract6.last_name
left outer join (select team_name, first_name, last_name, datetime_of_infraction as infract7_date FROM infractions WHERE infraction_series_number = 7) infract7 ON i.team_name = infract7.team_name AND i.first_name = infract7.first_name AND i.last_name = infract7.last_name

GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
ORDER BY 1, 2
) to 'output.csv' with csv HEADER;
