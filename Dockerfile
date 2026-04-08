<<<<<<< HEAD
<<<<<<< HEAD
FROM python:3.11-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

WORKDIR /app/auth


FROM base AS production

RUN python manage.py collectstatic --noinput || true

EXPOSE 8000 8001

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD python -c "import requests; requests.get('http://localhost:8000/health/', timeout=5)"

CMD ["sh", "-c", "python manage.py migrate && gunicorn auth.wsgi:application --bind 0.0.0.0:8000 --workers 3 & daphne -b 0.0.0.0 -p 8001 auth.asgi:application"]
=======
FROM python:3.12-slim
=======
FROM python:3.13-slim AS django
>>>>>>> upstream/auth

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app/main

ENV DJANGO_SETTINGS_MODULE=main.settings

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       netcat-openbsd \
       libpq-dev \
       gcc \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock* /app/

WORKDIR /app
RUN poetry config virtualenvs.create false \
    && poetry install --only main --no-interaction --no-ansi --no-root

COPY . /app/

WORKDIR /app/main

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh"]

<<<<<<< HEAD
CMD ["daphne", "-b", "0.0.0.0", "-p", "8000", "main.asgi:application"]
>>>>>>> upstream/main
=======
FROM nginx:1.27-alpine AS nginx

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
>>>>>>> upstream/auth
