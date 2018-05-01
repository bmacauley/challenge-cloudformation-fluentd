# Notes

## Questions


## Research
[Working with AWS CloudFormation StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/what-is-cfnstacksets.html)  
[Cloudformation template anatomy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html)  
[Learn template basics](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/gettingstarted.templatebasics.html#gettingstarted.templatebasics.what)  
[Intrinsic Function Reference - Cloudformation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)




[Fluentd - Amazon S3 Output Plugin](https://docs.fluentd.org/v0.12/articles/out_s3)  
[All Data Are Belong to AWS: Streaming upload via Fluentd](https://aws.amazon.com/blogs/aws/all-your-data-fluentd/)  
[syslog Input Plugin](https://docs.fluentd.org/v0.12/articles/in_syslog)  
[Getting Data From Syslog Into S3 Using Fluentd](https://docs.fluentd.org/v0.12/articles/recipe-syslog-to-s3)  


## Cloudformation and other commands
aws ec2 describe-images --owners amazon --region eu-west-1\
  --filter "Name=name,Values=amzn-ami-hvm-2017.03.1.201708*" |
   jq -c '.Images[] | {ImageId, Name, Description}'



EC2 instance....

yum -y update


sudo yum -y update --security

sudo yum erase ntp*
sudo yum install chrony
sudo service chronyd start
sudo chkconfig chronyd on

sudo yum -y install git
sudo yum install -y ruby24 ruby24-devel rubygem24-rake
sudo alternatives --set ruby /usr/bin/ruby2.4
gem install bundler
sudo yum -y group install Development Tools
git clone https://github.com/fluent/fluentd.git
cd fluentd
bundle install
bundle exec rake build
gem install pkg/fluentd-1.2.0.gem
gem install fluent-plugin-s3 -v 1.0.0
sudo cp ~/bin/fluent* /usr/bin/

sudo fluentd --setup /etc/fluent

fluentd -c /etc/fluent/fluent.conf -vv &

pkill -f fluentd


curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh

/usr/sbin/td-agent-gem


sudo /etc/init.d/td-agent start





## Program flow


Create KMS key? ...use 

Create SSH key

Create security group

Create role/instance role

{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }
}

{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Action": ["s3:ListBucket"],
       "Resource": ["arn:aws:s3:::<BUCKET-NAME>"]
     },
     {
       "Effect": "Allow",
       "Action": [
         "s3:PutObject",
         "s3:GetObject"
       ],
       "Resource": ["arn:aws:s3:::<BUCKET-NAME>/*"]
     }
   ]
 }




Create S3 bucket


Create EC2 instance
- update critical security patches
- install ruby
- install fluentd from source
- 
