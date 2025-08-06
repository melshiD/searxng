FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install git and clone SearXNG into subfolder
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/searxng/searxng.git /app/searxng

# Create virtual environment and install dependencies
RUN python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install --upgrade pip \
    && pip install -r /app/searxng/requirements.txt

# Copy your custom settings.yml into the SearXNG folder
COPY settings.yml /app/searxng/searx/settings.yml

# Expose port
EXPOSE 8080

# Run the app using the virtual environment’s Python
CMD ["/venv/bin/python3", "-m", "searx.webapp", "--settings", "/app/searxng/searx/settings.yml"]
