-- schema.sql
-- Palms Rentals: listings, neighborhoods, tour slots, and tour requests waiting for staff.

CREATE TABLE IF NOT EXISTS listings (
    listing_id         TEXT PRIMARY KEY,
    title              TEXT NOT NULL,
    neighborhood       TEXT NOT NULL,
    monthly_rent       REAL NOT NULL,
    bedrooms           INTEGER NOT NULL,
    bathrooms          REAL NOT NULL,
    pets_allowed       INTEGER NOT NULL,
    furnished          INTEGER NOT NULL,
    parking            INTEGER NOT NULL,
    utilities_included INTEGER NOT NULL,
    available_from     TEXT NOT NULL,
    status             TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS neighborhoods (
    name                 TEXT PRIMARY KEY,
    typical_rent_1br     REAL NOT NULL,
    commute_downtown_min INTEGER NOT NULL,
    grocery_within_mile  INTEGER NOT NULL,
    bus_routes           INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS tour_slots (
    slot_id    TEXT PRIMARY KEY,
    listing_id TEXT NOT NULL,
    slot_time  TEXT NOT NULL,
    booked_by  TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS change_requests (
    number     INTEGER PRIMARY KEY AUTOINCREMENT,
    slot_id    TEXT NOT NULL,
    new_value  TEXT NOT NULL,
    status     TEXT NOT NULL DEFAULT 'waiting'
);

-- pets_allowed, furnished, parking, utilities_included: 1 = yes, 0 = no
-- listings.status: 'available' or 'rented'
-- available_from: date as YYYY-MM-DD

INSERT OR IGNORE INTO listings
    (listing_id, title, neighborhood, monthly_rent, bedrooms, bathrooms,
     pets_allowed, furnished, parking, utilities_included, available_from, status) VALUES
    ('L1001', 'Studio apartment, furnished', 'Riverview',      1150.00, 0, 1.0, 0, 1, 1, 1, '2026-12-01', 'available'),
    ('L1002', '1BR/1BA apartment, unfurnished', 'Brandon',        1350.00, 1, 1.0, 1, 0, 1, 0, '2026-12-15', 'available'),
    ('L1003', '2BR/2BA townhome, unfurnished', 'Seffner',        1750.00, 2, 2.0, 1, 0, 1, 0, '2027-01-01', 'available'),
    ('L1004', '2BR/2BA apartment, unfurnished', 'Downtown Tampa', 2300.00, 2, 2.0, 0, 0, 0, 1, '2026-12-10', 'rented'),
    ('L1005', '3BR/2BA townhome, unfurnished', 'Riverview',      2450.00, 3, 2.0, 1, 0, 1, 0, '2027-01-15', 'available'),
    ('L1006', '1BR/1BA apartment, furnished', 'Temple Terrace', 1600.00, 1, 1.0, 0, 1, 1, 1, '2026-12-05', 'rented'),
    ('L1007', '2BR/1BA apartment, unfurnished', 'Brandon',        1500.00, 2, 1.0, 1, 0, 1, 0, '2026-12-20', 'available');

INSERT OR IGNORE INTO neighborhoods
    (name, typical_rent_1br, commute_downtown_min, grocery_within_mile, bus_routes) VALUES
    ('Riverview',      1400.00, 30, 1, 1),
    ('Brandon',        1450.00, 25, 1, 3),
    ('Seffner',        1350.00, 25, 0, 1),
    ('Downtown Tampa', 2100.00,  5, 1, 8),
    ('Temple Terrace', 1550.00, 20, 1, 4);

-- slot_time: YYYY-MM-DD H:MM am or pm, always between 8 am and 6 pm
-- booked_by: 'nobody' means the slot is open; otherwise the renter's name
INSERT OR IGNORE INTO tour_slots (slot_id, listing_id, slot_time, booked_by) VALUES
    ('T2001', 'L1001', '2026-12-02 10:00 am', 'nobody'),
    ('T2002', 'L1002', '2026-12-03 2:00 pm', 'nobody'),
    ('T2003', 'L1003', '2026-12-05 11:00 am', 'nobody'),
    ('T2004', 'L1003', '2026-12-07 9:30 am', 'nobody'),
    ('T2005', 'L1005', '2026-12-08 3:00 pm', 'nobody'),
    ('T2006', 'L1007', '2026-12-09 1:00 pm', 'nobody'),
    ('T2007', 'L1002', '2026-12-05 10:00 am', 'Priya Nair');