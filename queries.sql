USE equipment_checkout;

-- 1. List all students.
SELECT student_id, first_name, last_name, email FROM student ORDER BY student_id;

-- 2. List all equipment.
SELECT * FROM equipment ORDER BY equipment_id;

-- 3. Show each equipment asset and its category.
SELECT e.equipment_id, e.equipment_name, c.category_name FROM equipment e JOIN category c ON c.category_id=e.category_id ORDER BY e.equipment_id;

-- 4. Show all checkout transactions for student 101.
SELECT * FROM checkout WHERE student_id=101 ORDER BY checkout_date;

-- 5. Show all students who have borrowed equipment.
SELECT DISTINCT s.student_id, s.first_name, s.last_name FROM student s JOIN checkout ch ON ch.student_id=s.student_id ORDER BY s.student_id;

-- 6. Show equipment currently checked out and the borrower.
SELECT e.equipment_id, e.equipment_name, s.first_name, s.last_name, ch.due_date FROM checkout ch JOIN equipment e ON e.equipment_id=ch.equipment_id JOIN student s ON s.student_id=ch.student_id WHERE ch.return_date IS NULL;

-- 7. Show equipment that has never been checked out.
SELECT e.equipment_id, e.equipment_name FROM equipment e LEFT JOIN checkout ch ON ch.equipment_id=e.equipment_id WHERE ch.checkout_id IS NULL;

-- 8. Show equipment returned after its due date.
SELECT ch.checkout_id, e.equipment_name, ch.due_date, ch.return_date FROM checkout ch JOIN equipment e ON e.equipment_id=ch.equipment_id WHERE ch.return_date > ch.due_date;

-- 9. Show active checkouts past due as of today.
SELECT * FROM checkout WHERE return_date IS NULL AND due_date < CURRENT_DATE();

-- 10. Count checkouts by category.
SELECT c.category_name, COUNT(ch.checkout_id) AS checkout_count FROM category c LEFT JOIN equipment e ON e.category_id=c.category_id LEFT JOIN checkout ch ON ch.equipment_id=e.equipment_id GROUP BY c.category_id,c.category_name ORDER BY c.category_id;
