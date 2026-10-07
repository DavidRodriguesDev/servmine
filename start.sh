#!/usr/bin/env bash
cd "$(dirname "$0")"

# sobe o daemon do playit se ainda não estiver rodando
sudo mkdir -p /run/playit
if ! pgrep -x playitd > /dev/null; then
  sudo nohup playitd > /tmp/playitd.log 2>&1 &
  sleep 2
fi

# sobe o crafty
./minecraft/run_crafty.sh
