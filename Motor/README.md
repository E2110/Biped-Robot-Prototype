
# Motor

The motor used in the embedded system of the robot are the Maxon 14887 DC motor which has the capability to output 150W, the motor is connected to a gearbox which gears the motor 1-to-6. The motor is controlled with the help of an ESCON 70/10 servocontroller. This servocontroller needs a PWM signal as input, where the duty cycle determines the current output of the motor. The servo controller also has input pins for the determination of the output direction of the motor.

Maxon Motor 14887            |   ESCON 70/10 Servocontroller
:-------------------------:|:-------------------------:
![Maxon_motor](assets_motor/176682329_3791733154215068_5268941636711901361_n.jpg)  |  ![Escon](assets_motor/ESCON_7010_Servocontroller.jpg)

Before the code for the motor is run its important to configure the servo controller with the ESCON studio software. Work done by a prior bachelor thesis group determined that the maximum required amperage for the motor should be 8.3A, this should be configured with the ESCON software including preforming a autotuning.


## Configure the servo-controller
To configure the ESCON 70/10 Servocontroller you need:
* Escon studio (Software)
* Micro USB
* Power Supply (If you want to Auto tune it)
The config is quite simple. Just start the program and (if connected) a pop up for configuration of ESCON 70/10 will pop up. The pictures under shows what we did step for step.

<img src="assets_motor/Escon_studio_01.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_02.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_03.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_04.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_05_ver2.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_06.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_07.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_08.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_09.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_10.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_11.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_12.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_13.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_14.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_15.PNG" width="100" height="100"/>|<img src="assets_motor/Escon_studio_16.PNG" width="100" height="100"/>
## Connection and pins

## Code
The purpose of the code is to control direction of the motors, through two GPIO pins, and to change the torque of the motor, through a PWM pin.

```
void setDutyCycle(int dutyC)
{
  std::ofsteam DCfile;
  DCfile.open("/sys/class/pwm/pwm-" + m_PinpathNumber + "/duty_cycle");
  DCfile << dutyC;
  DCfile.close();
}
```
