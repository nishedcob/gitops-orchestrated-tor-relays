#! /bin/bash

TOR_CONFIG_FILE="/etc/tor/torrc"

function config_injection() {
  SEARCH_EXPR=$1
  REPLACE_EXPR=$2
  FILE=$TOR_CONFIG_FILE
  CMD="sed 's/$SEARCH_EXPR/$REPLACE_EXPR/' -i '$FILE'"
  echo "$CMD"
  return $(eval "$CMD")
}

config_injection "\(Nickname \)NAME_ME_PLEASE" "\1$RELAY_NICKNAME"
config_injection "\(ORPort \)TOR_PORT" "\1$TOR_PORT"
config_injection "\(ExitRelay \)EXIT_RELAY" "\1$EXIT_RELAY"
config_injection "\(SocksPort \)SOCKS_PORT" "\1$SOCKS_PORT"
config_injection "\(ControlSocket \)CONTROL_SOCKET" "\1$CONTROL_SOCKET"
config_injection "\(ContactInfo \)CONTACT_INFO" "\1$CONTACT_INFO"
config_injection "\(MaxMemInQueues \)MAX_MEMORY" "\1$MAX_MEMORY"

echo "$TOR_CONFIG_FILE:"
cat $TOR_CONFIG_FILE

# Pulled from /lib/system/tor@default.service:
TOR_BINARY="/usr/bin/tor"
TOR_DEFAULTS="--defaults-torrc /usr/share/tor/tor-service-defaults-torrc"
TOR_CONFIG_FILE="-f $TOR_CONFIG_FILE"
TOR_ARGS="--RunAsDaemon 0"
RUN_TOR="$TOR_BINARY $TOR_DEFAULTS $TOR_CONFIG_FILE $TOR_ARGS"

eval "$RUN_TOR --verify-config" && \
eval "$RUN_TOR"
