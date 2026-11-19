-- Campus Equipment Checkout | Milestone 6: Query Portfolio
-- Student: Jose Joao
-- Run after 01_create_database.sql through 04_seed_data.sql.
USE equipment_checkout;

-- Q01 | Basic SELECT: Which students are registered?
SELECT student_id, first_name, last_name, email
FROM student;

-- Q02 | WHERE: Which students are eligible to borrow equipment?
SELECT student_id, first_name, last_name
FROM student
WHERE eligible = TRUE;

-- Q03 | Sorting: Which equipment was purchased most recently?
SELECT equipment_id, equipment_name, purchase_date
FROM equipment
ORDER BY purchase_date DESC, equipment_id ASC;

-- Q04 | Two-table JOIN: Which category does each physical asset belong to?
SELECT e.equipment_id, e.equipment_name, c.category_name, e.status
FROM equipment e
JOIN category c ON e.category_id = c.category_id
ORDER BY c.category_name, e.equipment_name;

-- Q05 | Three-table JOIN: Who has borrowed which equipment, and when?
SELECT ch.checkout_id, s.first_name, s.last_name,
       e.equipment_name, ch.checkout_date, ch.due_date, ch.return_date
FROM checkout ch
JOIN student s ON ch.student_id = s.student_id
JOIN equipment e ON ch.equipment_id = e.equipment_id
ORDER BY ch.checkout_date DESC;

-- Q06 | GROUP BY and aggregate COUNT: How many assets are in each category, including empty categories?
SELECT c.category_id, c.category_name, COUNT(e.equipment_id) AS asset_count
FROM category c
LEFT JOIN equipment e ON e.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY asset_count DESC, c.category_name;

-- Q07 | Aggregate functions: How many transactions have been completed, are still open, and were returned late?
SELECT COUNT(*) AS total_checkouts,
       SUM(CASE WHEN return_date IS NOT NULL THEN 1 ELSE 0 END) AS completed_checkouts,
       SUM(CASE WHEN return_date IS NULL THEN 1 ELSE 0 END) AS active_checkouts,
       SUM(CASE WHEN return_date > due_date THEN 1 ELSE 0 END) AS late_returns
FROM checkout;

-- Q08 | HAVING: Which students have borrowed more than one asset over time?
SELECT s.student_id, s.first_name, s.last_name,
       COUNT(ch.checkout_id) AS checkout_count
FROM student s
JOIN checkout ch ON ch.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(ch.checkout_id) > 1
ORDER BY checkout_count DESC, s.student_id;

-- Q09 | Subquery: Which equipment assets have never been checked out?
SELECT e.equipment_id, e.equipment_name, e.status
FROM equipment e
WHERE NOT EXISTS (
  SELECT 1 FROM checkout ch WHERE ch.equipment_id = e.equipment_id
)
ORDER BY e.equipment_id;

-- Q10 | NULL: Which checkout transactions are currently active?
SELECT checkout_id, student_id, equipment_id, checkout_date, due_date
FROM checkout
WHERE return_date IS NULL
ORDER BY due_date, checkout_id;

-- Q11 | Business question: Which active loans are overdue, and who should staff contact?
SELECT ch.checkout_id, s.first_name, s.last_name, s.email,
       e.equipment_name, ch.due_date,
       DATEDIFF(CURDATE(), ch.due_date) AS days_overdue
FROM checkout ch
JOIN student s ON s.student_id = ch.student_id
JOIN equipment e ON e.equipment_id = ch.equipment_id
WHERE ch.return_date IS NULL AND ch.due_date < CURDATE()
ORDER BY days_overdue DESC, ch.checkout_id;

-- Q12 | Business question with four-table JOIN: Which equipment categories are most frequently borrowed?
SELECT c.category_name, COUNT(ch.checkout_id) AS checkout_count
FROM category c
JOIN equipment e ON e.category_id = c.category_id
LEFT JOIN checkout ch ON ch.equipment_id = e.equipment_id
GROUP BY c.category_id, c.category_name
ORDER BY checkout_count DESC, c.category_name;

-- Q13 | Date filtering: Which returned checkouts were late?
SELECT ch.checkout_id, s.first_name, s.last_name,
       e.equipment_name, ch.due_date, ch.return_date,
       DATEDIFF(ch.return_date, ch.due_date) AS days_late
FROM checkout ch
JOIN student s ON s.student_id = ch.student_id
JOIN equipment e ON e.equipment_id = ch.equipment_id
WHERE ch.return_date IS NOT NULL AND ch.return_date > ch.due_date
ORDER BY days_late DESC, ch.checkout_id;

-- Q14 | Business question: Which assets are available for a new loan today (excluding currently borrowed, maintenance, and retired)?
SELECT e.equipment_id, e.equipment_name, c.category_name
FROM equipment e
JOIN category c ON e.category_id = c.category_id
WHERE e.status = 'available'
  AND NOT EXISTS (
    SELECT 1 FROM checkout ch
    WHERE ch.equipment_id = e.equipment_id AND ch.return_date IS NULL
  )
ORDER BY c.category_name, e.equipment_name;

