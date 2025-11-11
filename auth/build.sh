#!/usr/bin/env bash
set -o errexit

echo "Installing system dependencies..."
apt-get update
apt-get install -y libjpeg-dev zlib1g-dev libpng-dev libtiff-dev libfreetype6-dev liblcms2-dev libwebp-dev libopenjp2-7-dev

echo "Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Collecting static files..."
python manage.py collectstatic --no-input

echo "Running migrations..."
python manage.py migrate

echo "Build completed successfully! "