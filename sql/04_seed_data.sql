-- Campus Equipment Checkout | Milestone 6: Seed Data
-- Student: Jose Joao
-- All data is synthetic. Run scripts 01, 02, 03, then 04.
-- Requires MySQL 8.0.16+. Insert parent tables before child tables.
USE equipment_checkout;

-- 20 students, including two ineligible students (17 and 20).
INSERT INTO student (student_id, first_name, last_name, email, birth_date, eligible) VALUES
  (1, 'Amara', 'Lewis', 'amara.lewis@example.edu', '2000-02-02', TRUE),
  (2, 'Noah', 'Bennett', 'noah.bennett@example.edu', '2001-03-03', TRUE),
  (3, 'Sofia', 'Martinez', 'sofia.martinez@example.edu', '2002-04-04', TRUE),
  (4, 'Ethan', 'Carter', 'ethan.carter@example.edu', '2003-05-05', TRUE),
  (5, 'Maya', 'Patel', 'maya.patel@example.edu', '2004-06-06', TRUE),
  (6, 'Liam', 'Brooks', 'liam.brooks@example.edu', '1999-07-07', TRUE),
  (7, 'Isabella', 'Nguyen', 'isabella.nguyen@example.edu', '2000-08-08', TRUE),
  (8, 'Oliver', 'Reed', 'oliver.reed@example.edu', '2001-09-09', TRUE),
  (9, 'Ava', 'Johnson', 'ava.johnson@example.edu', '2002-10-10', TRUE),
  (10, 'Elijah', 'Morgan', 'elijah.morgan@example.edu', '2003-11-11', TRUE),
  (11, 'Zoe', 'Kim', 'zoe.kim@example.edu', '2004-12-12', TRUE),
  (12, 'Lucas', 'Rivera', 'lucas.rivera@example.edu', '1999-01-13', TRUE),
  (13, 'Chloe', 'Davis', 'chloe.davis@example.edu', '2000-02-14', TRUE),
  (14, 'Daniel', 'Wilson', 'daniel.wilson@example.edu', '2001-03-15', TRUE),
  (15, 'Nina', 'Okafor', 'nina.okafor@example.edu', '2002-04-16', TRUE),
  (16, 'Henry', 'Clark', 'henry.clark@example.edu', '2003-05-17', TRUE),
  (17, 'Grace', 'Chen', 'grace.chen@example.edu', '2004-06-18', FALSE),
  (18, 'Mateo', 'Garcia', 'mateo.garcia@example.edu', '1999-07-19', TRUE),
  (19, 'Leah', 'Thompson', 'leah.thompson@example.edu', '2000-08-20', TRUE),
  (20, 'Adam', 'Hassan', 'adam.hassan@example.edu', '2001-09-21', FALSE);

-- 25 phone entries, including students with two contact numbers.
INSERT INTO student_phone (student_id, phone_number) VALUES
  (1, '202-555-1001'),
  (2, '202-555-1002'),
  (3, '202-555-1003'),
  (4, '202-555-1004'),
  (5, '202-555-1005'),
  (6, '202-555-1006'),
  (7, '202-555-1007'),
  (8, '202-555-1008'),
  (9, '202-555-1009'),
  (10, '202-555-1010'),
  (11, '202-555-1011'),
  (12, '202-555-1012'),
  (13, '202-555-1013'),
  (14, '202-555-1014'),
  (15, '202-555-1015'),
  (16, '202-555-1016'),
  (17, '202-555-1017'),
  (18, '202-555-1018'),
  (19, '202-555-1019'),
  (20, '202-555-1020'),
  (1, '202-555-2001'),
  (3, '202-555-2003'),
  (6, '202-555-2006'),
  (9, '202-555-2009'),
  (12, '202-555-2012');

-- 8 equipment categories.
INSERT INTO category (category_id, category_name, description) VALUES
  (1, 'Laptops', 'Portable computers for coursework'),
  (2, 'Cameras', 'Digital cameras for student projects'),
  (3, 'Audio', 'Microphones and audio recorders'),
  (4, 'Projectors', 'Projectors for student presentations'),
  (5, 'Tablets', 'Portable tablets and styluses'),
  (6, 'Networking', 'Network lab and testing devices'),
  (7, 'Accessories', 'Computer peripherals and adapters'),
  (8, 'Calculators', 'Scientific and graphing calculators');

-- 24 unique assets, including maintenance and retired equipment.
INSERT INTO equipment (equipment_id, category_id, equipment_name, serial_number, purchase_date, status) VALUES
  (1, 1, 'Dell Latitude 5440', 'CE-2026-0001', '2025-02-02', 'available'),
  (2, 1, 'Lenovo ThinkPad E14', 'CE-2026-0002', '2025-03-03', 'available'),
  (3, 1, 'HP EliteBook 840', 'CE-2026-0003', '2025-04-04', 'available'),
  (4, 1, 'Apple MacBook Air', 'CE-2026-0004', '2025-05-05', 'maintenance'),
  (5, 1, 'Acer Aspire 5', 'CE-2026-0005', '2025-06-06', 'available'),
  (6, 2, 'Canon EOS R50', 'CE-2026-0006', '2025-07-07', 'available'),
  (7, 2, 'Nikon Z50', 'CE-2026-0007', '2025-08-08', 'available'),
  (8, 2, 'Sony ZV-E10', 'CE-2026-0008', '2025-09-09', 'available'),
  (9, 3, 'Zoom H4n Pro Recorder', 'CE-2026-0009', '2025-10-10', 'available'),
  (10, 3, 'Rode Wireless GO II', 'CE-2026-0010', '2025-11-11', 'available'),
  (11, 3, 'Shure SM58 Microphone', 'CE-2026-0011', '2025-12-12', 'available'),
  (12, 4, 'Epson PowerLite 119W', 'CE-2026-0012', '2025-01-13', 'available'),
  (13, 4, 'BenQ MW560', 'CE-2026-0013', '2025-02-14', 'available'),
  (14, 5, 'Apple iPad 10th Gen', 'CE-2026-0014', '2025-03-15', 'available'),
  (15, 5, 'Samsung Galaxy Tab S9', 'CE-2026-0015', '2025-04-16', 'available'),
  (16, 5, 'Wacom Intuos Tablet', 'CE-2026-0016', '2025-05-17', 'available'),
  (17, 6, 'Cisco Catalyst Lab Switch', 'CE-2026-0017', '2025-06-18', 'available'),
  (18, 6, 'Fluke Network Tester', 'CE-2026-0018', '2025-07-19', 'maintenance'),
  (19, 6, 'TP-Link Lab Router', 'CE-2026-0019', '2025-08-20', 'retired'),
  (20, 7, 'Logitech USB Webcam', 'CE-2026-0020', '2025-09-21', 'available'),
  (21, 7, 'USB-C Docking Station', 'CE-2026-0021', '2025-10-22', 'available'),
  (22, 7, 'Anker HDMI Adapter', 'CE-2026-0022', '2025-11-23', 'retired'),
  (23, 8, 'TI-84 Plus CE', 'CE-2026-0023', '2025-12-24', 'available'),
  (24, 8, 'Casio fx-CG50', 'CE-2026-0024', '2025-01-25', 'available');

-- 34 checkout transactions: 22 returned, 12 active; includes late returns,
-- overdue open loans, and multiple loans of the same assets at different dates.
INSERT INTO checkout (checkout_id, student_id, equipment_id, checkout_date, due_date, return_date, return_condition) VALUES
  (1, 1, 1, '2026-08-20', '2026-08-27', '2026-08-26', 'good'),
  (2, 2, 2, '2026-08-22', '2026-08-29', '2026-09-02', 'good'),
  (3, 3, 6, '2026-09-01', '2026-09-08', '2026-09-08', 'good'),
  (4, 4, 9, '2026-09-03', '2026-09-10', '2026-09-12', 'damaged'),
  (5, 5, 12, '2026-09-05', '2026-09-12', '2026-09-11', 'good'),
  (6, 6, 14, '2026-09-07', '2026-09-14', '2026-09-14', 'good'),
  (7, 7, 17, '2026-09-10', '2026-09-17', '2026-09-20', 'good'),
  (8, 8, 20, '2026-09-13', '2026-09-20', '2026-09-19', 'good'),
  (9, 9, 23, '2026-09-15', '2026-09-22', '2026-09-22', 'good'),
  (10, 10, 3, '2026-09-17', '2026-09-24', '2026-09-30', 'needs_repair'),
  (11, 11, 7, '2026-09-21', '2026-09-28', '2026-09-25', 'good'),
  (12, 12, 10, '2026-09-23', '2026-09-30', '2026-10-02', 'good'),
  (13, 13, 13, '2026-09-25', '2026-10-02', '2026-10-01', 'good'),
  (14, 14, 15, '2026-09-27', '2026-10-04', '2026-10-05', 'good'),
  (15, 15, 16, '2026-10-01', '2026-10-08', '2026-10-08', 'good'),
  (16, 16, 21, '2026-10-03', '2026-10-10', '2026-10-10', 'good'),
  (17, 1, 1, '2026-10-06', '2026-10-13', '2026-10-15', 'good'),
  (18, 3, 6, '2026-10-08', '2026-10-15', '2026-10-13', 'good'),
  (19, 5, 12, '2026-10-10', '2026-10-17', '2026-10-19', 'good'),
  (20, 7, 17, '2026-10-12', '2026-10-19', '2026-10-18', 'good'),
  (21, 9, 23, '2026-10-16', '2026-10-23', '2026-10-22', 'good'),
  (22, 2, 2, '2026-10-20', '2026-10-27', '2026-10-30', 'damaged'),
  (23, 1, 1, '2026-11-01', '2026-11-10', NULL, NULL),
  (24, 4, 3, '2026-11-03', '2026-11-12', NULL, NULL),
  (25, 6, 5, '2026-11-05', '2026-11-18', NULL, NULL),
  (26, 8, 7, '2026-11-06', '2026-11-15', NULL, NULL),
  (27, 10, 8, '2026-11-07', '2026-11-21', NULL, NULL),
  (28, 12, 9, '2026-11-08', '2026-11-22', NULL, NULL),
  (29, 14, 11, '2026-11-09', '2026-11-23', NULL, NULL),
  (30, 16, 13, '2026-11-10', '2026-11-25', NULL, NULL),
  (31, 18, 15, '2026-11-11', '2026-11-26', NULL, NULL),
  (32, 3, 6, '2026-11-12', '2026-11-27', NULL, NULL),
  (33, 5, 12, '2026-11-13', '2026-11-28', NULL, NULL),
  (34, 11, 10, '2026-11-14', '2026-11-29', NULL, NULL);

-- Verify total count and distribution after loading (111 records total).
SELECT 'student' AS table_name, COUNT(*) AS row_count FROM student
UNION ALL SELECT 'student_phone',COUNT(*) FROM student_phone
UNION ALL SELECT 'category',COUNT(*) FROM category
UNION ALL SELECT 'equipment',COUNT(*) FROM equipment
UNION ALL SELECT 'checkout',COUNT(*) FROM checkout;
