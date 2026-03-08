FROM n8nio/runners:2.10.4
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cd /opt/runners/task-runner-python && \
    uv pip install 'requests==2.32.5' 'txtai==9.6.0'
COPY ./n8n_configs/n8n-task-runners.json /etc/n8n-task-runners.json

RUN chown runner:runner /etc/n8n-task-runners.json \
 && chmod 644 /etc/n8n-task-runners.json

USER runner
