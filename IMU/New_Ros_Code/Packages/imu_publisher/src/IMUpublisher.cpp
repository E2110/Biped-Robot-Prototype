#include "ros/ros.h"
#include "std_msgs/Float32MultiArray.h"
#include "std_msgs/String.h"
#include "messages_pkg/IMU_settings.h"
#include "messages_pkg/imu_angles.h"

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

    float gyroDrift;

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

    void setGyroDrift(float drift)
    {
        gyroDrift = drift;
    }

    float GetGyroDrift(){return gyroDrift;}
    float GetAccelerationX(){ return ax;}
    float GetAccelerationY(){ return ay;}
    float GetAccelerationZ(){ return az;}
    float GetGRotationX(){ return gx;}
    float GetGRotationY(){ return gy;}
    float GetGRotationZ(){ return gz;}
    float GetRotation(){ return roll;}
};

float KP = 0.0;
float KI = 0.0001;


class kalmanFilter
{
    private :
    //end in pre = pre update, post = post update
    //last means it was the value in the previus run
    float XEstimateCurrentPre;
    float XEstimateCurrentPost;
    float XEstimateLastPost = 0.0;
    float UMeasuredLast = 0.0;
    float DeltaT = 1.0/(float)LPS;
    float PCurrentPre;
    float PCurrentPost;
    float PLastPost = 0.0;
    float Q = 0.01;
    float R = 10;
    float YCurrent;
    float KCurrent;

    public :

    kalmanFilter(float q, float r)
    {   
        Q = q;
        R = r;
    }

    void set_QR(float q, float r)
    {   
        Q = q;
        R = r;
    }

    float Filter(float gyro_value, float acceleration_value)
    {
        //prediction
        XEstimateCurrentPre = XEstimateLastPost + UMeasuredLast * DeltaT;
        PCurrentPre = PLastPost + Q;
        //Update
        YCurrent = acceleration_value - XEstimateCurrentPre;
        KCurrent = PCurrentPre/(R + PCurrentPre);
        XEstimateCurrentPost = XEstimateCurrentPre + KCurrent * YCurrent;
        PCurrentPost = (1 - KCurrent) * PCurrentPre;
        //transfer the value to the next cycle
        XEstimateLastPost = XEstimateCurrentPost;
        PLastPost = PCurrentPost;
        UMeasuredLast = gyro_value;

        return(XEstimateCurrentPost);
    }
};


class pi_reg
{
    private :

    float _Kp;
    float _Ki;
    double _integral;
    float pout;
    float iout;
    float error;

    public :

    pi_reg(float Kp, float Ki)
    {
        _Kp = Kp;
        _Ki = Ki;
    }

    void change_PI(float Kp, float Ki)
    {
        _Kp = Kp;
        _Ki = Ki;
    }

    float pi_regulate(float value, float setPoint)
    {
        error = value - setPoint;

        pout = error * _Kp;

        _integral += error * _Ki / LPS;
        iout = _integral;

        return (pout + iout);
    }

    void resetI()
    {
        _integral = 0.0;
    }


    float getError(){ return error;}
};

kalmanFilter KFilter1(0.01, 10);
kalmanFilter KFilter2(0.01, 10);


pi_reg offsetRegulator1(KP, KI);
pi_reg offsetRegulator2(KP, KI);
int Ireset = 0;
float offset1 = 0.0;
float offset2 = 0.0;
float finalAngle1 = 0.0;
float finalAngle2 = 0.0;

void chatterCallback(const messages_pkg::IMU_settings msg)
{
    offsetRegulator1.change_PI(msg.KP, msg.KI);
    offsetRegulator2.change_PI(msg.KP, msg.KI);
    KFilter1.set_QR(msg.KP,msg.KI);
    KFilter1.set_QR(msg.KP,msg.KI);
    if (msg.Ireset != Ireset)
    {
        offsetRegulator1.resetI();
        offsetRegulator2.resetI();
        Ireset = msg.Ireset;
        finalAngle1 = 0;
        finalAngle2 = 0;
    }
}



int main(int argc, char* argv[])
{
    //init
    ros::init(argc, argv, "IMUpublisher");
    //message code
    ros::NodeHandle n;
    ros::Publisher chatter_pub = n.advertise<messages_pkg::imu_angles>("leg_ground_angles", 1);
    ros::Subscriber sub = n.subscribe("IMU_settings",1 ,chatterCallback);
    ros::Rate loop_rate(LPS);
    messages_pkg::imu_angles angles;

    

    //IMU code
    char addresse = 0x6a;
    LSM9DS1 IMU1(addresse);
    addresse = 0x6b;
    LSM9DS1 IMU2(addresse);


    char aksereg = 0x10;
    char setBit  = 0x49;// 3 gyroscope data output rate, 2 fullscale selection, 1=0, 2 gyroscope bandwidth selection
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x11;
    setBit  = 0x00;// 4=0, 2 interupt selsction, 2 output selection
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x12;
    setBit  = 0x08; // 1 Low power mode enable, 1 high-pass filter enable, 2=0, 4 gyroscope highpass filter bandwidth selsction
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x20;
    setBit  = 0x00;// 3 accelerometer output datarate, 2 accelerometer full scale selection, 1 bandwidth rate output datarate, 2 aintialiaasing filter bw rate
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x23;
    setBit  = 0x00;//FIFO dissable
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);
    aksereg = 0x2E;
    setBit  = 0x00;// FIFO dissable
    IMU1.setRegSensor(aksereg,setBit);
    IMU2.setRegSensor(aksereg,setBit);

    float gyro_rotation1 = 0.0;
    float acceleration_rotation1 = 0.0;
    float gyro_rotation2 = 0.0;
    float acceleration_rotation2 = 0.0;
    float total_rotaion = 0.0;

    int calibrationLoopCounter = 0;
    
 


    
    while (calibrationLoopCounter < 1000)
    {
        IMU1.ReadSensor();
        IMU2.ReadSensor();
        gyro_rotation1 += (IMU1.GetGRotationZ());
        gyro_rotation2 += (IMU2.GetGRotationZ());
        calibrationLoopCounter += 1;

    }

    IMU1.setGyroDrift(gyro_rotation1/1000);
    IMU2.setGyroDrift(gyro_rotation2/1000);


    gyro_rotation2 = 0.0;
    gyro_rotation1 = 0.0;


    while (ros::ok())
    {

        IMU1.ReadSensor();
        IMU2.ReadSensor();

        //PID Code
        /*
        acceleration_rotation1 = IMU1.GetRotation();
        gyro_rotation1 += (IMU1.GetGRotationZ()/LPS) - IMU1.GetGyroDrift();
        acceleration_rotation2 = IMU2.GetRotation();
        gyro_rotation2 += (IMU2.GetGRotationZ()/LPS) - IMU2.GetGyroDrift();

        offset1 = offsetRegulator1.pi_regulate(finalAngle1, acceleration_rotation1);
        offset2 = offsetRegulator2.pi_regulate(finalAngle2, acceleration_rotation2);

        //ROS_INFO("%f ", accelerationAngleList[LPS]);
        finalAngle1 = gyro_rotation1 - offset1;
        finalAngle2 = gyro_rotation2 - offset2;
        */

        gyro_rotation1 = (IMU1.GetGRotationZ()) - IMU1.GetGyroDrift();
        gyro_rotation2 = (IMU2.GetGRotationZ()) - IMU2.GetGyroDrift();
        acceleration_rotation1 = IMU1.GetRotation();
        acceleration_rotation2 = IMU2.GetRotation();

        finalAngle1 = KFilter1.Filter(gyro_rotation1, acceleration_rotation1);
        finalAngle2 = KFilter2.Filter(gyro_rotation2, acceleration_rotation2);

        
        angles.leg1_angle = finalAngle1;
        angles.leg2_angle = finalAngle2;

        chatter_pub.publish(angles);

        //printf("%f  , %f \n", gyro_rotation1, finalAngle1);

        ros::spinOnce();
        loop_rate.sleep();

    }

    return 0;
}