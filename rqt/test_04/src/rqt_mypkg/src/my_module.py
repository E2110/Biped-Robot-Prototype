import os
import rospy
import rospkg

from sensor_msgs.msg import JointState
from std_msgs.msg import Header
from rqt_mypkg.msg import IMU_settings
from rqt_mypkg.msg import Motor_settings
from rqt_mypkg.msg import Angles

from ctypes import *

from qt_gui.plugin import Plugin
from python_qt_binding import loadUi
from python_qt_binding.QtWidgets import (QWidget, QSlider, QLabel, QApplication, QDoubleSpinBox, QGroupBox, QPushButton, QVBoxLayout, QHBoxLayout)
from python_qt_binding.QtCore import Qt

class MyPlugin(Plugin):

    def __init__(self, context):
        super(MyPlugin, self).__init__(context)
        # Give QObjects reasonable names
        self.setObjectName('MyPlugin')

        # Process standalone plugin command-line arguments
        from argparse import ArgumentParser
        parser = ArgumentParser()
        # Add argument(s) to the parser.
        parser.add_argument("-q", "--quiet", action="store_true",
                      dest="quiet",
                      help="Put plugin in silent mode")
        args, unknowns = parser.parse_known_args(context.argv())
        if not args.quiet:
            print 'arguments: ', args
            print 'unknowns: ', unknowns

        # Create QWidget
        self._widget = QWidget()
        # Get path to UI file which should be in the "resource" folder of this package
        #ui_file = os.path.join(rospkg.RosPack().get_path('rqt_mypkg'), 'resource', 'MyPlugin.ui')
        # Extend the widget with all attributes and children from UI file
        #loadUi(ui_file, self._widget)
        # Give QObjects reasonable names
        self._widget.setObjectName('MyPluginUi')
        # Show _widget.windowTitle on left-top of each plugin (when 
        # it's set in _widget). This is useful when you open multiple 
        # plugins at once. Also if you open multiple instances of your 
        # plugin at once, these lines add number to make it easy to 
        # tell from pane to pane.
        if context.serial_number() > 1:
            self._widget.setWindowTitle(self._widget.windowTitle() + (' (%d)' % context.serial_number()))
        # Add widget to the user interface
        context.add_widget(self._widget)

        windowBox = QGroupBox("settings", self._widget)
        windowLayout = QHBoxLayout()


        #IMU sensor fusion controller with PI values controll

        IMU_PI_values_spinners = QGroupBox("IMU PI-Values", windowBox)
        IMU_PI_Layout = QVBoxLayout()

        #KP value spinner
        IMU_KP_Lable = QLabel("KP", IMU_PI_values_spinners)
        IMU_KP_Spinner = QDoubleSpinBox(IMU_PI_values_spinners)
        IMU_KP_Spinner.setSingleStep(0.01)
        IMU_KP_Spinner.setDecimals(6)
        IMU_KP_Spinner.valueChanged.connect(self.changeIMUKP)
        IMU_KP_Spinner.setRange(-1000,1000)

        #KI value spinner
        IMU_KI_Lable = QLabel("KI", IMU_PI_values_spinners)
        IMU_KI_Spinner = QDoubleSpinBox(IMU_PI_values_spinners)
        IMU_KI_Spinner.setSingleStep(0.01)
        IMU_KI_Spinner.setDecimals(6)
        IMU_KI_Spinner.valueChanged.connect(self.changeIMUKI)
        IMU_KI_Spinner.setRange(-1000,1000)

        
        #push button
        IMU_Button = QPushButton("Push", IMU_PI_values_spinners)
        IMU_Button.clicked.connect(self.IMU_Change_PI_values)
        
        #layout
        IMU_PI_Layout.addWidget(IMU_KP_Lable)
        IMU_PI_Layout.addWidget(IMU_KP_Spinner)
        IMU_PI_Layout.addWidget(IMU_KI_Lable)
        IMU_PI_Layout.addWidget(IMU_KI_Spinner)
        IMU_PI_Layout.addWidget(IMU_Button)
        IMU_PI_values_spinners.setLayout(IMU_PI_Layout)


        #motor PID Controller Value Changer, tm

        Motor_PID_controller = QGroupBox("motor PID-Values", windowBox)
        Motor_PID_Layout = QVBoxLayout()        

        #KP motor PID values Spinner
        Motor_KP_Lable = QLabel("KP", Motor_PID_controller)
        Motor_KP_Spinner = QDoubleSpinBox(Motor_PID_controller)
        Motor_KP_Spinner.setSingleStep(0.01)
        Motor_KP_Spinner.setDecimals(6)
        Motor_KP_Spinner.valueChanged.connect(self.changeMotorKP)
        Motor_KP_Spinner.setRange(-1000,1000)

        #KI motor PID values Spinner
        Motor_KI_Lable = QLabel("KI", Motor_PID_controller)
        Motor_KI_Spinner = QDoubleSpinBox(Motor_PID_controller)
        Motor_KI_Spinner.setSingleStep(0.01)
        Motor_KI_Spinner.setDecimals(6)
        Motor_KI_Spinner.valueChanged.connect(self.changeMotorKI)
        Motor_KI_Spinner.setRange(-1000,1000)

        #KD motor PID values Spinner
        Motor_KD_Lable = QLabel("KD", Motor_PID_controller)
        Motor_KD_Spinner = QDoubleSpinBox(Motor_PID_controller)
        Motor_KD_Spinner.setSingleStep(0.01)
        Motor_KD_Spinner.setDecimals(6)
        Motor_KD_Spinner.valueChanged.connect(self.changeMotorKD)
        Motor_KD_Spinner.setRange(-1000,1000)

        #push button
        Motor_Button = QPushButton("Push", IMU_PI_values_spinners)
        Motor_Button.clicked.connect(self.Motor_Change_PID_values)
        

        #Layout
        Motor_PID_Layout.addWidget(Motor_KP_Lable)
        Motor_PID_Layout.addWidget(Motor_KP_Spinner)
        Motor_PID_Layout.addWidget(Motor_KI_Lable)
        Motor_PID_Layout.addWidget(Motor_KI_Spinner)
        Motor_PID_Layout.addWidget(Motor_KD_Lable)
        Motor_PID_Layout.addWidget(Motor_KD_Spinner)
        Motor_PID_Layout.addWidget(Motor_Button)
        Motor_PID_controller.setLayout(Motor_PID_Layout)


        # set the layout of the window
        windowLayout.addWidget(IMU_PI_values_spinners)
        windowLayout.addWidget(Motor_PID_controller)
        windowBox.setLayout(windowLayout)


        #node message setup      
        global IMU_str, Motor_str, IMU_publisher, Motor_publisher
        IMU_publisher = rospy.Publisher('IMU_settings', IMU_settings, queue_size=10)
        IMU_str = IMU_settings()
        IMU_str.KP = 0.0
        IMU_str.KI = 0.0
        Motor_publisher = rospy.Publisher('Motor_settings', Motor_settings, queue_size=10)
        Motor_str = Motor_settings()
        Motor_str.KP = 0.0
        Motor_str.KI = 0.0
        Motor_str.KD = 0.0



    def shutdown_plugin(self):
        # TODO unregister all publishers here
        pass

    def save_settings(self, plugin_settings, instance_settings):
        # TODO save intrinsic configuration, usually using:
        # instance_settings.set_value(k, v)
        pass

    def restore_settings(self, plugin_settings, instance_settings):
        # TODO restore intrinsic configuration, usually using:
        # v = instance_settings.value(k)
        pass

    # /code that runs whenever the slider is moved :)
    def changeIMUKP(self, value):
        IMU_str.KP = value

    def changeIMUKI(self, value):
        IMU_str.KI = value

    def changeMotorKP(self, value):
        Motor_str.KP = value

    def changeMotorKI(self, value):
        Motor_str.KI = value

    def changeMotorKD(self, value):
        Motor_str.KD = value

    def IMU_Change_PI_values(self, value):
        IMU_publisher.publish(IMU_str)

    def Motor_Change_PID_values(self, value):
        Motor_publisher.publish(Motor_str)

    #def trigger_configuration(self):
        # Comment in to signal that the plugin has a way to configure
        # This will enable a setting button (gear icon) in each dock widget title bar
        # Usually used to open a modal configuration dialog
