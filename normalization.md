# Milestone 4 — Normalization
**Student:** Jose Joao  
**Project:** Campus Equipment Checkout Database — Week 3  
**Date:** November 3, 2026

## Overview
The database uses five tables: `student`, `student_phone`, `category`, `equipment`, and `checkout`. The design separates students, equipment categories, individual assets, and borrowing transactions to reduce repeated data and update anomalies.

## First Normal Form (1NF)
Each table has a primary key and stores one value per field. Student phone numbers are stored in `student_phone` rather than as a comma-separated list or repeating phone columns in `student`. Its composite primary key `(student_id, phone_number)` prevents the same phone number being entered twice for one student.

## Second Normal Form (2NF)
All tables satisfy 1NF, and every non-key attribute depends on the entire primary key. Four tables use single-column primary keys, so they have no partial-key dependencies. `student_phone` uses a composite primary key but has no non-key attributes that could depend on only one part of it.

## Third Normal Form (3NF)
The tables avoid storing non-key facts that depend on other non-key facts:
- `student` stores student information once; checkouts reference `student_id` instead of repeating names and email addresses.
- `category` stores category names and descriptions once; `equipment` references `category_id` instead of repeating category details for every asset.
- `equipment` stores the attributes of each physical asset; `checkout` stores each loan transaction separately.
- `checkout` stores checkout, due, and return details without copying student or equipment descriptions.
- The generated `active_equipment_id` in `checkout` is a derived enforcement field, not an independently maintained business fact.

## Normalization Decisions and Changes
The design separates the multivalued student phone attribute into `student_phone`. It also separates categories from equipment, and checkout transactions from both students and equipment. These decisions prevent repeated details and make it possible to update a student email or category description in one place.

No further table split is necessary for the stated project scope. The Week 3 schema already reflects these normalization decisions; this milestone documents them rather than claiming unverified new schema changes.

## Conclusion
Based on the defined attributes and functional dependencies, the five-table design satisfies 1NF, 2NF, and 3NF. It reduces redundancy while retaining the relationships needed for equipment checkout reporting.
