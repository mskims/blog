---
layout: post
title: "처음 만나는 도커"
tags: [docker, devOps, infrastructure]
---

도커는 빠르게 성장하고 있는 커뮤니티를 가지고 있는 강력한 가상화 도구입니다.

기존 VM 개념과는 달리 커널을 공유하면서 컨테이너를 이미지 형태로 저장해 언제 어디서든 필요한 인프라 자원들을 그대로 사용할수 있습니다.

# Install

{% highlight bash %}
$ yum update
$ yum install docker
$ service docker start
{% endhighlight %}

# Valid service
{% highlight bash %}
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                             NAMES
S0MEHASHSTR1NG      {image-name}:{tag}  "executed command"       1 second ago        Up 1 second         {HOSTIP}:{HOSTPORT}->{CONTAINERPORT}/{PROTOCOL}   {ALIAS}
$ service docker status
{% endhighlight %}

# Search images
{% highlight bash %}
$ docker search --filter={COLUMN}={VALUE} {KEYWORD}
{% endhighlight %}

# Pull image
{% highlight bash %}
$ docker pull {IMAGE}:{TAG}
{% endhighlight %}

# Write Dockerfile
{% highlight bash %}
# Dockerfile
FROM {BASEIMAGE}:{TAG}
MAINTAINER mskims <plz33344@gmail.com>

RUN echo $(pwd)
{% endhighlight %}

# Build image
{% highlight bash %}
$ docker build -t {IMAGE}:{TAG} {PATH}
# ex
$ docker build -t hellodocker:0.1 .
{% endhighlight %}


# Set instance's user-data or launch configuration
{% highlight bash %}
#!/bin/bash -x
REGION=$(curl 169.254.169.254/latest/meta-data/placement/availability-zone/ | sed 's/[a-z]$//')
yum update -y
yum install ruby wget -y
yum install httpd
yum install docker -y
sudo usermod -aG docker ec2-user
service docker start
cd /home/ec2-user
wget https://aws-codedeploy-$REGION.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto
{% endhighlight %}
> You can easily skip this step to make your own instance image (aka AMI)
