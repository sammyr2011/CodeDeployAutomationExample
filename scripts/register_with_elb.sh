#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1

# Query aws' meta data service to determine instance's ID
instanceID=$(curl http://169.254.169.254/latest/meta-data/instance-id)

# Update autoscaling group to use ELB health checks
aws autoscaling update-auto-scaling-group --auto-scaling-group-name SR-Infra-4-LinuxWebASG-A0PRU6YQ6EDT --health-check-type ELB

# register instances from the linux load balancer
aws elb register-instances-with-load-balancer --load-balancer LinuxWebELB --instances $instanceID
