#!/usr/bin/env bash

set -u

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TOMCAT_HOME="/home/jy/apps/tomcat9"

cd "$PROJECT_DIR" || exit 1

echo "========================================"
echo "ApexHelper 开发环境停止脚本"
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

is_tomcat_running() {
  if command -v pgrep >/dev/null 2>&1; then
    pgrep -f "catalina.home=$TOMCAT_HOME" >/dev/null 2>&1
    return $?
  fi

  return 1
}

stop_tomcat() {
  echo
  echo "[1/2] 关闭 Tomcat..."

  if [ ! -f "$TOMCAT_HOME/bin/shutdown.sh" ]; then
    echo "找不到 Tomcat 关闭脚本: $TOMCAT_HOME/bin/shutdown.sh"
    exit 1
  fi

  if ! is_tomcat_running; then
    echo "Tomcat 当前没有运行。"
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

  echo "Tomcat 可能还在关闭中。如果需要，请稍等后再次运行本脚本。"
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

stop_mysql() {
  echo "尝试停止 MySQL..."

  if ! is_mysql_running; then
    echo "MySQL 当前没有运行。"
    return 0
  fi

  if command -v systemctl >/dev/null 2>&1; then
    echo "尝试: systemctl stop mysql"
    run_as_root systemctl stop mysql && echo "MySQL 已通过 systemctl 停止。" && return 0

    echo "尝试: systemctl stop mysqld"
    run_as_root systemctl stop mysqld && echo "MySQL 已通过 systemctl 停止。" && return 0

    echo "尝试: systemctl stop mariadb"
    run_as_root systemctl stop mariadb && echo "MariaDB/MySQL 已通过 systemctl 停止。" && return 0
  fi

  if command -v service >/dev/null 2>&1; then
    echo "尝试: service mysql stop"
    run_as_root service mysql stop && echo "MySQL 已通过 service 停止。" && return 0

    echo "尝试: service mysqld stop"
    run_as_root service mysqld stop && echo "MySQL 已通过 service 停止。" && return 0

    echo "尝试: service mariadb stop"
    run_as_root service mariadb stop && echo "MariaDB/MySQL 已通过 service 停止。" && return 0
  fi

  if command -v mysql.server >/dev/null 2>&1; then
    echo "尝试: mysql.server stop"
    mysql.server stop && echo "MySQL 已通过 mysql.server 停止。" && return 0
  fi

  echo "MySQL 停止失败。你可以之后手动停止 MySQL。"
  return 1
}

ask_mysql() {
  echo
  echo "[2/2] 是否停止 MySQL?"
  echo "说明: MySQL 可以保持运行。继续开发时保持 MySQL 运行通常更方便。"

  if [ ! -t 0 ]; then
    echo "当前不是交互式终端，默认不停止 MySQL。"
    return 0
  fi

  printf "是否现在停止 MySQL? [y/N]: "
  read -r ANSWER

  case "$ANSWER" in
    y|Y|yes|YES)
      stop_mysql
      ;;
    *)
      echo "已选择不停止 MySQL。"
      ;;
  esac
}

stop_tomcat
ask_mysql

echo
echo "开发环境停止脚本执行完成。"
