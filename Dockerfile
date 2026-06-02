FROM debian:bookworm-slim AS builder

COPY wisecow.sh /wisecow.sh
RUN chmod +x /wisecow.sh

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    fortune-mod \
    fortunes-min \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/games:${PATH}"

COPY --from=builder /wisecow.sh /wisecow.sh

EXPOSE 4499

CMD ["/wisecow.sh"]
