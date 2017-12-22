#!/bin/sh

sed -r -i "s/AWS_ACCESS_KEY_ID/$AWS_ACCESS_KEY_ID/g" /root/.aws/credentials

sed -r -i  "s#AWS_SECRET_ACCESS_KEY#$AWS_SECRET_ACCESS_KEY#g" /root/.aws/credentials

sed -r -i "s/AWS_AVAILABILITY_ZONE/$AWS_AVAILABILITY_ZONE/g" /root/.aws/credentials



instance=$(curl -XGET  http://169.254.169.254/latest/meta-data/instance-id)

  aws cloudwatch put-metric-alarm --alarm-name "$NODE_ENV""-High-Disk-Utilization-""$instance" \
  --metric-name DiskSpaceUtilization --namespace System/Linux \
  --statistic Average --period 300 --threshold 70 --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=$instance Name=Filesystem,Value=overlay Name=MountPath,Value=/ \
  --evaluation-periods 1 --alarm-actions $ARN --ok-actions $ARN

  aws cloudwatch put-metric-alarm --alarm-name "$NODE_ENV""-High-CPU-Utilization-""$instance" \
  --metric-name CPUUtilization --namespace AWS/EC2 \
  --statistic Average --period 300 --threshold 80 --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=$instance   --evaluation-periods 1 --alarm-actions $ARN --ok-actions $ARN

  aws cloudwatch put-metric-alarm --alarm-name "$NODE_ENV""-High-Memory-Utilization-""$instance" \
  --metric-name MemoryUtilization --namespace System/Linux \
  --statistic Average --period 300 --threshold 75 --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=$instance   --evaluation-periods 1 --alarm-actions $ARN --ok-actions $ARN

while true; do

  ./mon-put-instance-data.pl --mem-util  --mem-avail \
  --disk-space-util --disk-path=/ \
  --swap-util --aggregated\
  --aws-access-key-id $AWS_ACCESS_KEY_ID --aws-secret-key $AWS_SECRET_ACCESS_KEY

  sleep 60
done