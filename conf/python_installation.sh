#!/bin/bash

# Apache Spark 4.0.x requires Java 17 (or 21) and Python 3.10+.
# python3-venv on Ubuntu 22.04+ already ships Python 3.10+, which satisfies Spark 4.

apt-get update
apt-get --assume-yes install python3-pip python3-venv openjdk-17-jdk scala wget

python3 -m venv /opt/venv
chown -R ubuntu:ubuntu /opt/venv
