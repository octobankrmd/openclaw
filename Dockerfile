FROM node:22-bookworm

WORKDIR /app

# Системные зависимости
RUN apt-get update && apt-get install -y python3 make g++ git && rm -rf /var/lib/apt/lists/*

# Копируем проект
COPY . .

# Установка (полная, чтобы ничего не потерять)
RUN npm install

# Переменные окружения
ENV PORT=3000
ENV OPENCLAW_ALLOW_ROOT=true
ENV NODE_ENV=production

EXPOSE 3000

# Запуск напрямую через главный файл проекта
CMD ["npm", "start", "--", "--allow-root"]