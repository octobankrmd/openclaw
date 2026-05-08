FROM node:20-slim

WORKDIR /app

# Устанавливаем зависимости для работы системы
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# Указываем переменные окружения прямо тут на всякий случай
ENV PORT=3000
ENV OPENCLAW_ALLOW_ROOT=true

EXPOSE 3000

# Запускаем напрямую через ноду, минуя капризные скрипты
CMD ["node", "scripts/run-node.mjs", "--allow-root"]
