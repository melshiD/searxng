FROM python:3.11-slim

# Set working directory
WORKDIR /searxng

# Install git and clone SearXNG
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/searxng/searxng.git . 

# Create virtual environment and install dependencies inside it
RUN python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy custom settings.yml (optional if you're customizing)
COPY settings.yml ./searx/settings.yml

# Expose the port SearXNG uses
EXPOSE 8080

# Run the app using the virtual environment's Python
CMD ["/venv/bin/python3", "-m", "searx.webapp"]

