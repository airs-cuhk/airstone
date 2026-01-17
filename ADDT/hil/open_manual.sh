#!/bin/bash

# Set the CARLA_ROOT environment variable
export CARLA_ROOT=/home/krg/CARLA_0.9.13

# Update PYTHONPATH for CARLA PythonAPI
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg:$CARLA_ROOT/PythonAPI/carla

# Source the ROS bridge setup script
source ~/carla-ros-bridge/catkin_ws/devel/setup.bash

# Set ROS master and IP addresses
#export ROS_MASTER_URI=http://128.195.205.34:11311
#export ROS_MASTER_URI=http://128.195.205.82:11311
#export ROS_IP=128.195.205.34
export ROS_MASTER_URI=http://192.168.0.159:11311
export ROS_IP=192.168.0.159

# Launch the carla_manual_control
roslaunch carla_manual_control carla_manual_control.launch role_name:=test_vehicle_1

