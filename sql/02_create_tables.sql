-- Milestone 5: Campus Equipment Checkout
-- Student: Jose Joao
-- Step 2: Create the five tables. Run 01_create_database.sql first.
USE equipment_checkout;

CREATE TABLE IF NOT EXISTS student (
  student_id INT NOT NULL,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  email VARCHAR(120) NOT NULL,
  birth_date DATE NOT NULL,
  eligible BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (student_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS student_phone (
  student_id INT NOT NULL,
  phone_number VARCHAR(25) NOT NULL,
  PRIMARY KEY (student_id, phone_number)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS category (
  category_id INT NOT NULL,
  category_name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY (category_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS equipment (
  equipment_id INT NOT NULL,
  category_id INT NOT NULL,
  equipment_name VARCHAR(100) NOT NULL,
  serial_number VARCHAR(100) NOT NULL,
  purchase_date DATE,
  status ENUM('available','maintenance','retired') NOT NULL DEFAULT 'available',
  PRIMARY KEY (equipment_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS checkout (
  checkout_id INT NOT NULL,
  student_id INT NOT NULL,
  equipment_id INT NOT NULL,
  checkout_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE NULL,
  return_condition ENUM('good','damaged','needs_repair') NULL,
  active_equipment_id INT GENERATED ALWAYS AS (
    CASE WHEN return_date IS NULL THEN equipment_id ELSE NULL END
  ) STORED,
  PRIMARY KEY (checkout_id)
) ENGINE=InnoDB;
