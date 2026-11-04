-- Milestone 5: Campus Equipment Checkout
-- Student: Jose Joao
-- Step 3: Add constraints and triggers. Run scripts 01 and 02 first.
-- Requires MySQL 8.0.16+ for enforced CHECK constraints.
USE equipment_checkout;

ALTER TABLE student
  ADD CONSTRAINT uq_student_email UNIQUE (email);

ALTER TABLE student_phone
  ADD CONSTRAINT fk_student_phone_student
    FOREIGN KEY (student_id) REFERENCES student(student_id);

ALTER TABLE category
  ADD CONSTRAINT uq_category_name UNIQUE (category_name);

ALTER TABLE equipment
  ADD CONSTRAINT uq_equipment_serial UNIQUE (serial_number),
  ADD CONSTRAINT fk_equipment_category
    FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE checkout
  ADD CONSTRAINT uq_one_active_checkout_per_equipment UNIQUE (active_equipment_id),
  ADD CONSTRAINT chk_due_after_checkout CHECK (due_date >= checkout_date),
  ADD CONSTRAINT chk_return_after_checkout CHECK (
    return_date IS NULL OR return_date >= checkout_date
  ),
  ADD CONSTRAINT chk_return_condition CHECK (
    (return_date IS NULL AND return_condition IS NULL)
    OR (return_date IS NOT NULL AND return_condition IS NOT NULL)
  ),
  ADD CONSTRAINT fk_checkout_student
    FOREIGN KEY (student_id) REFERENCES student(student_id),
  ADD CONSTRAINT fk_checkout_equipment
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id);

-- Business rules from the original Week 3 schema.
DROP TRIGGER IF EXISTS checkout_before_insert;
DROP TRIGGER IF EXISTS checkout_before_update;
DELIMITER //
CREATE TRIGGER checkout_before_insert BEFORE INSERT ON checkout
FOR EACH ROW
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM student
    WHERE student_id = NEW.student_id AND eligible = TRUE
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student is not eligible to borrow';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM equipment
    WHERE equipment_id = NEW.equipment_id AND status = 'available'
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Equipment unavailable for checkout';
  END IF;
END//
CREATE TRIGGER checkout_before_update BEFORE UPDATE ON checkout
FOR EACH ROW
BEGIN
  IF NEW.student_id <> OLD.student_id OR NEW.equipment_id <> OLD.equipment_id THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot reassign existing checkout';
  END IF;
END//
DELIMITER ;
