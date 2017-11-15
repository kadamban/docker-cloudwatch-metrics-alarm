# docker-cloudwatch-metrics-alarm
## Requesting people to follow mentioned steps, As I'm using this in Kubernetes environment
Monitor the AWS instance via container. Send Memory, Disk metrics, Create Alarm

Steps to Follow.

Update the aws_config with your IAM access key, secret key, region. 

Add variables for $NODE_ENV and $ARN (SNS for sending alerts) in entrypoint.sh

Checkout the repository

docker build -t yourdockerrepo:version .
 
docker push yourdockerrepo:version  # Add it to your private repo / if you are running on instance skip this command
  
docker run -it yourdockerrepo:version -d
