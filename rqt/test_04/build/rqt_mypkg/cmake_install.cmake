# Install script for directory: /home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/src/rqt_mypkg

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rqt_mypkg/msg" TYPE FILE FILES
    "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/src/rqt_mypkg/msg/IMU_settings.msg"
    "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/src/rqt_mypkg/msg/Motor_settings.msg"
    "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/src/rqt_mypkg/msg/Angles.msg"
    "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/src/rqt_mypkg/msg/motor_values.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rqt_mypkg/cmake" TYPE FILE FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/build/rqt_mypkg/catkin_generated/installspace/rqt_mypkg-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/devel/include/rqt_mypkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/devel/share/roseus/ros/rqt_mypkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/devel/share/common-lisp/ros/rqt_mypkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/devel/share/gennodejs/ros/rqt_mypkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/devel/lib/python2.7/dist-packages/rqt_mypkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/devel/lib/python2.7/dist-packages/rqt_mypkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/build/rqt_mypkg/catkin_generated/installspace/rqt_mypkg.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rqt_mypkg/cmake" TYPE FILE FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/build/rqt_mypkg/catkin_generated/installspace/rqt_mypkg-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rqt_mypkg/cmake" TYPE FILE FILES
    "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/build/rqt_mypkg/catkin_generated/installspace/rqt_mypkgConfig.cmake"
    "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/build/rqt_mypkg/catkin_generated/installspace/rqt_mypkgConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rqt_mypkg" TYPE FILE FILES "/home/bachelor/GIT/Biped-Robot-Prototype/rqt/test_04/src/rqt_mypkg/package.xml")
endif()

