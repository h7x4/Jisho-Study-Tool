DB_NAME=test.db

all: clean
	sqlite3 $(DB_NAME) < 0001_initial.sql
	sqlite3 $(DB_NAME) < 0002_populate_radicals.sql
	python test.py

clean:
	rm test.db || true
