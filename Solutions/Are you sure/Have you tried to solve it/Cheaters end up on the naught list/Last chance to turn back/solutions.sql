-- Question 1: Number of nice children
-- Answer: 24329
WITH total_behav AS (
	SELECT
		child_id,
		SUM(score) AS total_behaviour
	FROM
		xmas_behaviours
	WHERE
		event_date >= DATE '2019-12-01'
		AND event_date < DATE '2020-12-01'
	GROUP BY
		child_id
) SELECT
	COUNT(child_id)
  FROM
	total_behav
  WHERE
	total_behaviour >= 0;



-- Question 2: Number of nice children who believe
-- Answer: 10682
WITH total_behav AS (
	SELECT
		child_id,
		SUM(score) AS total_behaviour
	FROM
		xmas_behaviours
	WHERE
		event_date >= DATE '2019-12-01'
		AND event_date < DATE '2020-12-01'
	GROUP BY
		child_id
) SELECT
	COUNT(a.child_id)
  FROM
	xmas_children a
	INNER JOIN total_behav b
	ON a.child_id = b.child_id
  WHERE
	b.total_behaviour >= 0
	AND TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) >= 3
	AND (
		TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) < 10
		OR (
			TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) < 15
			AND a.belief > 0.7
		)
		OR (
			TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) >= 15
			AND a.belief > 0.9
		)
	);

-- Question 3: Cost of toys
-- Answer: £2052531.29
WITH total_behav AS (
	SELECT
		child_id,
		SUM(score) AS total_behaviour
	FROM
		xmas_behaviours
	WHERE
		event_date >= DATE '2019-12-01'
		AND event_date < DATE '2020-12-01'
	GROUP BY
		child_id
),final_children AS (
	SELECT
		a.child_id
	FROM
		xmas_children a
		INNER JOIN total_behav b
		ON a.child_id = b.child_id
	WHERE
		b.total_behaviour >= 0
		AND TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) >= 3
		AND (
			TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) < 10
			OR (
				TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) < 15
				AND a.belief > 0.7
			)
			OR (
				TRUNC(MONTHS_BETWEEN(DATE '2020-12-25',a.dob) / 12) >= 15
				AND a.belief > 0.9
			)
		)
) SELECT
	SUM(price) AS total_cost
  FROM
	xmas_wishes a
	INNER JOIN xmas_toys b
	ON a.toy_id = b.uniq_id
	INNER JOIN final_children c
	ON a.child_id = c.child_id
  WHERE
	UPPER(b.amazon_category_sub_category) NOT LIKE '%SEX ' || CHR(38) || ' SENSUALITY%'
	AND UPPER(b.amazon_category_sub_category) NOT LIKE '%Sandwich Spreads, Pates ' || CHR(38) || ' Pastes%'
	AND SUBSTR(b.average_review_rating, 1, 1) IN ('4', '5');


-- Question 4: Cost of toys with 5% discount
-- Answer: £1985288.91
WITH total_behav AS (
	SELECT
		child_id,
		SUM(score) AS total_behaviour
	FROM
		xmas_behaviours
	WHERE
		event_date >= DATE '2019-12-01'
		AND event_date < DATE '2020-12-01'
	GROUP BY
		child_id
),final_children AS (
	SELECT
		a.child_id
	FROM
		xmas_children a
		INNER JOIN total_behav b
		ON a.child_id = b.child_id
	WHERE
		b.total_behaviour >= 0
		AND TRUNC(MONTHS_BETWEEN(DATE '2020-12-25', a.dob) / 12) >= 3
		AND (
			TRUNC(MONTHS_BETWEEN(DATE '2020-12-25', a.dob) / 12) < 10
			OR (
				TRUNC(MONTHS_BETWEEN(DATE '2020-12-25', a.dob) / 12) < 15
				AND a.belief > 0.7
			)
			OR (
				TRUNC(MONTHS_BETWEEN(DATE '2020-12-25', a.dob) / 12) >= 15
				AND a.belief > 0.9
			)
		)
),manu_cost AS (
	SELECT
		b.manufacturer,
		COUNT(*) AS vol,
		SUM(price) AS cost_manufacturer
	FROM
		xmas_wishes a
		LEFT JOIN xmas_toys b
		ON a.toy_id = b.uniq_id
		INNER JOIN final_children c
		ON a.child_id = c.child_id
	WHERE
		UPPER(b.amazon_category_sub_category) NOT LIKE '%SEX ' || CHR(38) || ' SENSUALITY%'
		AND UPPER(b.amazon_category_sub_category) NOT LIKE '%Sandwich Spreads, Pates ' || CHR(38) || ' Pastes%'
		AND SUBSTR(average_review_rating, 1, 1) IN ('4', '5')
	GROUP BY
		b.manufacturer
) SELECT
	SUM(
		CASE
			WHEN vol >= 50 THEN cost_manufacturer * 0.95
			ELSE cost_manufacturer
		END
	) AS total_cost_discounted
  FROM
	manu_cost;