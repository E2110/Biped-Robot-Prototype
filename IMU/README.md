# IMU

The inertial measurement unit used in the embedded system of the bipedal robot is the LSM9DS1 iNEMO system-in-package module developed by STMicroelectronics, this module has the ability to sense a total of 9 degrees of freedom (3-axis accelerometer, 3-axis gyroscope, and 3-axis magnetometer) and includes support for both SPI and I2C for communication. 

![IMU_picture](assets_IMU/IMU_LSM9DS1.jpg)

The IMU are implemented on the robot with a breakout board for the LSM9DS1 chip produced by Sparkfun, this simplifies the process of connection to the pinouts of the chip and the interfacing with the IMU connector board which pass the data through ethernet cables to the Beaglebone.
