FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  git \
  curl \
  shared-mime-info \
  openjdk-14-jre \
&& rm -rf /var/lib/apt/lists/*

ARG VERSION="1.7.0"

RUN curl -sSL https://github.com/tlaplus/tlaplus/releases/download/v$VERSION/TLAToolbox-$VERSION.deb -o tla.deb \
  && dpkg -i tla.deb

COPY tla.sh /bin/tla.sh
RUN chmod +x /bin/tla.sh

ENTRYPOINT [ "/bin/tla.sh" ]
