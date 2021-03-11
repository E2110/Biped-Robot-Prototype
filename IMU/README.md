# IMU

The inertial measurement unit used in the embedded system of the bipedal robot is the LSM9DS1 iNEMO system-in-package module developed by STMicroelectronics, this module has the ability to sense a total of 9 degrees of freedom (3-axis accelerometer, 3-axis gyroscope, and 3-axis magnetometer) and includes support for both SPI and I2C for communication. 

![IMU_picture](assets_IMU/IMU_LSM9DS1.jpg)

The IMU are implemented on the robot with a breakout board for the LSM9DS1 chip produced by Sparkfun, this simplifies the process of connection to the pinouts of the chip and the interfacing with the IMU connector board which pass the data through ethernet cables to the Beaglebone.

For the robot to walk reliably it need to know the position of itself relative to the world. two interial measuring units are used to get the angle of each leg realative to the world.
The IMU's used in this project are the LSM9DS1 theeses come equipped with bot a accelerometer wich meassures the acceleration of the chip ,as well as a gyrometer wich measures the change in angle over time.
The accelerometer can meassure the pull of gravity and can there for calculate the angle it is at relative to gravity. however, due to mechanical vibrations and the IMU's moving, it is higly susseptible to noise. we could use a filter to smooth out the signal but this would induce too much delay and would no be sutable for our application