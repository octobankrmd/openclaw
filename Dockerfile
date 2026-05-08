FROM node:22-bookworm

WORKDIR /app

# Устанавливаем системные зависимости и pnpm
RUN apt-get update && apt-get install -y python3 make g++ git && \
    npm install -g pnpm && \
    rm -rf /var/lib/apt/lists/*

# Копируем всё
COPY . .

# Установка и сборка
RUN pnpm install && pnpm run build

# Переменные окружения
ENV PORT=3000
ENV OPENCLAW_ALLOW_ROOT=true
ENV NODE_ENV=production
# Эта переменная скажет программе не искать интерактивный ввод
ENV CI=true 

EXPOSE 3000

# Запускаем только веб-сервер напрямую
CMD ["node", "dist/index.js", "--allow-root", "--host", "0.0.0.0"]
