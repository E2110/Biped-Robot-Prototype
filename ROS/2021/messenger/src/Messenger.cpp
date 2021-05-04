#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/JointState.h"
#include "messages_pkg/imu_angles.h"
#include "messages_pkg/encoder_angles.h"

#include <vector>

#define PI 3.14159

float leg1_ground_angle;
float leg2_ground_angle;
float leg1_torso_angle;
float leg2_torso_angle;
float torso_ground_angle;

void printLegGroundAngle(const messages_pkg::imu_angles msg)
{
    ROS_INFO("Leg to ground angle = %f \n Leg to ground angle = %f", msg.leg1_angle, msg.leg2_angle);
    leg1_ground_angle = msg.leg1_angle;
    leg2_ground_angle = msg.leg2_angle;
}

void printLegTorsoAngle(const messages_pkg::encoder_angles msg)
{
    ROS_INFO("Leg to encoder angle = %f \n Leg to ground angle = %f", msg.leg1_torso_angle, msg.leg2_torso_angle);
    leg1_torso_angle = msg.leg1_torso_angle;
    leg2_torso_angle = msg.leg2_torso_angle;
}



int main(int argc, char **argv)
{
    ros::init(argc, argv, "messenger");
    ros::NodeHandle n;
    ros::Subscriber imu_sub = n.subscribe("leg_ground_angles", 1,printLegGroundAngle);
    ros::Subscriber encoder_sub = n.subscribe("leg_torso_angles", 1,printLegTorsoAngle);
    ros::Publisher chatter_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
    ros::Rate loop_rate(60);
    sensor_msgs::JointState js;

    js.name.push_back("base_to_leg_01");
    js.name.push_back("base_to_leg_02");
    js.name.push_back("base_to_torso");

    js.position.push_back(0.0);
    js.position.push_back(0.0);
    js.position.push_back(0.0);


    while(ros::ok())
    {
        ros::spinOnce();


        js.header.stamp = ros::Time::now(); 
        js.header.seq ++;
        js.position[0] = leg1_ground_angle * PI/180;
        js.position[1] = leg2_ground_angle * PI/180;

        torso_ground_angle = (leg1_ground_angle + leg1_torso_angle + leg2_ground_angle + leg2_torso_angle)/2;
        js.position[3] = torso_ground_angle;

        chatter_pub.publish(js);
        loop_rate.sleep();
    }

    return 0;
}