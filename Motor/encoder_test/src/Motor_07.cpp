#include "ros/ros.h"
#include "std_msgs/Float32MultiArray.h"
#include "encoder_test/encoder_angles.h"
#include "encoder_test/motor_values.h"

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <future>

#define eQEP0 "/sys/devices/platform/ocp/48300000.epwmss/48300180.eqep"
#define eQEP1 "/sys/devices/platform/ocp/48302000.epwmss/48302180.eqep"
#define eQEP2 "/sys/devices/platform/ocp/48304000.epwmss/48304180.eqep"
#define eQEP1PinApath "/sys/devices/platform/ocp/ocp:P8_33_pinmux"
#define eQEP1PinBpath "/sys/devices/platform/ocp/ocp:P8_35_pinmux"
#define eQEP2PinApath "/sys/devices/platform/ocp/ocp:P8_12_pinmux"
#define eQEP2PinBpath "/sys/devices/platform/ocp/ocp:P8_11_pinmux"
#define gearRatio 6
#define pulsesPrRev 3000

float motor1_value;
float motor2_value;

void changeMotorValues(const encoder_test::motor_values msg)
{
    motor1_value = msg.motor1_value;
    motor2_value = msg.motor2_value;
    ROS_INFO("%f", motor1_value);
}

class motor1
{
public:
    motor1(int pinNumber1)
    {
        setpwmPin(pinNumber1);
        std::cout << "Running with pin " << pinNumber1 << std::end1;
    }
    void setDutyCycle1(int dutyC1)
    {
        std::ofstream DCfile;
        DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
        DCfile << dutyC1;
        DCfile.close();
    }
    void setPWMfreq1(int frequency)
    {
        std::ofstream freqSet;
        freqSet.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/period");
        freqSet << frequency;
        freqSet.close();
    }

    void GPIOtoggle1(int cape_nr, int pin_nr, int state)
    {
        setGPIOpin(cape_nr, pin_nr);
        setGPIOstate();
        setGPIOdirection("out");

        std::ofstream pinstream;
        pinstream.open("/sys/class/gpio/gpio" + m_GPIONumber + "/value");
        pinstream << state;
        pinstream.close();
    }
    void toggleMotorPin1(int state)
    {
        std::ofstream pinstream;
        std::ofstream pinstream2;

        pinstream.open("/sys/class/gpio/gpio117/value");
        pinstream << state;
        pinstream.close();
        pinstream2.open("/sys/class/gpio/gpio49/value")
        pinstream2 << state;
        pinstream2.close();
    }
    void motorInit1()
    {
        setPWMstate1();
        setPWMfreq1(m_frequency1);
        setDutyCycle1(m_dutyCycle1);
    }

private:
    int m_frequency1;
    int m_dutyCycle1;
    int m_PIN;
    int m_pinbool;
    std::string m_Pinpath;
    std::string m_PinpathNumber;
    std::string m_pinChip;
    std::string m_GPIONumber;
    std::string m_IOpinpath;

    void setGPIOpin1(int cape_nr, int IO_pin) //change to return 1 if good, 0 bad.
    {
        switch (cape_nr)
        {
        case 9:
            switch (IO_pin) //not GPIO but pins from beaglebone cape
            {

            case 25:
                m_IOpinpath = "P9_25_pinmux";
                m_GPIONumber = "117";
                break;

            case 23:
                m_IOpinpath = "P9_23_pinmux";
                m_GPIONumber = "49";
                break;

            default:
                std::cout << IO_pin << " is not an implemented pin" << std::endl;
                break;
            }
            break;

        default:
            std::cout << "pin : " << cape_nr << " is an invalid cape_nr !" << std::endl;
            break;
        }
    }

    void setGPIOstate1()
    {
        std::ofstream IOstateStream;
        IOstateStream.open("sys/devices/platform/ocp/ocp:" + m_IOpinpath + "/state");
        IOstateStream << "default";
        IOstateStream.close();
    }

    void setGPIOdirection1(std::string direction)
    {
        std::ofstream IOdirStream;
        IOdirStream.open("/sys/class/gpio/gpio" + m_GPIONumber + "/direction");
        if (IOdirStream.fail())
        {
            exportIOpin();
            setGPIOdirection1(direction);
            return;
        }
        IOdirStream << direction;
        IOdirStream.close();
    }

    void setpwmPin1(int pin)
    {
        switch (pin)
        {
        case 16:
            m_Pinpath = "P9_16_pinmux";
            m_PinpathNumber = "4:1";
            m_pinChip = "pwmchip4";
            m_pinbool = 1;
            break;
        default:
            std::cout << "Not an implemented pin" << std::endl;
            break;
        }
    }

    void setPWMstate1()
    {
        std::ofstream pwmstate;
        pwmstate.open("/sys/devices/platform/ocp/ocp:" + m_Pinpath + "/state");
        //få inn feiltest
        pwmstate << "pwm";
        pwmstate.close();
    }
};

class motor2
{
public:
    motor2(int pinNumber2)
    {
        setpwmPin(pinNumber2);
        std::cout << "Running with pin " << pinNumber2 << std::end1;
    }
    void setDutyCycle2(int dutyC)
    {
        std::ofstream DCfile;
        DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
        DCfile << dutyC;
        DCfile.close();
    }
    void setPWMfreq2(int frequency)
    {
        std::ofstream freqSet;
        freqSet.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/period");
        freqSet << frequency;
        freqSet.close();
    }

    void GPIOtoggle2(int cape_nr, int pin_nr, int state)
    {
        setGPIOpin(cape_nr, pin_nr);
        setGPIOstate();
        setGPIOdirection("out");

        std::ofstream pinstream;
        pinstream.open("/sys/class/gpio/gpio" + m_GPIONumber + "/value");
        pinstream << state;
        pinstream.close();
    }
    void toggleMotorPin2(int state)
    {
        std::ofstream pinstream;
        std::ofstream pinstream2;

        pinstream.open("/sys/class/gpio/gpio117/value");
        pinstream << state;
        pinstream.close();
        pinstream2.open("/sys/class/gpio/gpio49/value")
        pinstream2 << state;
        pinstream2.close();
    }
    void motorInit2()
    {
        setPWMstate2();
        setPWMfreq2(m_frequency2);
        setDutyCycle2(m_dutyCycle2);
    }

private:
    int m_frequency2;
    int m_dutyCycle2;
    int m_PIN;
    int m_pinbool;
    std::string m_Pinpath;
    std::string m_PinpathNumber;
    std::string m_pinChip;
    std::string m_GPIONumber;
    std::string m_IOpinpath;

    void setGPIOpin2(int cape_nr, int IO_pin) //change to return 1 if good, 0 bad.
    {
        switch (cape_nr)
            {
                case 9:
                    switch (IO_pin)  //not GPIO but pins from beaglebone cape
                    {
                        case 27:
                        m_IOpinpath = "P9_27_pinmux";
                        m_GPIONumber = "115";
                        break;

                        default:
                        std::cout<<IO_pin << " is not an implemented pin"<< std::endl;
                        break;
                    }
                break;

                case 8
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

    void setGPIOstate2()
    {
        std::ofstream IOstateStream;
        IOstateStream.open("sys/devices/platform/ocp/ocp:" + m_IOpinpath + "/state");
        IOstateStream << "default";
        IOstateStream.close();
    }

    void exportIOpin2()
    {
        std::ofstream IOexportstream;
        IOexportstream.open("/sys/class/gpio/export");
        IOexportstream << m_GPIONumber;
        IOexportstream.close();
    }

    void setGPIOdirection2(std::string direction)
    {
        std::ofstream IOdirStream;
        IOdirStream.open("/sys/class/gpio/gpio" + m_GPIONumber + "/direction");
        if (IOdirStream.fail())
        {
            exportIOpin2();
            setGPIOdirection2(direction);
            return;
        }
        IOdirStream << direction;
        IOdirStream.close();
    }

    void setpwmPin2(int pin)
    {
        switch (pin)
        {
        case 14:
            m_Pinpath = "P9_14_pinmux";
            m_PinpathNumber = "4:0";
            m_pinChip = "pwmchip4";
            m_pinbool = 1;
            break;
        default:
            std::cout << "Not an implemented pin" << std::endl;
            break;
        }
    }
    void setPWMstate2()
    {
        std::ofstream pwmstate;
        pwmstate.open("/sys/devices/platform/ocp/ocp:" + m_Pinpath + "/state");
        pwmstate << "pwm";
        pwmstate.close();
    }
};

motor1 control(16);
motor2 control(14);

task PID()
{

    float kp = 1;
    float ki = 0;
    float kd = 0.1;
    float desired1 = 0;
    float desired2 = 0;

    float Pvalue1;
    float Pvalue2;
    float Dvalue1;
    float Dvalue2;
    float previous1;
    float previous2;
    float valuetomotor1;
    float valuetomotor2;
    int DutyC1;
    int DutyC2;

    while (true)
    {
        float motor1_error = desired1 - motor1_value;
        float motor2_error = desired2 - motor2_value;
        if (motor1_error > desired1)
        {
            control.GPIOtoggle1(9, 25, 1);
            control.GPIOtoggle1(9, 23, 1);
        }
        else if (motor1_error < desired1)
        {
            control.GPIOtoggle1(9, 25, 0);
            control.GPIOtoggle1(9, 23, 0);
        }
        else
        {
            control.GPIOtoggle1(9, 25, 1);
            control.GPIOtoggle1(9, 23, 0);
        }
        if (motor2_error > desired2)
        {
            control.GPIOtoggle2(9, 27, 1);
            control.GPIOtoggle2(8, 34, 1);
        }
        else if (motor2_error < desired2)
        {
            control.GPIOtoggle2(9, 27, 0);
            control.GPIOtoggle2(8, 34, 0);
        }
        else
        {
            control.GPIOtoggle2(9, 27, 1);
            control.GPIOtoggle2(8, 34, 0);
        }

        Pvalue1 = motor1_error * kp;
        Pvalue2 = motor2_error * kp;
        Dvalue1 = (motor1_error - previous1) * kd;
        Dvalue2 = (motor2_error - previous2) * kd;
        previous1 = motor1_error;
        previous2 = motor2_error;

        valuetomotor1 = Pvalue1 + Dvalue1;
        valuetomotor1 = Pvalue2 + Dvalue2;

        float DutyC1_1 = (valuetomotor1 * 9000000) / 100;
        float DutyC2_1 = (valuetomotor1 * 9000000) / 100;

        DutyC1 = round(DutyC1_1);
        DutyC2 = round(DutyC2_1);

        control.setDutyCycle1(DutyC1);
        control.setDutyCycle2(DutyC2);

        break;
    }
}

class Encoder
{
public:
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
        default:
            std::cout << "invalid Encoder number" << std::endl;
            break;
        }
    }
    void initEncoder(int32_t pos, int32_t period)
    {
        setMode();
        setPeriod(period);
        setPosition(pos);
    }

    int32_t getPosition()
    {
        int32_t position;
        FILE *fp = fopen((this->path + "/position").c_str(), "r");

        if (fp == NULL)
        {
            std::cerr << "[eQEP " << this->path << "] Unable to open position for read" << std::endl;
            return 0;
        }

        fscanf(fp, "%d", &position);
        fclose(fp);

        return position;
    }

private:
    std::string path;
    std::string pinApath;
    std::string pinBpath;

    void setMode()
    {
        FILE *setmode = fopen((this->path + "/mode").c_str(), "w");
        if (setmode == NULL)
        {
            std::cerr << "[eQEP " << this->path << "] Unable to open mode for write" << std::endl;
            return;
        }
        fprintf(setmode, "%u\n", 0); //absolute mode
        fclose(setmode);

        FILE *setPinA = fopen((this->pinApath + "/state").c_str(), "w");
        if (setPinA == NULL)
        {
            std::cerr << "[eQEP " << this->pinApath << "] Unable to open mode for write" << std::endl;
            return;
        }
        fprintf(setPinA, "qep");
        fclose(setPinA);

        FILE *setPinB = fopen((this->pinBpath + "/state").c_str(), "w");
        if (setPinB == NULL)
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
        if (setpos == NULL)
        {
            std::cerr << "[eQEP " << this->path << "] Unable to open position for write" << std::endl;
            return;
        }
        fprintf(setpos, "%d\n", position);
        fclose(setpos);
    }

    void setPeriod(uint64_t period)
    {
        FILE *setp = fopen((this->path + "/period").c_str(), "w");
        if (setp == NULL)
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
    //encoder init
    Encoder encoder1(2); //encoder number 1
    Encoder encoder2(1); //encoder number 2
    encoder1.initEncoder(0, 10000000L);
    encoder2.initEncoder(0, 10000000L);

    control.motorInit1();
    control.motorInit2();
    control.setDutyCycle1(8000000); // 80%
    control.setDutyCycle2(8000000);
    control.setPWMfreq1(10000000); //100Hz
    control.setPWMfreq2(10000000);
    control.GPIOtoggle2(9, 27, 1); // MOTOR OFF
    control.GPIOtoggle1(9, 23, 0); // MOTOR OFF
    control.GPIOtoggle1(9, 25, 1); // MOTOR OFF
    control.GPIOtoggle2(8, 34, 0); // MOTOR OFF

    int count = 0;
    float leg1Angle;
    float leg2Angle;

    encoder_test::encoder_angles flt;

    //ros code
    ros::init(argc, argv, "motor_subscriber");
    ros::NodeHandle n;
    ros::Publisher chatter_pub = n.advertise<encoder_test::encoder_angles>("leg_torso_angles", 1);
    ros::subscriber values_sub = n.subscribe("Motor_values", 1, changeMotorValues)
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
