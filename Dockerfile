FROM node:22-bookworm

WORKDIR /app

# Устанавливаем системные зависимости и pnpm
RUN apt-get update && apt-get install -y python3 make g++ git && \
    npm install -g pnpm && \
    rm -rf /var/lib/apt/lists/*

# Копируем проект
COPY . .

# Установка зависимостей через pnpm (раз он его так просит)
RUN pnpm install

# Сборка проекта
RUN pnpm run build

# Переменные окружения
ENV PORT=3000
ENV OPENCLAW_ALLOW_ROOT=true
ENV NODE_ENV=production

EXPOSE 3000

# Запуск
CMD ["node", "dist/index.js", "--allow-root"]
