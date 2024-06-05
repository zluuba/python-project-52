dev:
	poetry run python3 manage.py runserver

PORT ?= 8000
start:
	python3 manage.py migrate
	poetry run gunicorn --bind 0.0.0.0:$(PORT) task_manager.wsgi

migrations:
	python3 manage.py makemigrations
	python3 manage.py migrate

install:
	poetry install

lint:
	flake8 task_manager

test:
	poetry run python3 manage.py test

test-coverage:
	poetry run coverage run manage.py test
	poetry run coverage xml --include=task_manager/* --omit=task_manager/settings.py

run:
	docker-compose up
	docker-compose exec tm_web python manage.py migrate --noinput
