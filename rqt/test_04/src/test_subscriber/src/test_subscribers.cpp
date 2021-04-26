#include "ros/ros.h"
#include "std_msgs/String.h"

#include "test_subscriber/IMU_settings.h"


void chatterCallback(const test_subscriber::IMU_settings msg)
{
    ROS_INFO("%f", msg.KP);
}
int main(int argc, char **argv)
{
    //init
    ros::init(argc, argv, "test_subscriber");
    //message code
    ros::NodeHandle n;
    ros::Subscriber sub = n.subscribe("IMU_settings",1 ,chatterCallback);
    ros::spin();

    return 0;
}