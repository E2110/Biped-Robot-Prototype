#include "ros/ros.h"
#include "std_msgs/Float32MultiArray.h"
#include "messages_pkg/encoder_angles.h"
#include "messages_pkg/Motor_values.h"

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

#define eQEP0 "/sys/devices/platform/ocp/48300000.epwmss/48300180.eqep"
#define eQEP1 "/sys/devices/platform/ocp/48302000.epwmss/48302180.eqep"
#define eQEP2 "/sys/devices/platform/ocp/48304000.epwmss/48304180.eqep"
#define eQEP1PinApath "/sys/devices/platform/ocp/ocp:P8_33_pinmux"
#define eQEP1PinBpath "/sys/devices/platform/ocp/ocp:P8_35_pinmux"
#define eQEP2PinApath "/sys/devices/platform/ocp/ocp:P8_12_pinmux"
#define eQEP2PinBpath "/sys/devices/platform/ocp/ocp:P8_11_pinmux"
#define gearRatio 6
#define pulsesPrRev 3000 






class motor
{
    public:

    motor(int pinNumber)
    {
        m_dutyCycle = 1000000;
        setpwmPin (pinNumber);
        std::cout<< "Running with pin " << pinNumber << std::ends;
    }
    void setDutyCycle(int dutyC)
    {
        std::ofstream DCfile;
        DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
        DCfile << dutyC;
        DCfile.close();
    }
    void setPWMfreq(int frequency)
        {
            disablePWM();
            std::ofstream freqSet;
            freqSet.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/period");
            freqSet << frequency;
            freqSet.close();
            enablePWM();
        }

    void GPIOtoggle(int cape_nr,int pin_nr,int state)
    {   
        //intit addresses, states, and direction,
        setGPIOpin(cape_nr,pin_nr);
        setGPIOstate();
        //exportIOpin();
        setGPIOdirection("out");

        // Toggeling pin
        std::ofstream pinstream;
        pinstream.open("/sys/class/gpio/gpio"+ m_GPIONumber + "/value");
        pinstream << state;
        pinstream.close();
    }
    /*
    void toggleMotorPin(int state)
    {
          // Toggeling pin
        std::ofstream pinstream;
        std::ofstream pinstream2;

        pinstream.open("/sys/class/gpio/gpio115/value");
        pinstream << state;
        pinstream.close();
        pinstream2.open("/sys/class/gpio/gpio117/value");
        pinstream2 << state;
        pinstream2.close();

    }
    */
    void motorInit()
    {   
        setPWMstate();
        exportPWM();
        setPWMfreq(m_frequency);
        setDutyCycle(m_dutyCycle);
        enablePWM();  
    }
    private:

        int m_frequency = 20000000;
        int m_dutyCycle;
        int m_PIN;
        int m_pinbool;
        std::string m_Pinpath;
        std::string m_PinpathNumber;
        std::string m_pinChip;

        std::string m_GPIONumber;
        std::string m_IOpinpath;

        void setGPIOpin(int cape_nr,int IO_pin) //change to return 1 if good, 0 bad.
        {
            switch (cape_nr)
            {
                case 9:
                    switch (IO_pin)  //not GPIO but pins from beaglebone cape
                    {
                     
                        case 25:
                        m_IOpinpath = "P9_25_pinmux";
                        m_GPIONumber = "117";
                        break;

                        case 27:
                        m_IOpinpath = "P9_27_pinmux";
                        m_GPIONumber = "115";
                        break;

                        case 23:
                        m_IOpinpath = "P9_23_pinmux";
                        m_GPIONumber = "49";
                        break;

                        default:
                        std::cout<<IO_pin << " is not an implemented pin"<< std::endl;
                        break;

                    }
                break;

                case 8:
                    switch (IO_pin)
                    {
                    case 34:
                        m_IOpinpath = "P8_34_pinmux";
                        m_GPIONumber = "81";
                        break;
                    }
                break;

                default:
                std::cout<<"pin : " <<cape_nr << " is an invalid cape_nr !" <<std::endl;
                break;
            }
        }
        void setGPIOstate()
        {
            std::ofstream IOstateStream;
            IOstateStream.open("sys/devices/platform/ocp/ocp:" + m_IOpinpath + "/state");
            IOstateStream << "default";
            IOstateStream.close();
        }
        void exportIOpin()
        {
            std::ofstream IOexportstream;
            IOexportstream.open("/sys/class/gpio/export");
            IOexportstream << m_GPIONumber;
            IOexportstream.close();
        }
        void setGPIOdirection(std::string direction)
        {
            std::ofstream IOdirStream;
            IOdirStream.open("/sys/class/gpio/gpio" + m_GPIONumber + "/direction");
            if (IOdirStream.fail())
            {
                exportIOpin();
                setGPIOdirection(direction);
                return;
            }
            IOdirStream << direction;
            IOdirStream.close();
        }


        void setpwmPin(int pin)
        {  
            switch (pin) 
            {
                case 14:
                    m_Pinpath = "P9_14_pinmux";
                    m_PinpathNumber = "4:0";
                    m_pinChip = "pwmchip4";
                    m_pinbool = 0;
                    break;
                case 16:
                    m_Pinpath = "P9_16_pinmux";
                    m_PinpathNumber = "4:1";
                    m_pinChip = "pwmchip4";
                    m_pinbool = 1;
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
        void disablePWM()
        {
            std::ofstream pwmEnable;
            pwmEnable.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/enable");
            pwmEnable << 0;
            pwmEnable.close();
        }

        void exportPWM ()
        {
            std::ofstream PWMexportStream;
            PWMexportStream.open("/sys/class/pwm/" + m_pinChip + "/export");
            PWMexportStream << m_pinbool;
            PWMexportStream.close();
        }
        

};

motor control(14);
motor control2(16);


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

float motor1_value = 0.0;
float motor2_value = 0.0;

void changeMotorValues(const messages_pkg::Motor_values msg)
{
    motor1_value = msg.motor1_value;
    motor2_value = msg.motor2_value;
    ROS_INFO("%f", motor1_value);
    control.setDutyCycle(1000000 + abs((int)motor1_value *80000));
    control2.setDutyCycle(1000000 + abs((int)motor2_value *80000));
    
    if (msg.OnOff == 1){
        if (motor1_value > 0)
        {
            control.GPIOtoggle(9, 27, 1);
            control.GPIOtoggle(8, 34, 1);
        }
        else
        {
            control.GPIOtoggle(9, 27, 0);
            control.GPIOtoggle(8, 34, 0);
        }    
        if (motor2_value > 0)
        {
            control.GPIOtoggle(9, 25, 1);
            control.GPIOtoggle(9, 23, 1);
        }
        else
        {
            control.GPIOtoggle(9, 25, 0);
            control.GPIOtoggle(9, 23, 0);
        }
    }
    else
    {
        control.GPIOtoggle(9, 27, 1);
        control.GPIOtoggle(8, 34, 0);
        control.GPIOtoggle(9, 25, 1);
        control.GPIOtoggle(9, 23, 0);
    }
}

int main(int argc, char **argv)
{
    //encoder init
    Encoder encoder1(2); //encoder number 1
    Encoder encoder2(1); //encoder number 2
    encoder1.initEncoder(0, 10000000L);
    encoder2.initEncoder(0, 10000000L);
    
    control.motorInit();
    control.setDutyCycle(5000000);  // 50%
    control.setPWMfreq(10000000);   //100Hz
    control.GPIOtoggle(9,23,0); // MOTOR OFF
    control.GPIOtoggle(9,25,1); // MOTOR OFF

    control2.motorInit();
    control2.setPWMfreq(10000000);   //100Hz
    control2.setDutyCycle(5000000);
    control2.GPIOtoggle(9,27,1);
    control2.GPIOtoggle(8,34,0);
    



    int count = 0;
    float leg1Angle;
    float leg2Angle;
        
    messages_pkg::encoder_angles flt;

    //ros code
    ros::init(argc, argv, "motor_subscriber");
    ros::NodeHandle n;
    ros::Publisher chatter_pub = n.advertise<messages_pkg::encoder_angles>("leg_torso_angles", 1);
    ros::Subscriber values_sub = n.subscribe("Motor_values",1, changeMotorValues);
    ros::Rate loop_rate(100);

    while (ros::ok())
    {
        flt.leg1_torso_angle = (float)encoder1.getPosition() * 360 / (pulsesPrRev * 4 * gearRatio);
        flt.leg2_torso_angle = (float)encoder2.getPosition() * 360 / (pulsesPrRev * 4 * gearRatio);


        chatter_pub.publish(flt);
        ros::spinOnce();
        loop_rate.sleep();
        ++count;
    }
    return 0;
}
