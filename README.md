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
