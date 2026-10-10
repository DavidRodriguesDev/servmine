#!/usr/bin/env bash
cd "$(dirname "$0")"

echo "🚀 Iniciando configuração do servidor..."

# 1. Sobe o daemon do playit se ainda não estiver rodando
sudo mkdir -p /run/playit
if ! pgrep -x playitd > /dev/null; then
  echo "🔌 Iniciando Playit.gg..."
  sudo nohup playitd > /tmp/playitd.log 2>&1 &
  sleep 2
fi

# 2. Sobe o crafty em background (o '&' é importante para o script continuar)
echo "🎮 Iniciando Crafty Controller..."
./minecraft/run_crafty.sh &
CRAFTY_PID=$!

# 3. O "Pulo do Gato": Loop de Keep-Alive
# O GitHub Codespace mata o ambiente se o terminal principal ficar inativo.
# Esse loop imprime algo a cada 4 minutos para resetar o timer de inatividade.
echo "✅ Servidor e túnel iniciados. Mantendo Codespace ativo..."
while true; do
  echo "[$(date)] 💓 Keep-alive: Codespace ativo (Crafty PID: $CRAFTY_PID)"
  sleep 240 # 240 segundos = 4 minutos. Mantém o terminal "acordado".
done