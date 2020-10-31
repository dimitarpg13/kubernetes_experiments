#!/bin/bash
export EXAMPLE_JAR=$(microk8s kubectl exec -ti --namespace default my-spark-3-worker-0 -- find examples/jars/ -name spark-example*.jar | tr -d "\r")
microk8s kubectl exec -ti --namespace default my-spark-3-worker-0 -- spark-submit --master spark://my-spark-3-master-svc:7077 --class org.apache.spark.examples.SparkPi examples/jars/spark-examples_2.12-3.0.1.jar
