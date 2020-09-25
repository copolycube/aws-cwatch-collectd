run-on-poc: install-collectd-cwagent.yml files/aws-cloudwatch-agent-config.json files/custom-collectd.conf.j2
	ansible-playbook -i /etc/ansible/ec2.py --limit "tag_Name_AwsValueOfTagNameWhereToRun" install-collectd-cwagent.yml

install-role:
	ansible-galaxy install christiangda.amazon_cloudwatch_agent
