#!/bin/bash

cd ~/CARLA_0.9.13/PythonAPI/util
python3 config.py --map 1313 -i

# Set the CARLA_ROOT environment variable
export CARLA_ROOT=/home/krg/CARLA_0.9.13

# Update PYTHONPATH for CARLA PythonAPI
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg:$CARLA_ROOT/PythonAPI/carla

# Source the ROS bridge setup script
source ~/carla-ros-bridge/catkin_ws/devel/setup.bash

# Set ROS master and IP addresses
export ROS_MASTER_URI=http://128.195.205.34:11311
export ROS_IP=128.195.205.34

#roslaunch carla_spawn_objects carla_spawn_objects.launch objects_definition_file:=/home/krg/carla-ros-bridge/catkin_ws/src/ros-bridge/carla_spawn_objects/config/objects_new.json
#roslaunch carla_spawn_objects carla_spawn_objects.launch
