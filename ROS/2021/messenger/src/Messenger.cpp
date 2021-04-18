#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/JointState.h"
#include "messenger/Angles.h"

#include <vector>

#define PI 3.14159

float leg1_ground_angle;
float leg2_ground_angle;

void printLegGroundAngle(const messenger::Angles msg)
{
    ROS_INFO("Leg to ground angle = %f \n Leg to ground angle = %f", msg.leg1_angle, msg.leg2_angle);
    leg1_ground_angle = msg.leg1_angle;
    leg2_ground_angle = msg.leg2_angle;
}

void printLegTorsoAngle(const messenger::Angles msg)
{
    
}



int main(int argc, char **argv)
{
    ros::init(argc, argv, "messenger");
    ros::NodeHandle n;
    ros::Subscriber sub1 = n.subscribe("leg_ground_angles", 1,printLegGroundAngle);
    ros::Publisher chatter_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
    ros::Rate loop_rate(60);
    sensor_msgs::JointState js;

    js.name.push_back("base_to_leg_01");
    js.name.push_back("base_to_leg_02");

    js.position.push_back(0.0);
    js.position.push_back(0.0);

    while(ros::ok())
    {
        js.header.stamp = ros::Time::now(); 
        js.header.seq ++;
        js.position[0] = leg1_ground_angle * PI/180;
        js.position[1] = leg2_ground_angle * PI/180;
        chatter_pub.publish(js);
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}