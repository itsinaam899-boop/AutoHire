FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for Playwright and PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies and Playwright browsers
ENV PLAYWRIGHT_BROWSERS_PATH=/app/ms-playwright
RUN python -m pip install --upgrade pip && \
    PLAYWRIGHT_BROWSERS_PATH=0 pip install -r requirements.txt && \
    PLAYWRIGHT_BROWSERS_PATH=/app/ms-playwright python -m playwright install chromium

# Copy application code
COPY . .

# Expose port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
