FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for Playwright and PostgreSQL (Playwright runtime deps)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    gnupg \
    libpq-dev \
    gcc \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libxkbcommon0 \
    libgbm1 \
    libgtk-3-0 \
    libasound2 \
    libpangocairo-1.0-0 \
    libxcomposite1 \
    libxrandr2 \
    libxss1 \
    libx11-xcb1 \
    libxdamage1 \
    libxfixes3 \
    libxcursor1 \
    libxi6 \
    libxcb1 \
    libxrender1 \
    libxtst6 \
    fonts-liberation \
    lsb-release \
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
