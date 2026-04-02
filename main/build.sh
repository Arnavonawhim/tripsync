#!/usr/bin/env bash
set -o errexit

echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

pip install gunicorn

echo "Collecting static files..."
python main/manage.py collectstatic --no-input

echo "Running migrations..."
python main/manage.py migrate

echo "Build completed successfully!"