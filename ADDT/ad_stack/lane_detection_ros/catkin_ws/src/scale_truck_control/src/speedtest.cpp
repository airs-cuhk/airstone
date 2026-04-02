#include <ros/ros.h>
#include "scale_truck_control/xav2lrc.h"
#include <iostream>

using namespace std;

void getVel(const scale_truck_control::xav2lrc &msg)
{
    float velocity = msg.tar_vel;
    ROS_INFO_STREAM("Received velocity: " << velocity << " m/s");
}

int main(int argc, char* argv[])
{
    cout << "good" << endl;
    ros::init(argc, argv, "xavier_velocity_subscriber");
    ros::NodeHandle nh;
    ros::Subscriber sub = nh.subscribe("/xavier_to_lrc_msg", 1, getVel);
    cout << "good !!" << endl;
    ros::spin();
    ROS_INFO("Hello, World!");
    cout << "good !!!" << endl;

    return 0;
}