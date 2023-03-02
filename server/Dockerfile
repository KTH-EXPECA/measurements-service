FROM golang:1.19.3
RUN go install github.com/heistp/irtt/cmd/irtt@latest
COPY server-entrypoint.sh /tmp/server-entrypoint.sh
RUN chmod +x /tmp/server-entrypoint.sh

ENTRYPOINT ["/tmp/server-entrypoint.sh"]
