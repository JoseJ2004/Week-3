# Campus Equipment Checkout — Requirements Analysis
**Student:** Jose Joao  
**Project:** Week 3  
**AI disclosure:** AI just for clarification

## Mini-world and users
A university department lends physical equipment to eligible students. The database tracks students, equipment categories, individual equipment assets, checkout history, due dates, actual returns, and return condition. Users include department checkout staff, inventory administrators, and supervisors reviewing overdue items and usage.

## Information to store
- Students: ID, first/last name, email, birth date, eligibility, and contact phone numbers.
- Categories: category ID, name, description.
- Equipment: asset ID, category, name, serial number, purchase date, inventory status.
- Checkouts: transaction ID, student, specific asset, checkout date, due date, optional return date, optional return condition.

## Business rules
1. Every equipment asset belongs to exactly one category; a category can have zero or many assets.
2. Each checkout belongs to exactly one registered student and exactly one equipment asset.
3. A student may have zero, one, or many checkout transactions over time.
4. An asset may be checked out many times over its lifetime, but cannot have overlapping active checkouts.
5. Only eligible students can start a new checkout.
6. Checkout date must be on or before due date; return date cannot precede checkout date.
7. An active checkout has a NULL return date and NULL return condition.
8. A returned checkout has both a return date and a return condition.
9. Equipment with status 'maintenance' or 'retired' cannot be newly checked out.
10. A category may exist before the department buys any equipment in it.
11. A student may be registered without borrowing any equipment.
12. A return is late when its return date is later than its due date; an active loan is overdue if its due date has passed.

## Questions the database should answer
1. Which students are registered?
2. Which equipment assets exist?
3. Which category does each asset belong to?
4. What has a given student borrowed?
5. Which students have borrowed equipment at least once?
6. Which assets are currently checked out, and by whom?
7. Which assets have never been checked out?
8. Which checkouts were returned late?
9. Which active checkouts are past their due dates?
10. How many checkouts has each category had?

## Scope and assumptions
A checkout record represents one physical asset, not a basket of multiple assets. An individual student can hold multiple *different* assets at once. `status` records the asset's administrative condition/availability (available, maintenance, retired); current loan state is determined from open checkouts, not duplicated in `status`. Sample data is synthetic.
