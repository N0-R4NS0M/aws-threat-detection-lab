import json
import boto3

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    print("Event:", json.dumps(event))
    
    try:
        instance_id = event['detail']['resource']['instanceDetails']['instanceId']
    except KeyError:
        print("No EC2 instance ID found in event.")
        return

    # Tag instance as quarantined
    ec2.create_tags(Resources=[instance_id], Tags=[{'Key': 'Quarantine', 'Value': 'True'}])
    print(f"Tagged {instance_id} as Quarantine")

    # Remove all ingress rules from associated security groups
    instance = ec2.describe_instances(InstanceIds=[instance_id])['Reservations'][0]['Instances'][0]
    for sg in instance['SecurityGroups']:
        sg_id = sg['GroupId']
        sg_info = ec2.describe_security_groups(GroupIds=[sg_id])['SecurityGroups'][0]
        for rule in sg_info['IpPermissions']:
            ec2.revoke_security_group_ingress(GroupId=sg_id, IpPermissions=[rule])
            print(f"Removed rule from {sg_id}")

    return {"status": "isolated", "instance_id": instance_id}
