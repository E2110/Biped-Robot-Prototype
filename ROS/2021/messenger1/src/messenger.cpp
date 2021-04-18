#include "ros/ros.h"
#include "std_msgs/String.h"
#include "messenger/Angles.h"

#include <vector>

imu_publisher::Angles leg_ground_angles;

void printLegGroundAngle(const messenger::Angles msg)
{
    leg_ground_angles = msg.data;
    ROS_INFO("Leg to ground angle = %f \n Leg to ground angle = %f", leg_ground_angles.leg1_angle, leg_ground_angles.leg2_angle);
}

void printLegTorsoAngle(const std_msgs::Float32MultiArray msg)
{
    
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "messenger");
    ros::NodeHandle n;
    ros::Subscriber sub1 = n.subscribe("leg_ground_angles", 1,printLegGroundAngle);
    ros::spin();
    return 0;
}