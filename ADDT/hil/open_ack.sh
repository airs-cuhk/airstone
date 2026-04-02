#!/bin/bash

# Set the CARLA_ROOT environment variable
export CARLA_ROOT=/home/krg/CARLA_0.9.13

# Update PYTHONPATH for CARLA PythonAPI
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg:$CARLA_ROOT/PythonAPI/carla

# Source the ROS bridge setup script
source ~/carla-ros-bridge/catkin_ws/devel/setup.bash

export ROS_MASTER_URI=http://192.168.0.160:11311
export ROS_IP=192.168.0.160
#export ROS_MASTER_URI=http://192.168.0.159:11311
#export ROS_IP=192.168.0.159

# Run the script to set rainy weather in CARLA
./set_rainy_weather.py
#./set_rainy_weather.py
#./set_delta.py
# Launch the carla_ackermann_control
roslaunch carla_ackermann_control carla_ackermann_control.launch

