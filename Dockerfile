# --- STAGE 1: Builder ---
FROM python:3.11-slim AS builder

# Install uv and build tools in a standard Debian-based image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uv/bin/
RUN apt-get update && apt-get install -y build-essential

# Create the target directory and install the packages
WORKDIR /install
RUN /uv/bin/uv pip install --target /install 'requests==2.32.5' 'txtai==9.6.0'

# --- STAGE 2: Final Image ---
FROM n8nio/runners:2.10.4

USER root

# Copy the pre-installed packages from the builder stage
# We place them exactly where the n8n runner expects them
COPY --from=builder /install /opt/runners/task-runner-python

# Copy your config
COPY ./n8n_configs/n8n-task-runners.json /etc/n8n-task-runners.json

# Fix permissions
RUN chown -R runner:runner /opt/runners/task-runner-python \
 && chown runner:runner /etc/n8n-task-runners.json \
 && chmod 644 /etc/n8n-task-runners.json

USER runner