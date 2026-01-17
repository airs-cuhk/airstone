#!/bin/bash

cd ~/CARLA_0.9.13/PythonAPI/util
python3 config.py --map 1313 -i

# Set the CARLA_ROOT environment variable
export CARLA_ROOT=/home/krg/CARLA_0.9.13

# Update PYTHONPATH for CARLA PythonAPI
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py2.7-linux-x86_64.egg:$CARLA_ROOT/PythonAPI/carla

# Source the ROS bridge setup script
source ~/carla-ros-bridge/catkin_ws/devel/setup.bash

# Set ROS master and IP addresses
#export ROS_MASTER_URI=http://128.195.205.34:11311
#export ROS_IP=128.195.205.34
#export ROS_MASTER_URI=http://192.168.0.160:11311
#export ROS_IP=192.168.0.160
export ROS_MASTER_URI=http://192.168.0.159:11311
export ROS_IP=192.168.0.159

# Launch the carla_ackermann_control
#roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=58.8,-78.2,0.5,0,0,180 role_name:=test_vehicle
#roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=58.8,-78.2,0.5,0,0,180
#roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch spawn_point:=-10.3,-78.3,0.5,0,0,179
roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch role_name:=test_vehicle_1
#roslaunch carla_ad_demo carla_ad_demo.launch
#roslaunch carla_walker_agent carla_walker_agent.launch
