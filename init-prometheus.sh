#!/bin/bash

# Define the location where the JAR file is uploaded on DBFS
metrics_jar_path="/Volumes/catalogtest1/bigdata/managed_volume/scripts/spark-metrics-assembly-3.5-1.0.0.jar"

# Copy over the necessary JARs to /databricks/jars/
cp ${metrics_jar_path} /databricks/jars/

# Configure JMX for metrics collection
cat > /databricks/spark/conf/jmxCollector.yaml <<EOL
lowercaseOutputName: false
lowercaseOutputLabelNames: false
whitelistObjectNames: ["*:*"]
EOL

# Configure Spark metrics to use the Prometheus Pushgateway as the target
pushgatewayHost=$PROMETHEUS_HOST
pushgatewayJobName=$PROMETHEUS_JOB_NAME
cat >> /databricks/spark/conf/metrics.properties <<EOL
# Enable Prometheus for all instances by class name
*.sink.prometheus.class=org.apache.spark.banzaicloud.metrics.sink.PrometheusSink
# Prometheus Pushgateway address
*.sink.prometheus.pushgateway-address-protocol=http
*.sink.prometheus.pushgateway-address=$pushgatewayHost
*.sink.prometheus.period=5
# Metrics name processing (version 2.3-1.1.0 +)
# *.sink.prometheus.metrics-name-capture-regex=<regular expression to capture sections metric name sections to be replaced>
# *.sink.prometheus.metrics-name-replacement=<replacement captured sections to be replaced with>
*.sink.prometheus.labels=job_name=$pushgatewayJobName
# Support for JMX Collector (version 2.3-2.0.0 +)
*.sink.prometheus.enable-dropwizard-collector=true
*.sink.prometheus.enable-jmx-collector=true
*.sink.prometheus.jmx-collector-config=/databricks/spark/conf/jmxCollector.yaml

# Enable HostName in instance instead of AppID (default value is false)
*.sink.prometheus.enable-hostname-in-instance=true

# Enable JVM metrics source for all instances by class name
*.sink.jmx.class=org.apache.spark.metrics.sink.JmxSink
*.source.jvm.class=org.apache.spark.metrics.source.JvmSource

# Optional: You can use custom metric filters if necessary
# *.sink.prometheus.metrics-filter-class=com.example.RegexMetricFilter
# *.sink.prometheus.metrics-filter-regex=com.example\.(.*)
EOL
