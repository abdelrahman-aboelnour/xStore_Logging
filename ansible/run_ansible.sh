( echo '[all]' && aws ec2 describe-instances --filters "Name=tag:VOIS_Task_EC2,Values=*" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text | awk '{print $0, "ansible_ssh_private_key_file=~/.ssh/vois/VOIS_Task.pem"}' ) > inventory.txt


ansible-playbook -i inventory.txt deploy_logger.yml;

