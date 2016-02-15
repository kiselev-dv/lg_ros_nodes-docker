# Liquid Galaxy
#
# VERSION 0.1

FROM 	ubuntu:12.04
RUN     apt-get update

# Install basic stuff
RUN     apt-get install -qqy wget curl tmux

# Add ROS deb repo
RUN 	echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list
RUN	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5523BAEEB01FA116

# Add Chrome deb repo
RUN 	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN	echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

# Add GE deb repo
RUN	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN	echo "deb http://dl.google.com/linux/earth/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN     apt-get update

RUN 	apt-get install -qqy google-earth-stable google-chrome-stable

# Nvidia drivers
RUN 	apt-get install -y x-window-system
RUN 	apt-get install -y binutils
RUN 	apt-get install -y mesa-utils
RUN 	apt-get install -y module-init-tools

ADD 	nvidia-driver.run /tmp/nvidia-driver.run
RUN 	sh /tmp/nvidia-driver.run -a -N --ui=none --no-kernel-module
RUN 	rm /tmp/nvidia-driver.run

ENV 	DISPLAY :0

RUN	mkdir /home/galadmin
CMD	/bin/bash	
