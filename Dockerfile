FROM python:3.12-slim AS builder
WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip

RUN python -m venv .venv

COPY pyproject.toml uv.lock ./
COPY app/ ./app

RUN . .venv/bin/activate && pip install --upgrade pip && pip install .

# Stage 2: Runtime
FROM python:3.12-slim
WORKDIR /app

COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app ./app

EXPOSE 8080

CMD ["/app/.venv/bin/uvicorn", "app.main:app", "--port", "8080", "--host", "0.0.0.0"]