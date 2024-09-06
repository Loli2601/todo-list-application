# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install any dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set environment variables
ENV FLASK_APP=todo.py
ENV FLASK_ENV=production

# Install Gunicorn
RUN pip install gunicorn

# Expose the port Flask runs on
EXPOSE 5000

# Run the application with Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "todo:app"]

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl --silent --fail http://localhost:5000/ || exit 1

# Metadata as described above
LABEL maintainer="your-email@example.com"
LABEL version="1.0"
