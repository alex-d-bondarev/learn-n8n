FROM n8nio/runners:2.10.4
USER root
RUN cd /opt/runners/task-runner-python && uv pip install requests
COPY ./n8n_configs/n8n-task-runners.json /etc/n8n-task-runners.json

# Make sure the runner user can read it
RUN chown runner:runner /etc/n8n-task-runners.json \
 && chmod 644 /etc/n8n-task-runners.json

USER runner
