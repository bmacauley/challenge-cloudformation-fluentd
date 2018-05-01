# challenge-cloudformation-fluentd

Create a Cloudformation Stackset to setup an EC2 instance and install td-agent

## Assumptions
- The user sufficient AWS privs to run the Cloudformation template in AWS
- The user will set up and EC2 key pair and configure this in KeyName in .env.json



## Usage
```
(1) make build_s3

(2) make upload_files

(3) make build



```


## To Do
Due to the time constraints the solution is not fully working. The following items need some work...

(1) The ec2.yml template is not downloading and running the shell scripts to install security updates, configure AWS Time Sync and install and configure Fluentd

(2) More time is needed to configure Fluentd and ensure it is working correctly to write logs to the bucket. 




## Authors
* [Brian Macauley](https://github.com/bmacauley) &lt;brian.macauley@gmail.com&gt;

## License
[MIT](/LICENSE)
