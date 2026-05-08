# Используем Node.js 22, так как проект требует свежую версию
FROM node:22-bookworm-slim

WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y python3 make g++ git && rm -rf /var/lib/apt/lists/*

# Сначала копируем ВЕСЬ проект (чтобы скрипты preinstall были на месте)
COPY . .

# Теперь запускаем установку, игнорируя предупреждения о версиях
RUN npm install --omit=dev --no-audit --ignore-scripts

# Переменные окружения
ENV PORT=3000
ENV OPENCLAW_ALLOW_ROOT=true
ENV NODE_ENV=production

EXPOSE 3000

# Запуск
CMD ["node", "scripts/run-node.mjs", "--allow-root"]
