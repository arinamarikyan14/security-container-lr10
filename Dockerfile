# Используем официальный Python-образ
FROM python:3.12-slim

# Не создавать .pyc-файлы
ENV PYTHONDONTWRITEBYTECODE=1

# Вывод Python сразу в консоль без буферизации
ENV PYTHONUNBUFFERED=1

# Рабочая директория внутри контейнера
WORKDIR /app

# Установка системных зависимостей для PostgreSQL
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Копируем файл зависимостей
COPY app/requirements.txt /app/

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходный код Django-приложения
COPY app/ /app/

# Открываем порт приложения
EXPOSE 8000

# Команда запуска Django через gunicorn
CMD ["gunicorn", "security_project.wsgi:application", "--bind", "0.0.0.0:8000"]