#include "ros/ros.h"
#include "std_msgs/Float32MultiArray.h"

// Language dependencies
#include <cstdint>
#include <cstdlib>
#include <cstdio>
#include <iostream>

// POSIX dependencies
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h> 
#include <sys/stat.h> 

#define eQEP0 "/sys/devices/platform/ocp/48300000.epwmss/48300180.eqep"
#define eQEP1 "/sys/devices/platform/ocp/48302000.epwmss/48302180.eqep"
#define eQEP2 "/sys/devices/platform/ocp/48304000.epwmss/48304180.eqep"
#define eQEP1PinApath "/sys/devices/platform/ocp/ocp:P8_33_pinmux"
#define eQEP1PinBpath "/sys/devices/platform/ocp/ocp:P8_35_pinmux"
#define eQEP2PinApath "/sys/devices/platform/ocp/ocp:P8_12_pinmux"
#define eQEP2PinBpath "/sys/devices/platform/ocp/ocp:P8_11_pinmux"
#define gearRatio 6
#define pulsesPrRev 3000 


// Constructor for eQEP driver interface object
class Encoder
{
 public :  
    Encoder(int EncoderNumber)
    {  
        switch (EncoderNumber)
        {
            case 0:
            path = eQEP0;
            break;
            case 1:
            path = eQEP1;
            pinApath = eQEP1PinApath;
            pinBpath = eQEP1PinBpath;
            break;
            case 2:
            path = eQEP2;
            pinApath = eQEP2PinApath;
            pinBpath = eQEP2PinBpath;
            break;
            default :
            std::cout << "invalid Encoder number" << std::endl;
            break;
        } 
    }
    void initEncoder (int32_t pos, int32_t period)
    {
        setMode();
        setPeriod(period);
        setPosition(pos);
    }
    
    int32_t getPosition()
    {  
        int32_t       position;
        FILE* fp = fopen((this->path + "/position").c_str(), "r");

        if(fp == NULL)
        {  
                std::cerr << "[eQEP " << this->path << "] Unable to open position for read" << std::endl;
                return 0;
        }

        fscanf(fp, "%d", &position);
        fclose(fp);

        return position;
    }

 private :
    std::string path;
    std::string pinApath;
    std::string pinBpath;

    void setMode()
    {  
        FILE* setmode = fopen((this->path + "/mode").c_str(), "w");
        if(setmode == NULL)
        {
            std::cerr << "[eQEP " << this->path << "] Unable to open mode for write" << std::endl;
            return;
        }
        fprintf(setmode, "%u\n", 0); //absolute mode
        fclose(setmode);

        FILE* setPinA = fopen((this->pinApath + "/state").c_str(), "w");
        if(setPinA == NULL)
        {
            std::cerr << "[eQEP " << this->pinApath << "] Unable to open mode for write" << std::endl;
            return;
        }
        fprintf(setPinA, "qep");
        fclose(setPinA);        
        
        FILE* setPinB = fopen((this->pinBpath + "/state").c_str(), "w");
        if(setPinB == NULL)
        {
            std::cerr << "[eQEP " << this->pinBpath << "] Unable to open mode for write" << std::endl;
            return;
        }
        fprintf(setPinB, "qep");
        fclose(setPinB);
    }

    void setPosition(int32_t position)
    {  
        
        FILE *setpos = fopen((this->path + "/position").c_str(), "w");
        if(setpos == NULL)
        {
            std::cerr << "[eQEP " << this->path << "] Unable to open position for write" << std::endl;
            return;
        }
        fprintf(setpos, "%d\n", position);
        fclose(setpos);
    }  


    void setPeriod(uint64_t period)
    {
        FILE* setp = fopen((this->path + "/period").c_str(), "w");
        if(setp == NULL)
        {
            std::cerr << "[eQEP " << this->path << "] Unable to open period for write" << std::endl;
            return;
        }


        fprintf(setp, "%llu\n", period);
        fclose(setp);
    }
};

int main(int argc, char **argv)
{
    Encoder encoder1(2); //encoder number 1
    Encoder encoder2(1); //encoder number 2
    encoder1.initEncoder(0, 10000000L);
    encoder2.initEncoder(0, 10000000L);

    //ROS code
    ros::init(argc,argv,"encoder_publisher");
    ros::NodeHandle n;
    ros::Publisher chatter_pub = n.advertise<std_msgs::Float32MultiArray>("leg_torso_angles", 1);
    ros::Rate loop_rate(100);



    int count = 0;
    float leg1Angle;
    float leg2Angle;

        
    std_msgs::Float32MultiArray flt;
    flt.data.push_back(0.0);
    flt.data.push_back(0.0);

    while (ros::ok())
    {
        

        leg1Angle = (float)encoder1.getPosition()*360/(pulsesPrRev * 4 * gearRatio);
        leg2Angle = (float)encoder2.getPosition()*360/(pulsesPrRev * 4 * gearRatio);

        flt.data[0] = leg1Angle;
        flt.data[1] = leg2Angle;

        ROS_INFO("%f", leg1Angle);

        chatter_pub.publish(flt);
        ros::spinOnce();
        loop_rate.sleep();
        ++count;
    }
    return 0;
}
