#!/bin/bash

# Set the CARLA_ROOT environment variable
export CARLA_ROOT=/home/krg/CARLA_0.9.13

# Update PYTHONPATH for CARLA PythonAPI
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg:$CARLA_ROOT/PythonAPI/carla

# Source the ROS bridge setup script
source ~/carla-ros-bridge/catkin_ws/devel/setup.bash

# Set ROS master and IP addresses
export ROS_MASTER_URI=http://128.195.205.34:11311
#export ROS_MASTER_URI=http://128.195.205.82:11311
export ROS_IP=128.195.205.34

# Launch the carla_ackermann_control
#roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=58.8,-78.2,0.5,0,0,180 role_name:=test_vehicle
#roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=58.8,-78.2,0.5,0,0,180
#roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=-10.3,-78.3,0.5,0,0,179
roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=-9.6,-130.9,0.5,0,0,21
