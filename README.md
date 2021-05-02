# Biped-Robot-Prototype

![NTNU_logo](assets/NTNU_logo.png)

This is the reposatory for our Bachelor's thesis. It will be updated continously the next months :lying_face:... or at least as often as we manage. The project has a deadline in May, that will also be the deadline to finish the git. Up until then this reposatory may or may not be a complete mess.

Anyways this project is about a thin and simple robot that can't walk. We will teach it to walk. How? Through C++ and ROS. Each part of the robot will have it's own floder where we explain the code associated with that part. 

Shoutout to the two previous groups that worked on this project. Most of the information and explanation in the earlier stages of the repository will be gathered from their theses. 


# Flashing Ubuntu 18.04
From windows OS. For flashing the new image we used following:

* Micro-SD, 16 GB
* 7-zip
* balenaEtcher

1 . Download prebuilt image from https://elinux.org/BeagleBoardUbuntu. As of writing the direct link to the image is https://rcn-ee.com/rootfs/2020-03-12/flasher/bone-eMMC-flasher-ubuntu-18.04.4-console-armhf-2020-03-12-2gb.img.xz and the downloaded file is called.

```
 bone-eMMC-flasher-ubuntu-18.04.4-console-armhf-2020-03-12-2gb.img.xz
```
2. Extract the file using 7-zip. This will remove the .xz at the end of the file.

3. Insert the Micro-SD into the computer. Open balenaEtcher, select flash from file and pick the the newly extracted .img file. Select the Micro-SD as target. FLASH!

4. Remove the Micro-SD from computer and insert it into the Beaglebone.

5. Hold the S3-botton down while powering up the Beaglebone. Hold until the four lights left of the ethernet input lights up at the same time, then let go of the button. The Beaglebone will then boot for quite some time until its done.

# Connect to the BeagleBone through SSH.

```
ssh ubuntu@192.168.7.2
```
passord: temppwd

# Enable the PWM-pins
This depends on your device tree overlay. There are quite a bunch out there, this one follows the one we got from the flashed image above.

1. Change to root user.

```
sudo su
```
2. Go to the ocp folder for the pin you want use. In this example P9_16.

```
cd /sys/devices/platform/ocp/ocp:P9_16_pinmux
```

3. Use cat state to see what pin-mode is currently in use. Use echo to change to PWM.

```
echo pwm > state
```

# Write to the PWM-pins with terminal

After changing the state to PWM you can change the different PWM-values in /sys/class/pwm/-folder. This is done by echoing different values to the parameters you want to change. In the example under we do this to pin P9.14

```
cd /sys/class/pwm/pwm-4:0
```
The three parameters we care about:
* enable: Turn on and of the pin.
* period: Decides the frequency. 
* duty_cycle: Time high during the period. If you put it the same as the period it will be constant high.

```
echo 1000000 > period
echo 200000 > duty_cycle
echo 1 > enable
```

# Write to the GPIO-pins with terminal
Go to the GPIO-folder
```
cd /sys/class/gpio
```
With the current Device Three Overlay the ls commando will show us a lot of gpio-pins to begin with. Even though only the current exported gpios should show up, we noticed that a lot of the pins were not exported. So if you can't change the paramters of a certain pin, we recommend trying to unexport and export that pin. This is done by echoing the number of the gpio to the unexport and export.

```
echo 114 > unexport
echo 114 > unexport
```
Now cd into the gpio you want to change.

```
cd gpio115
```
The two paramteres you should care about:
* direction: either in or out
* value: 1 or 0

# Install ROS-melodic

http://wiki.ros.org/melodic/Installation/Ubuntu

# Transfering files to the BeagleBone
## Linux
To do this we use scp command in the terminal

```
scp localfile.cpp ubuntu@192.168.7.2:/folder
```
Eclipse is also a common tool you can use for this and cross compiling.

## Windows
To transfer from windows we use WinSCP. Its pretty straight forward to use,kinda like the windows version of eclipse. 

1. Go to https://winscp.net/eng/download.php and install Winscp.

2. Connect the Beaglebone to your computer and open Winscp. This should pop up.

<img src="assets/Winscp_01_zoom.PNG" width="400" height="300"/>

3.Write ubuntu@192.168.7.2 into Host name. Port Number should stay at 22.

<img src="assets/Winscp_02.PNG" width="250" height="250"/>|<img src="assets/winscp_03.PNG" width="250" height="250"/>

4. When connected you can easily drag end drop between the Beaglebone and the pc. You can also edit the different files on beaglebone.

<img src="assets/Winscp_04.PNG" width="300" height="200"/>

# Make a Catkin-workspace, compile and run a C++-file with ROS
<i> This should be failry simple if you have gone through the ROS-tutorials. We'll keep it as short as possible.</i> 

1. Open one terminal (Ctrl + Alt + T) and run roscore

```
roscore
```
2. Open another (Ctrl + Shift + T) and source setup.bash

```
source /opt/ros/melodic/setup.bash
```
3. Make a folder and another named "src" within this one.


```
mkdir folder_01
cd folder_01
mkdir src
```
4. Make Cmakelists.txt vha. catkin_init_workspace

```
cd src
catkin_init_workspace
```
5. Exit src and run catkin_make

```
cd ..
catkin_make
```
6. source setup.bash

```
source devel/setup.bash
```

7. Make package

```
cd src
catkin_create_pkg folder_02 roscpp std_msgs
```
8. Import C++-file to new src folder.
9. To be able to run a C++-file you have to edit CMakelists.txt in folder_02

```
nano CMakeLists.txt
```
Under "Build"-section you can uncomment the "add_executable", "add_dependencies" and "target_link_libraries". Optionally just add:

```
add_executable(number_3 src/C++-file.cpp)
add_dependencies(number_3 ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(number_3 ${catkin_LIBRARIES})
```
10. Go to folder_01 and run catkin_make. This should compile the package.
```
cd ../..
catkin_make
```
11.Run the package
```
rosrun number_3 folder_02
```
