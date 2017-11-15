FROM alpine:3.3

RUN apk update && apk -v add coreutils curl python py-pip groff less unzip perl-libwww perl-datetime perl-lwp-protocol-https ca-certificates  && \
    pip install --upgrade awscli  python-magic && \
    rm /var/cache/apk/* && \
    mkdir -p /aws && \ 
    mkdir -p ~/.aws/

RUN wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip && \
    unzip CloudWatchMonitoringScripts-1.2.1.zip && \
    rm CloudWatchMonitoringScripts-1.2.1.zip

WORKDIR /aws-scripts-mon

RUN sed -i 's/-k -l -P/-kP/g' mon-put-instance-data.pl && apk --purge -v del py-pip

COPY ./aws_config  /root/.aws/credentials
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh


CMD ["./entrypoint.sh"]