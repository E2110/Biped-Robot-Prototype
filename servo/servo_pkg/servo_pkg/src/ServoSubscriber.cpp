#include "ros/ros.h"
#include "std_msgs/String.h"
#include "messages_pkg/Servo_values.h"
#include <iostream>
#include <fstream>
#include <string>


#define fullyExtendedDutyCycle 2000000
#define fullyRetractedDutyCycle 1000000
#define period 25000000

class servoControl
{


private:

    int m_frequency = 20006000;
    int m_dutyCycle;
    int m_PIN;
    int m_pinbool;
    std::string m_Pinpath;
    std::string m_PinpathNumber;
    std::string m_pinChip;
    
    
    void setPin(int pin)
    {  
        switch (pin) 
        {
            case 13:
                m_Pinpath = "P8_13_pinmux";
                m_PinpathNumber = "7:1";
                m_pinChip = "pwmchip7";
                m_pinbool = 1;
                break;
            case 19:
                m_Pinpath = "P8_19_pinmux";
                m_PinpathNumber = "7:0";
                m_pinChip = "pwmchip7";
                m_pinbool = 0;
                break;
            case 29:
                m_Pinpath = "P9_29_pinmux";
                m_PinpathNumber = "1:1";
                m_pinChip = "pwmchip1";
                m_pinbool = 1;
                break;
            case 31:
                m_Pinpath = "P9_31_pinmux";
                m_PinpathNumber = "1:0";
                m_pinChip = "pwmchip1";
                m_pinbool = 0;
                break;
            default:
                std::cout << "Not an implemented pin"<<std::endl;
                break;
        }
    }

    void setPWMstate()
    {
        std::ofstream pwmstate;
        pwmstate.open("/sys/devices/platform/ocp/ocp:" + m_Pinpath + "/state");
        //få inn feiltest
        pwmstate << "pwm";
        pwmstate.close();
    }

    void enablePWM()
    {
        std::ofstream pwmEnable;
        pwmEnable.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/enable");
        pwmEnable << 1;
        pwmEnable.close();
    }
    void setPWMfreq(int frequency)
    {
        std::ofstream PWMexportStream;
        PWMexportStream.open("/sys/class/pwm/" + m_pinChip + "/export");
        PWMexportStream << m_pinbool;
        PWMexportStream.close();

        std::ofstream freqSet;
        freqSet.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/period");
        freqSet << frequency;
        freqSet.close();
    }

public:
     servoControl(int pinNumber)
    {
        m_dutyCycle = 1000000;
        setPin (pinNumber);
        std::cout<< "Running with pin " << pinNumber << std::endl;
    }
    void setDutyCycle(int dutyC)
    {
        std::ofstream DCfile;
        DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
        DCfile << dutyC;
        DCfile.close();
    }

    void servoInit()
    {   
        setPWMstate();
        setPWMfreq(m_frequency);
        setDutyCycle(m_dutyCycle);
        enablePWM();
        
    }
};
    //servocode
    servoControl servoA(13); //initalize with pin 19
    servoControl servoB(19); //initalize with pin 19
    
    

void changeServoValues(const messages_pkg::Servo_values msg)
{
    //ros code

    if (msg.Servo1_state == 0)
    {
        servoA.setDutyCycle(fullyExtendedDutyCycle);
        ROS_INFO("servo 1 in");
    }
    else if(msg.Servo1_state == 1 )
    {
        servoA.setDutyCycle(fullyRetractedDutyCycle);
        ROS_INFO("servo 1 out");
    }

    if (msg.Servo2_state == 0)
    {
        servoB.setDutyCycle(fullyExtendedDutyCycle);
        ROS_INFO("servo 2 in");
    }
    else if(msg.Servo2_state == 1 )
    {
        servoB.setDutyCycle(fullyRetractedDutyCycle);
        ROS_INFO("servo 2 out");
    }
}


int main(int argc, char **argv)
{
    //servo code
    servoA.servoInit();
    servoB.servoInit();
    //ros code
    ros::init(argc, argv, "Servo_subscriber");
    ros::NodeHandle n;
    ros::Subscriber values_sub = n.subscribe("Servo_values",1, changeServoValues);
    ros::spin();
    return 0;
}
