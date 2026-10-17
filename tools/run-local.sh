#!/usr/bin/env bash
# 本地启动 ERP：编译 + 内嵌 Tomcat 7，端口 8888，上下文 /erp
# 这套栈是 Struts 2.3 / Spring 4.3 / Hibernate 5.0，只认 Java 8 或 11；用 17+ 会起不来
set -euo pipefail

find_java() {
  for c in /opt/homebrew/opt/openjdk@11 /opt/homebrew/opt/openjdk@8 \
           /Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home \
           /Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home; do
    [[ -x "$c/bin/java" ]] && { echo "$c"; return; }
  done
  /usr/libexec/java_home -v 11 2>/dev/null || /usr/libexec/java_home -v 1.8 2>/dev/null || true
}

JAVA_HOME_CANDIDATE="$(find_java)"
if [[ -z "$JAVA_HOME_CANDIDATE" ]]; then
  echo "没找到 Java 8 或 11。装一个（都有 Apple Silicon 原生包）："
  echo "  brew install --cask zulu@8      # 或 corretto@8"
  echo "注意 temurin@8 只有 x64 包，这台机器上别用。"
  exit 1
fi

export JAVA_HOME="$JAVA_HOME_CANDIDATE"
VER="$("$JAVA_HOME/bin/java" -version 2>&1 | head -1)"
echo "==> 使用 JAVA_HOME=$JAVA_HOME"
echo "==> $VER"

# Java 9+ 才需要放开反射；Hibernate 5.0 的字节码库和 Spring 4.3 的 CGLIB 都依赖它
if [[ "$VER" == *'"1.'* ]]; then
  export MAVEN_OPTS=""
else
  export MAVEN_OPTS="--illegal-access=permit"
fi

cd erp_parent
echo "==> 编译安装（跳过测试）"
mvn -B clean install

echo "==> 启动 http://localhost:8888/erp/login.html  （默认账号 admin / admin）"
exec mvn -B -pl erp_web tomcat7:run
