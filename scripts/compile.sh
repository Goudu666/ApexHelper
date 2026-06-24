#!/usr/bin/env bash

set -u

EXPECTED_PROJECT_DIR="/home/jy/code/codex-project/ApexHelper"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TOMCAT_HOME="/home/jy/apps/tomcat9"
SRC_DIR="$PROJECT_DIR/src"
CLASSES_DIR="$PROJECT_DIR/WebContent/WEB-INF/classes"
LIB_DIR="$PROJECT_DIR/WebContent/WEB-INF/lib"
SOURCE_LIST="/tmp/apexhelper-java-sources.$$"

cd "$PROJECT_DIR" || exit 1

cleanup() {
  rm -f "$SOURCE_LIST"
}
trap cleanup EXIT

echo "========================================"
echo "ApexHelper Java 编译脚本"
echo "项目目录: $PROJECT_DIR"
echo "源码目录: $SRC_DIR"
echo "输出目录: $CLASSES_DIR"
echo "========================================"

echo
echo "[1/5] 确认项目目录和 class 输出目录..."
CURRENT_DIR="$(pwd -P)"
if [ "$CURRENT_DIR" != "$EXPECTED_PROJECT_DIR" ]; then
  echo "安全检查失败: 当前目录不是预期项目目录。"
  echo "当前目录: $CURRENT_DIR"
  echo "预期目录: $EXPECTED_PROJECT_DIR"
  exit 1
fi

mkdir -p WebContent/WEB-INF/classes
if [ ! -d WebContent/WEB-INF/classes ]; then
  echo "安全检查失败: 无法创建 WebContent/WEB-INF/classes 目录。"
  exit 1
fi

REAL_CLASSES_DIR="$(cd WebContent/WEB-INF/classes && pwd -P)"
if [ "$REAL_CLASSES_DIR" != "$EXPECTED_PROJECT_DIR/WebContent/WEB-INF/classes" ]; then
  echo "安全检查失败: class 输出目录不是预期路径。"
  echo "当前 class 目录: $REAL_CLASSES_DIR"
  echo "预期 class 目录: $EXPECTED_PROJECT_DIR/WebContent/WEB-INF/classes"
  exit 1
fi

echo "已确认项目目录: $CURRENT_DIR"
echo "已确认 class 输出目录: $REAL_CLASSES_DIR"

echo
echo "[2/5] 清空旧的 class 文件..."
echo "只清理: WebContent/WEB-INF/classes/*"
rm -rf WebContent/WEB-INF/classes/*
echo "旧 class 清理完成。WebContent/WEB-INF/lib、web.xml、JSP、CSS、JS、图片和视频不会被删除。"

echo
echo "[3/5] 查找 src 目录下的 Java 文件..."
find "$SRC_DIR" -name "*.java" | sort > "$SOURCE_LIST"
SOURCE_COUNT="$(wc -l < "$SOURCE_LIST" | tr -d ' ')"

if [ "$SOURCE_COUNT" -eq 0 ]; then
  echo "没有找到任何 .java 文件，编译结束。"
  exit 1
fi

echo "找到 $SOURCE_COUNT 个 Java 文件。"

echo
echo "[4/5] 使用 javac 编译..."

CLASSPATH="$TOMCAT_HOME/lib/servlet-api.jar:$TOMCAT_HOME/lib/jsp-api.jar:$LIB_DIR/*:$CLASSES_DIR"

echo "classpath:"
echo "  $TOMCAT_HOME/lib/servlet-api.jar"
echo "  $TOMCAT_HOME/lib/jsp-api.jar"
echo "  $LIB_DIR/*"

if ! command -v javac >/dev/null 2>&1; then
  echo "编译失败: 找不到 javac。请确认已经安装 JDK，并且 javac 在 PATH 中。"
  exit 1
fi

javac -encoding UTF-8 -classpath "$CLASSPATH" -d "$CLASSES_DIR" @"$SOURCE_LIST"
JAVAC_STATUS=$?

if [ "$JAVAC_STATUS" -ne 0 ]; then
  echo
  echo "编译失败。上面已经显示 javac 的错误信息，请根据错误修改代码后再运行本脚本。"
  exit "$JAVAC_STATUS"
fi

echo
echo "[5/5] 统计生成的 .class 文件数量..."
CLASS_COUNT="$(find "$CLASSES_DIR" -name "*.class" | wc -l | tr -d ' ')"

echo "编译成功。"
echo "当前输出目录中的 .class 文件数量: $CLASS_COUNT"
