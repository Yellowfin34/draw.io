#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2025 community-scripts ORG
# Modified for Draw.io Self-Hosted
# License: MIT
# Based on: https://github.com/jgraph/docker-drawio

APP="Draw.io"
var_tags="${var_tags:-diagramming}"
var_cpu="${var_cpu:-1}"
var_ram="${var_ram:-1024}"
var_disk="${var_disk:-4}"
var_os="${var_os:-debian}"
var_version="${var_version:-12}"
var_unprivileged="${var_unprivileged:-1}"

header_info "$APP"
variables
color
catch_errors

function update_script() {
  header_info
  check_container_storage
  check_container_resources
  if [[ ! -d /opt/drawio ]]; then
    msg_error "No ${APP} installation found!"
    exit
  fi

  msg_info "Pulling latest Draw.io image"
  cd /opt/drawio
  $STD docker-compose pull
  msg_ok "Pulled latest image"

  msg_info "Restarting Draw.io container"
  $STD docker-compose down
  $STD docker-compose up -d
  msg_ok "Restarted Draw.io container"

  msg_ok "Updated Successfully!"
  exit
}

start
build_container
description

msg_info "Installing Docker and Docker Compose"
$STD apt-get update
$STD apt-get install -y docker.io docker-compose
msg_ok "Installed Docker and Docker Compose"

msg_info "Setting up Draw.io Container"
mkdir -p /opt/drawio
cat <<EOF >/opt/drawio/docker-compose.yml
version: '3'

services:
  drawio:
    image: jgraph/drawio
    container_name: drawio
    restart: unless-stopped
    ports:
      - "8080:8080"
EOF

cd /opt/drawio
$STD docker-compose up -d
msg_ok "Set up Draw.io Container"

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}:8080${CL}"
