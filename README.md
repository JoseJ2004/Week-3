# Campus Equipment Checkout Database — Week 3
**Student:** Jose Joao  
**AI disclosure:** AI just for clarification

## Project and how to run
This database models a university department lending individual equipment assets to students. The four principal entities are STUDENT, CATEGORY, EQUIPMENT, and CHECKOUT. `student_phone` is an additional table to store the multivalued phone attribute.

On Ubuntu with MySQL installed, from this directory run:
```bash
sudo mysql < schema.sql
sudo mysql < data.sql
sudo mysql < queries.sql
```
If your MySQL account requires a password, use `mysql -u root -p` instead of `sudo mysql`.

**Important:** The data file is intended for a fresh database and should only be imported once. For a clean rerun, back up any needed data, then `DROP DATABASE equipment_checkout;` and repeat the three commands.

## Design explanation — 12 questions
1. **Mini-world:** A campus department lends laptops, cameras, projectors, microphones, and networking equipment to students and tracks each loan and return.
2. **Entity types:** STUDENT, CATEGORY, EQUIPMENT, CHECKOUT. STUDENT_PHONE is a logical helper relation.
3. **Entity instance:** STUDENT 101 represents Maria Lopez; EQUIPMENT 101 represents one particular campus asset.
4. **Key attributes:** student_id, category_id, equipment_id, checkout_id; student_phone uses the pair (student_id, phone_number).
5. **Simple attributes:** email, birth_date, serial_number, purchase_date, checkout_date, due_date, and return_date.
6. **Composite attribute:** Student name is conceptually made of first_name and last_name.
7. **Multivalued attribute:** A student can have several phone numbers, represented in STUDENT_PHONE.
8. **Derived attribute:** Age is calculated from birth_date and today's date; it is not stored as a column.
9. **1:N relationship:** One CATEGORY can classify many EQUIPMENT assets, but each EQUIPMENT asset belongs to exactly one CATEGORY.
10. **Total participation:** Every CHECKOUT must reference one STUDENT and one EQUIPMENT; every EQUIPMENT must reference a CATEGORY.
11. **Partial participation:** A STUDENT may have no CHECKOUT records. A CATEGORY may have no equipment, and an asset may have no checkout history.
12. **Conceptual to logical change:** The composite name became first_name and last_name columns; the multivalued phone attribute became a separate student_phone table; the derived age is calculated when needed instead of stored.

## Relationship and participation summary
- CATEGORY (0,N) — classifies — EQUIPMENT (1,1): category partial, equipment total.
- STUDENT (0,N) — makes — CHECKOUT (1,1): student partial, checkout total.
- EQUIPMENT (0,N) — appears in — CHECKOUT (1,1): equipment partial, checkout total.
- STUDENT (0,N) — has — PHONE (1,1): student partial, phone total (logical representation).

The first three are binary 1:N relationships. A CHECKOUT record has one student and one asset; a student or asset can have many checkout records over time. The active-equipment unique generated key prevents two open loans for one asset. MySQL CHECK constraints validate dates and return conditions, and triggers enforce student eligibility and asset status when a new checkout is created.

## File layout
- `requirements.md`: requirements, rules, and business questions
- `schema.sql`: MySQL schema and constraints
- `data.sql`: synthetic test records (10 students, 5 categories, 15 assets, 20 checkouts)
- `queries.sql`: 10 commented SQL questions and answers
- `diagrams/equipment_erd.png`: conceptual ER diagram
- `screenshots/`: add screenshots of successful MySQL execution and query results

## Evidence to capture on Ubuntu
Capture (1) `SHOW DATABASES;` and `SHOW TABLES;`, (2) successful schema execution, (3) sample contents e.g. `SELECT * FROM student;`, and (4) results of at least four queries. Screenshots must be made on your own Linux environment; they are not included as fabricated evidence.
