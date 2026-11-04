# Milestone 4 — Integrity Rules
**Student:** Jose Joao  
**Project:** Campus Equipment Checkout Database — Week 3  
**Date:** November 3, 2026

## Primary Keys
- `student.student_id` uniquely identifies a student.
- `student_phone (student_id, phone_number)` uniquely identifies each student's phone entry.
- `category.category_id` uniquely identifies a category.
- `equipment.equipment_id` uniquely identifies an asset.
- `checkout.checkout_id` uniquely identifies a loan transaction.

## Foreign Keys
- `student_phone.student_id` references `student.student_id`.
- `equipment.category_id` references `category.category_id`.
- `checkout.student_id` references `student.student_id`.
- `checkout.equipment_id` references `equipment.equipment_id`.

These relationships prevent phone entries, equipment assets, or checkouts from referring to nonexistent parent records.

## NOT NULL
Required values include student names, email, birth date, and eligibility; phone numbers; category names; equipment category, name, serial number, and status; and checkout student, equipment, checkout date, and due date. `return_date` and `return_condition` are nullable because an active checkout has not yet been returned. Category descriptions and equipment purchase dates are optional.

## UNIQUE
- `student.email` prevents duplicate student email addresses.
- `category.category_name` prevents duplicate category names.
- `equipment.serial_number` prevents duplicate asset serial numbers.
- The composite primary key on `student_phone` prevents duplicate phone entries for the same student.
- `uq_one_active_checkout_per_equipment` is a unique index on generated `active_equipment_id`. For an open checkout, this generated value is the equipment ID; for a returned checkout, it is NULL. This blocks two simultaneously open checkout records for the same asset while allowing multiple completed loans over time.

## CHECK
The `checkout` table defines:
- `chk_due_after_checkout`: `due_date >= checkout_date`.
- `chk_return_after_checkout`: a return date must be NULL or on/after the checkout date.
- `chk_return_condition`: open checkouts must have both return fields NULL, and returned checkouts must have both fields populated.

These rules protect date consistency and prevent incomplete return records.

## Default Values and Allowed Values
- `student.eligible` defaults to TRUE.
- `equipment.status` defaults to `'available'`.
- The equipment status ENUM permits only `'available'`, `'maintenance'`, or `'retired'`.
- The return condition ENUM permits `'good'`, `'damaged'`, or `'needs_repair'` when a condition is supplied.

## Triggers and Business Rules
The `checkout_before_insert` trigger rejects a new checkout if the student is not eligible or the equipment status is not `'available'`. The `checkout_before_update` trigger prevents changing the student or equipment associated with an existing checkout.

These triggers work with the unique active-equipment index to protect new checkout records. The schema does not independently block every possible later change to student eligibility or equipment status; the insert trigger checks conditions at checkout creation.

## Referential Actions
The foreign keys do not explicitly specify `ON DELETE` or `ON UPDATE` actions. In MySQL/InnoDB, the default behavior is restrictive (`RESTRICT`/`NO ACTION`), so deleting or changing a referenced parent key is prevented while dependent rows exist. There is no automatic cascading delete configured. This protects checkout history from accidental deletion.

## Conclusion
The Week 3 schema combines keys, required fields, uniqueness, checks, defaults, ENUM restrictions, and triggers to enforce the project's main integrity rules. The documentation describes constraints present in `schema.sql`, rather than proposing them as already implemented when they are not.
