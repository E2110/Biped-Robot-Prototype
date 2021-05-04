
# Motor

The motors are located at the joint between torso and legs. By manipulating the ratio between period and duty-cycle we can decied the current delivered to the motors and by changing the value of the GPIO-pins we can change the directions of the motors. In the robots embeded system this part consists of three parts:

Maxon Motor 14887            |   ESCON 70/10 Servocontroller    |   Gearhead GP42C
:------------------------------------:|:-------------------------------------:|:-------------------------:
<img src="assets_motor/176682329_3791733154215068_5268941636711901361_n.jpg" width="300" height="300"/>  | <img src="assets_motor/ESCON_7010_Servocontroller.jpg" width="300" height="300"/>  | <img src="assets_motor/GP-42-C-42-Detail.jpg" width="300" height="300"/>

NB. The part number written on the motor (402890) is the part number for the particular motor/gearhead combination. We also have a spare with the number 241318. This consists of the same motor, but different gearhead. The spare gearhead has a ratio of 1:26.

The implemented gearheads have ratios of 1:6. 

Before the code for the motor is run its important to configure the servo controller with the ESCON studio software. Work done by a prior bachelor thesis group determined that the maximum required amperage for the motor should be 8.3A, this should be configured with the ESCON software including preforming a autotuning.

## Configure the servo-controller
To configure the ESCON 70/10 Servocontroller you need:
* Escon studio (Software)
* Micro USB
* Power Supply (If you want to Auto tune it)
The config is quite simple. Just start the software and (if connected) a pop up for configuration of ESCON 70/10 will pop up. The pictures under shows what we did step for step.

<img src="assets_motor/Escon_studio_01.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_02.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_03.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_04.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_05.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_06.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_07.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_08.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_09.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_10.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_11.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_12.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_13.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_14.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_15.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_16.PNG" width="100" height="100"/>

## Connection and pins
Each motor is controlled by two by two GPIO-pins and one PWM-pin.

Pin     |   Inner Leg     | Outer Leg |  Servo Controller
:------------------------------------:|:-------------------------------------:|:-------------------------:|:--------:
GPIO 1  |   P9_23           |  P9_27 |J5_1
GPIO 2  |   P9_25           |  P8_34 |J5_2
PWM     |   P9_16           |  P9_14 |J5_3

## Code
<i>This section will only explain the motor part, even though the code contains an encoder part. The explanation should give you enough information to understand the code, add new PWM- and GPIO-pins and change the values written on the Beaglebone, hopefully without having experience with C++. Order: Code -> where it's called -> explanation.

The code is written in C++. The purpose of the code is to change the direction and the torque of both motors. To control the direction you change the "value" of the GPIO-pins and to manipulate the torque you change the "duty_cycle" of the pwm-pins. Let's start with class motor.

* <b>class motor</b> contains functions with pathways to different folders on the Beaglebone. These pathways might be wrong if you do not have the same device tree overlay as us. 

```
    motor(int pinNumber)
    {
        m_dutyCycle = 1000000;
        setpwmPin (pinNumber);
        std::cout<< "Running with pin " << pinNumber << std::ends;
    }
```
pinNumber input:
```
motor control(14);
motor control2(16);
```
It starts by calling the setpwmPin function and printing what pinNumber it runs with. This equals the motor input and will decide which pwm-pin that will run.

```
void setDutyCycle(int dutyC)
    {
        std::ofstream DCfile;
        DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
        DCfile << dutyC;
        DCfile.close();
    }
```
initiated:
```
control.setDutyCycle(5000000);
control2.setDutyCycle(5000000);
```
When initiated it opens the duty_cycle folder, writes the input and closes it. m_PinpathNumber is given in the setpwmPin-function.

```
void setPWMfreq(int frequency)
        {
            disablePWM();
            std::ofstream freqSet;
            freqSet.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/period");
            freqSet << frequency;
            freqSet.close();
            enablePWM();
        }
```
Same concept as last function. Difference is that it calls a function to disable and enable the PWM-pin. The reason for this is that you can't change the period when the PWM-pin is enabled.

```
void GPIOtoggle(int cape_nr,int pin_nr,int state)
    {   
        setGPIOpin(cape_nr,pin_nr);
        setGPIOstate();
        setGPIOdirection("out");

        std::ofstream pinstream;
        pinstream.open("/sys/class/gpio/gpio"+ m_GPIONumber + "/value");
        pinstream << state;
        pinstream.close();
    }
```
It first calles tree functions to select the correct pin and put the direction "out" (default it's in". This function is used to put the GPIO value to either 1 or 0. Under section <i>"Connection and pins"</i> it is explained what the different combinations will do to the motor. 


```
    void motorInit()
    {   
        setPWMstate();
        exportPWM();
        setPWMfreq(m_frequency);
        setDutyCycle(m_dutyCycle);
        enablePWM();  
    }
```

motorInit is, as the name indicates, an initialiser. It calls function to make sure the PWM-pins are correct set up.





* main() will run when initiating the program.

```
```



```
void setDutyCycle(int dutyC)
{
  std::ofsteam DCfile;
  DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
  DCfile << dutyC;
  DCfile.close();
}
```
