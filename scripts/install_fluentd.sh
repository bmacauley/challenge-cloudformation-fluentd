#!/bin/bash

# install fluentd from source
#


# Install git
yum -y install git

# Install development tools for compiling Fluentd
yum -y group install Development Tools

# Install Ruby 2.4(AMZ Linux default is 2.0)...Ruby2.1 or greater needed for Fluentd install
yum install -y ruby24 ruby24-devel rubygem24-rake
alternatives --set ruby /usr/bin/ruby2.4
gem install bundler


# Clone Fluentd source and compile
git clone https://github.com/fluent/fluentd.git
cd fluentd
bundle install
bundle exec rake build

# Install Fluentd
gem install pkg/fluentd-1.2.0.gem
gem install fluent-plugin-s3 -v 1.0.0


# Start Fluentd
fluentd -c /etc/fluent/fluent.conf -vv &
