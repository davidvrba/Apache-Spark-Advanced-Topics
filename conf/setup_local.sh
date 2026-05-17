#!/bin/bash

# Local installer for macOS. Installs Java 17, Apache Spark 4.1.1
# and the Iceberg Spark runtime JAR. Python deps come from Poetry.

set -e

SPARK_VERSION=4.1.1
ICEBERG_VERSION=1.10.1
SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop3
INSTALL_DIR=$HOME/spark-releases

# Java 17
brew install openjdk@17

# Spark (live mirror — fast for current releases)
mkdir -p "$INSTALL_DIR"
curl -fL "https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" -o /tmp/${SPARK_PACKAGE}.tgz
tar xzf /tmp/${SPARK_PACKAGE}.tgz -C "$INSTALL_DIR"
rm /tmp/${SPARK_PACKAGE}.tgz

# Iceberg runtime JAR
curl -fL "https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-4.0_2.13/${ICEBERG_VERSION}/iceberg-spark-runtime-4.0_2.13-${ICEBERG_VERSION}.jar" \
    -o "$INSTALL_DIR/$SPARK_PACKAGE/jars/iceberg-spark-runtime-4.0_2.13-${ICEBERG_VERSION}.jar"

echo
echo "Done. Add the following to your shell profile:"
echo
echo "  export JAVA_HOME=\"\$(brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home\""
echo "  export SPARK_HOME=\"$INSTALL_DIR/$SPARK_PACKAGE\""
echo "  export PATH=\"\$SPARK_HOME/bin:\$PATH\""
