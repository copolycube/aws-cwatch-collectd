# aws-cwatch-collectd
Ansible playbook to install both AWS Cloudwatch + collectd, while detecting what is installed on each host in order to generate a custom collectd configuration file, directly from ansible using some templates.

I tried to minimize the number of metrics published by collectD in order to reduce the AWS Cloudwatch costs.


## Context
Run 1 playbook to install the following on the target EC2 instances (asuming linux / apt available) :
* Cloudwatch agent
  * gather a few metrics that can be handled directly at the AWS Cloudwatch Agent level 
  * using AWS exported variables to have a generic cloudwatch agent configuration : 

```
"append_dimensions": {
    			"AutoScalingGroupName": "${aws:AutoScalingGroupName}", 
    	 		"ImageId": "${aws:ImageId}",
    			"InstanceId": "${aws:InstanceId}",
    			"InstanceType": "${aws:InstanceType}"
    		}
```

* Collectd
  * gather custom metrics that can't be handled directly by the AWS Cloudwatch Agent with collectd
    * metric : status of the application, with curl
    * metric : process check of the application
    * metric : number of users logged in



For this, we use the following architecture
# Dependencies
* Cloudwatch agent installation role : christiangda.amazon_cloudwatch_agent
```ansible-galaxy install christiangda.amazon_cloudwatch_agent```

* CollectD : https://collectd.org
** Collectd plugin curl
** Collectd plugin processes
** Collectd plugin users
** Collectd plugin match_regexp


# Todo
* implement : Alarms https://docs.ansible.com/ansible/latest/collections/community/aws/ec2_metric_alarm_module.html
* implement : Collectd-Cloudwatch plugin https://github.com/awslabs/collectd-cloudwatch


# Notes
   |  Setting	 |   Value   |
   |------------|-----------|
   | Base directory for collectd |	/var/lib/collectd |
   | rrd data files	| /var/lib/collectd/rrd |
   | collectd .pid file	| /var/run/collectd.pid |
   | collectd plugin directory	| /usr/local/lib/collectd |
   | collectd types.db file	| /usr/local/share/collectd/types.db |
   | collectd base configuration file | /etc/collectd/collectd.conf.d/custom-collectd.conf |
   | collectd extra configuration directory | /etc/collectd/collectd.conf |
   
   

