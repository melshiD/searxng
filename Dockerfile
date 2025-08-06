FROM alpine:latest

# Install dependencies
RUN apk add --no-cache python3 py3-pip git build-base libffi-dev openssl-dev

# Clone SearXNG
RUN git clone https://github.com/searxng/searxng.git /searxng

WORKDIR /searxng

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Add a default settings.yml (you’ll customize it below)
COPY settings.yml /searxng/searx/settings.yml

# Expose port
EXPOSE 8080

CMD ["python3", "-m", "searx.webapp"]
