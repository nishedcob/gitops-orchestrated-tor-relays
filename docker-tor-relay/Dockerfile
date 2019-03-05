
FROM debian:stretch

SHELL ["/bin/bash", "-c"]

RUN apt-get update && echo $'\n\
deb https://deb.torproject.org/torproject.org stretch main\n\
deb-src https://deb.torproject.org/torproject.org stretch main\n\
\n' | tee /etc/apt/sources.list.d/tor.list && \
  apt-get install -y apt-transport-https && \
  apt-get install -y curl gnupg && \
  curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import && \
  gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - && \
  apt-get update && \
  apt-get install -y tor deb.torproject.org-keyring && \
  apt-get remove -y curl gnupg && \
  apt-get autoremove -y && \
  apt-get clean

RUN echo $'\n\
Nickname NAME_ME_PLEASE\n\
ORPort TOR_PORT\n\
ExitRelay EXIT_RELAY\n\
SocksPort SOCKS_PORT\n\
ControlSocket CONTROL_SOCKET\n\
ContactInfo CONTACT_INFO\n\
''#'$' FamilyName FAMILY_NAME\n\
MaxMemInQueues MAX_MEMORY\n\
' | tee /etc/tor/torrc

RUN /usr/bin/install -Z -m 02755 -o debian-tor -g debian-tor -d /var/run/tor

ENV RELAY_NICKNAME="torrelaydocker" TOR_PORT="443" EXIT_RELAY="0" \
  SOCKS_PORT="0" CONTROL_SOCKET="0" CONTACT_INFO="" MAX_MEMORY="256"

COPY start.sh /usr/bin/start.sh

RUN chmod +x -c /usr/bin/start.sh

ENTRYPOINT "/usr/bin/start.sh"
