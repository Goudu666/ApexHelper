#!/usr/bin/env bash

set -u

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TOMCAT_HOME="/home/jy/apps/tomcat9"
APP_URL="http://localhost:8080/ApexHelper"
TOMCAT_LOG="$TOMCAT_HOME/logs/catalina.out"

cd "$PROJECT_DIR" || exit 1

echo "========================================"
echo "ApexHelper Tomcat 重启脚本"
echo "项目目录: $PROJECT_DIR"
echo "Tomcat: $TOMCAT_HOME"
echo "========================================"

is_tomcat_running() {
  if command -v pgrep >/dev/null 2>&1; then
    pgrep -f "catalina.home=$TOMCAT_HOME" >/dev/null 2>&1
    return $?
  fi

  return 1
}

stop_tomcat() {
  echo
  echo "[1/3] 关闭 Tomcat..."

  if [ ! -f "$TOMCAT_HOME/bin/shutdown.sh" ]; then
    echo "找不到 Tomcat 关闭脚本: $TOMCAT_HOME/bin/shutdown.sh"
    exit 1
  fi

  if ! is_tomcat_running; then
    echo "Tomcat 当前没有运行，跳过关闭步骤。"
    return 0
  fi

  bash "$TOMCAT_HOME/bin/shutdown.sh"

  echo "等待 Tomcat 退出..."
  for _ in 1 2 3 4 5 6 7 8 9 10; do
    if ! is_tomcat_running; then
      echo "Tomcat 已关闭。"
      return 0
    fi
    sleep 1
  done

  echo "Tomcat 可能还在关闭中。如果端口仍被占用，请稍等后再运行本脚本。"
}

start_tomcat() {
  echo
  echo "[2/3] 重新启动 Tomcat..."

  if [ ! -f "$TOMCAT_HOME/bin/startup.sh" ]; then
    echo "找不到 Tomcat 启动脚本: $TOMCAT_HOME/bin/startup.sh"
    exit 1
  fi

  bash "$TOMCAT_HOME/bin/startup.sh"
  if [ $? -ne 0 ]; then
    echo "Tomcat 启动失败，请查看日志: $TOMCAT_LOG"
    exit 1
  fi

  sleep 2
  echo "Tomcat 启动命令已执行。"
}

show_result() {
  echo
  echo "[3/3] 最近 50 行 Tomcat 日志:"
  echo "----------------------------------------"
  if [ -f "$TOMCAT_LOG" ]; then
    tail -n 50 "$TOMCAT_LOG"
  else
    echo "暂时找不到日志文件: $TOMCAT_LOG"
  fi
  echo "----------------------------------------"
  echo
  echo "访问地址: $APP_URL"
}

stop_tomcat
start_tomcat
show_result
