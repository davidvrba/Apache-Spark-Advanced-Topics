source /opt/venv/bin/activate

pip install --upgrade pip

# Python libraries used in the training.
pip install py4j
pip install pyspark==4.1.1
pip install jsonschema
pip install numpy==2.1.3
pip install pandas==2.2.3
pip install pyarrow==19.0.1
pip install matplotlib==3.10.1
pip install scipy==1.15.2
pip install jupyter

# ------------------------------------------------------------------
# Apache Spark 4.1.1 (newest stable release).
# Spark 4.x requires Java 17+ and ships against Scala 2.13.
# ------------------------------------------------------------------
SPARK_VERSION=4.1.1
SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop3

wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz
tar xvf ${SPARK_PACKAGE}.tgz
rm ${SPARK_PACKAGE}.tgz

# ------------------------------------------------------------------
# Apache Iceberg runtime — we keep the Spark 4.0 build (Scala 2.13).
# Iceberg has not released a 4.1-targeted runtime yet; the 4.0 jar
# works on Spark 4.1 for the operations used in the notebooks
# (known incompat: CREATE VIEW, which we do not use).
# ------------------------------------------------------------------
ICEBERG_VERSION=1.10.1
ICEBERG_JAR=iceberg-spark-runtime-4.0_2.13-${ICEBERG_VERSION}.jar

wget -P /home/ubuntu/${SPARK_PACKAGE}/jars/ \
    https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-4.0_2.13/${ICEBERG_VERSION}/${ICEBERG_JAR}

mkdir -p ~/.jupyter
cp /home/ubuntu/Apache-Spark-Advanced-Topics/conf/jupyter_notebook_config.py ~/.jupyter/

echo "export SPARK_HOME=/home/ubuntu/${SPARK_PACKAGE}" >> /opt/venv/bin/activate
echo 'export PATH=$SPARK_HOME/bin:$PATH' >> /opt/venv/bin/activate
echo 'export PYSPARK_PYTHON=python3' >> /opt/venv/bin/activate
# Spark 4 needs Java 17 on PATH (installed via openjdk-17-jdk).
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> /opt/venv/bin/activate
