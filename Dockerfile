FROM node:20-bullseye-slim

WORKDIR /app

# Устанавливаем только самое необходимое
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

# Копируем файлы зависимостей
COPY package*.json ./

# Используем флаг --omit=dev, чтобы не тянуть лишний мусор, и --no-audit для скорости
RUN npm install --omit=dev --no-audit

# Копируем остальной код
COPY . .

# Переменные окружения
ENV PORT=3000
ENV OPENCLAW_ALLOW_ROOT=true
ENV NODE_ENV=production

EXPOSE 3000

# Самый простой запуск
CMD ["node", "scripts/run-node.mjs", "--allow-root"]