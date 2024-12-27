FROM debian:bookworm-slim
LABEL maintainer="1Games <hello@1games.ru>"

WORKDIR /usr/src/ragemp

RUN echo 'deb http://httpredir.debian.org/debian testing main contrib non-free' > /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y -t testing --no-install-recommends libstdc++6 libatomic1 ca-certificates procps wget \
  && wget -O /tmp/linux_x64.tar.gz https://cdn.rage.mp/updater/prerelease/server-files/linux_x64.tar.gz \
  && tar -xzf /tmp/linux_x64.tar.gz -C /tmp \
  && mv /tmp/ragemp-srv/ragemp-server ./ragemp-server \
  && mv /tmp/ragemp-srv/bin ./bin \
  && rm -rf /tmp/linux_x64.tar.gz /tmp/ragemp-srv \
  && chmod +x ./ragemp-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 22005/tcp 22005/udp 22006/tcp

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/src/ragemp/ragemp-server"]

