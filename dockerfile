# Use the latest version of Debian slim
FROM debian:12-slim AS base

# Install only the necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    # other necessary packages \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Use the latest version of Python 3.9 slim
FROM python:3.9-slim AS python-base

# Install application dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app
WORKDIR /app

# Command to run the application
CMD ["python", "todo.py"]
