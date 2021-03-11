#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/JointState.h"


#include <iostream>
#include <sstream>
#include <unistd.h>
#include <cmath>
#include <linux/i2c-dev.h>
#include <linux/i2c.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <math.h>

#define g_sens_accs 0.061 //value from datasheet page 12
#define PI 3.14159 // constant pi
#define LPS 60 // Loops per second




class LSM9DS1
{
    private :


    int file;
    char addr;
    float ax, ay, az, gx, gy, gz;
    short s_ax, s_ay, s_az, s_gx, s_gy, s_gz;
    float pitch,roll;

    char dataBuffer[5] = {0};
    char dataBuffer2[5] = {0};

    void convertAccelData()
    {
        s_ax = ((dataBuffer2[1] << 8) | dataBuffer2[0]); 
        s_ay = ((dataBuffer2[3] << 8) | dataBuffer2[2]);
        s_az = ((dataBuffer2[5] << 8) | dataBuffer2[4]);
        ax = (s_ax*g_sens_accs)/1000;
        ay = (s_ay*g_sens_accs)/1000;
        az = (s_az*g_sens_accs)/1000;
        
        roll = atan2(ay,ax);

        roll  *= 180.0 / PI;
    }

    void convertGyroData()
    {
        s_gx = ((dataBuffer[1] << 8) | dataBuffer[0]); 
        s_gy = ((dataBuffer[3] << 8) | dataBuffer[2]);
        s_gz = ((dataBuffer[5] << 8) | dataBuffer[4]);
        gx = (s_gx * 0.0175);
        gy = (s_gy * 0.0175);
        gz = (s_gz * 0.0175);
    }

    public :
    LSM9DS1(char address)
    {
        addr = address;
    }


    void setRegSensor(char reg,char value)
    {
        char *bus ="/dev/i2c-2";
        //Open I2C bus, checks connection
        if((file = open(bus, O_RDWR)) < 0)
        {
            printf("Failed to open bus. \n");
            exit(1);
        }
        ioctl(file, I2C_SLAVE, addr);

        char config[2] = {0};
        config[0] = reg;
        config[1] = value;
        if(write(file, config, 2) < 0)
        {
            printf("Failed to open bus. \n");
            exit(1);
        }
        else
        printf("sucessful init \n");

    }


    void ReadSensor()
    {
        char regis[1] = {0x18};
        write(file, regis, 1);
    
        if(read(file, dataBuffer, 6) != 6)
        {
            printf("Input/Output error \n");
            exit(1);
        }
        convertGyroData();


        char regis2[1] = {0x28};
        write(file, regis2, 1);

        if(read(file, dataBuffer2, 6) != 6)
        {
            printf("Input/Output error \n");
            exit(1);
        }

        convertAccelData();

    }


    void closeSensor()
    {
        close(file);
    }

    float GetAccelerationX(){ return ax;}
    float GetAccelerationY(){ return ay;}
    float GetAccelerationZ(){ return az;}
    float GetGRotationX(){ return gx;}
    float GetGRotationY(){ return gy;}
    float GetGRotationZ(){ return gz;}
    float GetRotation(){ return roll;}
};

class pi_reg
{
    private:
    float _Kp;
    float _Ki;
    float _integral;
    float pout;
    float iout;
    float error;

    public:
    void pi_reg(float Kp, float Ki)
    {
        _Kp = Kp;
        _Ki = Ki;
    }

    void pi_regulate(float value, float setPoint)
    {
        error = setPoint - value;

        pout = error * _Kp;

        _integral += error / LPS;
        iout = _integral * _Ki;

        return(pout + iout);
    }
};



int main(int argc, char* argv[])
{
    //init
    ros::init(argc, argv, "IMUpublisher");
    //message code
    ros::NodeHandle n;
    ros::Publisher chatter_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
    ros::Rate loop_rate(LPS);
    sensor_msgs::JointState jointState;

    jointState.name.push_back("base_to_leg_01");
    jointState.name.push_back("base_to_leg_02");
    jointState.name.push_back("base_to_leg_03");
    jointState.name.push_back("base_to_leg_04");
    jointState.name.push_back("base_to_leg_05");

    jointState.position.push_back(0.0);
    jointState.position.push_back(0.0);
    jointState.position.push_back(0.0);
    jointState.position.push_back(0.0);
    jointState.position.push_back(0.0);

    //IMU code
    char addresse = 0x6a;
    LSM9DS1 IMU1(addresse);
    addresse = 0x6b;
    LSM9DS1 IMU2(addresse);


    char aksereg = 0x10;
    char setBit  = 0x49;
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x11;
    setBit  = 0x02;
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x12;
    setBit  = 0x49;
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x20;
    setBit  = 0x00;
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);

    float gyro_rotation = 0.0;
    float acceleration_rotation = 0.0;
    float total_rotaion = 0.0;

    std::vector<float> accelerationAngleList;
    accelerationAngleList.resize(LPS);
    std::vector<float> gyroAngleList;
    gyroAngleList.resize(LPS);
    
    float gyroAverege = 0.0;
    float accelerationAverege = 0.0;
    float offset = 0.0;
    float finalAngle = 0.0;

    accelerationAngleList.assign(LPS, 0.0);
    gyroAngleList.assign(LPS, 0.0);


    pi_reg offsetRegulator(0.001, 0.10);

    while (ros::ok())
    {

        IMU1.ReadSensor();
        IMU2.ReadSensor();

        jointState.header.stamp = ros::Time::now();


        acceleration_rotation = IMU1.GetRotation();
        gyro_rotation += (IMU1.GetGRotationZ()/LPS);

        offset = offsetRegulator.pi_regulate(gyro_rotation, acceleration_rotation);

        /*
        accelerationAngleList.insert(accelerationAngleList.begin() ,IMU1.GetRotation());
        accelerationAverege += IMU1.GetRotation();
        accelerationAverege -= accelerationAngleList[LPS];
        accelerationAngleList.resize(LPS);
        gyroAngleList.insert(gyroAngleList.begin() ,gyro_rotation);
        gyroAverege += gyro_rotation;
        gyroAverege -= gyroAngleList[LPS];
        gyroAngleList.resize(LPS);

        offset = (gyroAverege - accelerationAverege)/LPS;
        
        */

        //ROS_INFO("%f ", accelerationAngleList[LPS]);
        finalAngle = gyro_rotation - offset;


        jointState.position[0] = acceleration_rotation;
        jointState.position[1] = gyro_rotation;
        jointState.position[2] = (accelerationAverege/LPS);
        jointState.position[3] = (gyroAverege/LPS);
        jointState.position[4] = finalAngle;

        chatter_pub.publish(jointState);

        ros::spinOnce();
        loop_rate.sleep();

    }

    return 0;
}