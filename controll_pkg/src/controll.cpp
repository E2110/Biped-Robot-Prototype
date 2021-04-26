#include "ros/ros.h"
#include "std_msgs/String.h"
#include "controll_pkg/encoder_anlges.h"
#include "controll_pkg/imu_angles.h"
#include "controll_pkg/motor_values.h"

#include <vector>

#define LPS 60 //loops per second

std::vector <float> imuAngles (2);// this vector will contain the angles of the angles from the imu's.
std::vector <float> encoderAngles (2);//this vector will contain the angles from the encoder's.

void getLegGroundAngle(const controll_pkg::imu_angles msg)
{
    imuAngles[0] = msg.leg1_ground_angle;
    imuAngles[1] = msg.leg1_ground_angle;
}

void getLegTorsoAngle(const controll_pkg::encoder_angles msg)
{
    encoderAngles[0] = msg.leg1_torso_angle;
    encoderAngles[1] = msg.leg1_torso_angle;
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "controller");
    ros::NodeHandle n;
    ros::Subscriber imu_sub = n.subscribe("leg_ground_angles", 1,getLegGroundAngle);
    ros::Subscriber encoder_sub = n.subscribe("leg_torso_angles", 1,getLegTorsoAngle);
    ros::Publisher motor_pub = n.advertise<controll_pkg::motor_values>("motor_values", 1);
    ros::Rate loop_rate(LPS);

    controll_pkg::motor_values motor_values;  



    while(ros::ok())
    {
        ros::spinOnce();//gets new values if the imu's or encoder's has been updated since last time this function was called.

        //controll code goes here

        motor_values.motor1_value = 0;//motor1_value will be the value the sent to the motor by the publisher
        motor_values.motor2_value = 0;//motor2_value will be the value the sent to the motor by the publisher
        

        motor_pub.publish(motor_values);//call this function when you want to update the motor values.
        loop_rate.sleep();
    }

    return 0;
}