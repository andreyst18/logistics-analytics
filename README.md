# Logistics Analytics — Smart Logistics Data & ML Platform

Сквозной прототип платформы аналитики и прогнозирования тарифов грузоперевозок:
ETL → Core DWH → Mart Layer → ML Feature Engineering & Batch Inference.

## Быстрый старт

Требования: **Docker** и **docker-compose** (Docker Desktop или docker engine + compose plugin). Больше ничего.

```bash
git clone https://github.com/andreyst18/logistics-analytics.git
cd logistics-analytics
cp .env.example .env
docker-compose up --build