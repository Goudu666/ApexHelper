#!/usr/bin/env bash

set -u

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TOMCAT_HOME="/home/jy/apps/tomcat9"
APP_URL="http://localhost:8080/ApexHelper"
TOMCAT_LOG="$TOMCAT_HOME/logs/catalina.out"

cd "$PROJECT_DIR" || exit 1

echo "========================================"
echo "ApexHelper 开发环境启动脚本"
echo "项目目录: $PROJECT_DIR"
echo "Tomcat: $TOMCAT_HOME"
echo "========================================"

run_as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

is_mysql_running() {
  if command -v mysqladmin >/dev/null 2>&1 && mysqladmin ping --silent >/dev/null 2>&1; then
    return 0
  fi

  if command -v pgrep >/dev/null 2>&1; then
    pgrep -x mysqld >/dev/null 2>&1 && return 0
    pgrep -x mariadbd >/dev/null 2>&1 && return 0
  fi

  return 1
}

start_mysql() {
  echo
  echo "[1/3] 检查 MySQL 状态..."

  if is_mysql_running; then
    echo "MySQL 已经在运行。"
    return 0
  fi

  echo "MySQL 没有运行，尝试启动 MySQL..."

  if command -v systemctl >/dev/null 2>&1; then
    echo "尝试: systemctl start mysql"
    run_as_root systemctl start mysql && sleep 1 && is_mysql_running && {
      echo "MySQL 已通过 systemctl 启动。"
      return 0
    }

    echo "尝试: systemctl start mysqld"
    run_as_root systemctl start mysqld && sleep 1 && is_mysql_running && {
      echo "MySQL 已通过 systemctl 启动。"
      return 0
    }

    echo "尝试: systemctl start mariadb"
    run_as_root systemctl start mariadb && sleep 1 && is_mysql_running && {
      echo "MariaDB/MySQL 已通过 systemctl 启动。"
      return 0
    }
  fi

  if command -v service >/dev/null 2>&1; then
    echo "尝试: service mysql start"
    run_as_root service mysql start && sleep 1 && is_mysql_running && {
      echo "MySQL 已通过 service 启动。"
      return 0
    }

    echo "尝试: service mysqld start"
    run_as_root service mysqld start && sleep 1 && is_mysql_running && {
      echo "MySQL 已通过 service 启动。"
      return 0
    }

    echo "尝试: service mariadb start"
    run_as_root service mariadb start && sleep 1 && is_mysql_running && {
      echo "MariaDB/MySQL 已通过 service 启动。"
      return 0
    }
  fi

  if command -v mysql.server >/dev/null 2>&1; then
    echo "尝试: mysql.server start"
    mysql.server start && sleep 1 && is_mysql_running && {
      echo "MySQL 已通过 mysql.server 启动。"
      return 0
    }
  fi

  echo "MySQL 启动失败。请先手动启动 MySQL，然后重新运行本脚本。"
  return 1
}

is_tomcat_running() {
  if command -v pgrep >/dev/null 2>&1; then
    pgrep -f "catalina.home=$TOMCAT_HOME" >/dev/null 2>&1
    return $?
  fi

  return 1
}

start_tomcat() {
  echo
  echo "[2/3] 启动 Tomcat..."

  if [ ! -f "$TOMCAT_HOME/bin/startup.sh" ]; then
    echo "找不到 Tomcat 启动脚本: $TOMCAT_HOME/bin/startup.sh"
    exit 1
  fi

  if is_tomcat_running; then
    echo "Tomcat 已经在运行。"
    return 0
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
  echo "[3/3] 开发环境启动完成。"
  echo "访问地址: $APP_URL"

  if [ ! -d "$TOMCAT_HOME/webapps/ApexHelper" ]; then
    echo "提示: 如果浏览器打不开项目，请确认 ApexHelper 已部署到 Tomcat 的 webapps 目录。"
  fi

  echo
  echo "最近 30 行 Tomcat 日志:"
  echo "----------------------------------------"
  if [ -f "$TOMCAT_LOG" ]; then
    tail -n 30 "$TOMCAT_LOG"
  else
    echo "暂时找不到日志文件: $TOMCAT_LOG"
  fi
  echo "----------------------------------------"
}

start_mysql || exit 1
start_tomcat
show_result
