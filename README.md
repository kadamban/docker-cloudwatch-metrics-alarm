# docker-cloudwatch-metrics-alarm
Monitor the AWS instance via container. Send Memory, Disk metrics, Create Alarm
Update the aws_config with your IAM access key, secret key, region. 
Export variables for $NODE_ENV and $ARN (SNS for sending alerts)

Checkout the repository
docker build -t <docker repo:version> .
docker push <docker repo:version>  # Add it to your private repo / if you are running on instance skip this command
docker run -it <docker repo:version> -d
