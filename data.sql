-- Synthetic sample records. Run AFTER schema.sql.
USE equipment_checkout;

-- 10 students; student 110 has no checkout.
INSERT INTO student VALUES (101, 'Maria', 'Lopez', 'maria.lopez@example.edu', '2002-06-15', TRUE);
INSERT INTO student VALUES (102, 'James', 'Smith', 'james.smith@example.edu', '2003-07-15', TRUE);
INSERT INTO student VALUES (103, 'Amina', 'Bello', 'amina.bello@example.edu', '2004-08-15', TRUE);
INSERT INTO student VALUES (104, 'Daniel', 'Carter', 'daniel.carter@example.edu', '2005-01-15', TRUE);
INSERT INTO student VALUES (105, 'Sofia', 'Costa', 'sofia.costa@example.edu', '2001-02-15', TRUE);
INSERT INTO student VALUES (106, 'Liam', 'Brown', 'liam.brown@example.edu', '2002-03-15', TRUE);
INSERT INTO student VALUES (107, 'Olivia', 'Davis', 'olivia.davis@example.edu', '2003-04-15', TRUE);
INSERT INTO student VALUES (108, 'Noah', 'Wilson', 'noah.wilson@example.edu', '2004-05-15', TRUE);
INSERT INTO student VALUES (109, 'Eva', 'Martin', 'eva.martin@example.edu', '2005-06-15', TRUE);
INSERT INTO student VALUES (110, 'Lucas', 'Moore', 'lucas.moore@example.edu', '2001-07-15', TRUE);

-- One student can have more than one phone.
INSERT INTO student_phone VALUES (101,'202-555-0101'),(101,'202-555-0102'),(102,'202-555-0103');

INSERT INTO category VALUES (1, 'Laptops', 'Department laptops for student borrowing');
INSERT INTO category VALUES (2, 'Cameras', 'Department cameras for student borrowing');
INSERT INTO category VALUES (3, 'Projectors', 'Department projectors for student borrowing');
INSERT INTO category VALUES (4, 'Microphones', 'Department microphones for student borrowing');
INSERT INTO category VALUES (5, 'Networking', 'Department networking for student borrowing');

-- 15 assets; asset 115 has never been borrowed.
INSERT INTO equipment VALUES (101, 1, 'Laptop Unit 1', 'CAMPUS-0001', '2025-03-02', 'available');
INSERT INTO equipment VALUES (102, 1, 'Laptop Unit 2', 'CAMPUS-0002', '2025-03-03', 'available');
INSERT INTO equipment VALUES (103, 1, 'Laptop Unit 3', 'CAMPUS-0003', '2025-03-04', 'available');
INSERT INTO equipment VALUES (104, 2, 'Camera Unit 4', 'CAMPUS-0004', '2025-03-05', 'available');
INSERT INTO equipment VALUES (105, 2, 'Camera Unit 5', 'CAMPUS-0005', '2025-03-06', 'available');
INSERT INTO equipment VALUES (106, 2, 'Camera Unit 6', 'CAMPUS-0006', '2025-03-07', 'available');
INSERT INTO equipment VALUES (107, 3, 'Projector Unit 7', 'CAMPUS-0007', '2025-03-08', 'available');
INSERT INTO equipment VALUES (108, 3, 'Projector Unit 8', 'CAMPUS-0008', '2025-03-09', 'available');
INSERT INTO equipment VALUES (109, 3, 'Projector Unit 9', 'CAMPUS-0009', '2025-03-10', 'available');
INSERT INTO equipment VALUES (110, 4, 'Microphone Unit 10', 'CAMPUS-0010', '2025-03-11', 'available');
INSERT INTO equipment VALUES (111, 4, 'Microphone Unit 11', 'CAMPUS-0011', '2025-03-12', 'available');
INSERT INTO equipment VALUES (112, 4, 'Microphone Unit 12', 'CAMPUS-0012', '2025-03-13', 'available');
INSERT INTO equipment VALUES (113, 5, 'Networking Unit 13', 'CAMPUS-0013', '2025-03-14', 'available');
INSERT INTO equipment VALUES (114, 5, 'Networking Unit 14', 'CAMPUS-0014', '2025-03-15', 'available');
INSERT INTO equipment VALUES (115, 5, 'Networking Unit 15', 'CAMPUS-0015', '2025-03-16', 'available');

-- 20 checkouts: 16 returned, 4 active, repeated assets, and late returns.
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (1, 101, 101, '2026-01-14', '2026-01-21', '2026-01-20', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (2, 102, 102, '2026-01-23', '2026-01-30', '2026-01-29', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (3, 103, 103, '2026-02-01', '2026-02-08', '2026-02-10', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (4, 104, 104, '2026-02-10', '2026-02-17', '2026-02-16', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (5, 105, 105, '2026-02-19', '2026-02-26', '2026-02-25', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (6, 106, 106, '2026-02-28', '2026-03-07', '2026-03-06', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (7, 107, 107, '2026-03-09', '2026-03-16', '2026-03-15', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (8, 108, 108, '2026-03-18', '2026-03-25', '2026-03-24', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (9, 109, 109, '2026-03-27', '2026-04-03', '2026-04-05', 'damaged');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (10, 101, 110, '2026-04-05', '2026-04-12', '2026-04-11', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (11, 102, 101, '2026-04-14', '2026-04-21', '2026-04-20', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (12, 103, 102, '2026-04-23', '2026-04-30', '2026-04-29', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (13, 104, 103, '2026-05-02', '2026-05-09', '2026-05-08', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (14, 105, 104, '2026-05-11', '2026-05-18', '2026-05-20', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (15, 106, 105, '2026-05-20', '2026-05-27', '2026-05-26', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (16, 107, 106, '2026-05-29', '2026-06-05', '2026-06-04', 'good');
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (17, 101, 110, '2026-10-01', '2026-10-15', NULL, NULL);
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (18, 102, 111, '2026-10-02', '2026-10-16', NULL, NULL);
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (19, 103, 112, '2026-10-03', '2026-10-17', NULL, NULL);
INSERT INTO checkout (checkout_id,student_id,equipment_id,checkout_date,due_date,return_date,return_condition) VALUES (20, 104, 113, '2026-10-04', '2026-10-18', NULL, NULL);
