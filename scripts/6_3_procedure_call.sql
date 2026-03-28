-- Calling procedure
CALL add_track_full(
    'aB8cD2efGH4iJkLmN0pQrS',
    'harpee',
    'bar italia',
    100,
    194132,
    '0vrKGjXSGcTsxNGxQdXT5p',
    '37i9dQZF1DWTHM4kX49UKs'
);

SELECT * FROM tracks
WHERE tracks.track_id = 'aB8cD2efGH4iJkLmN0pQrS';