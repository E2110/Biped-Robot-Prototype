# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 23:46:09 2017

@author: Torleif Anstensrud
"""

from win32com.client import Dispatch
from win32com.client import DispatchWithEvents
from dspace.com import Enums
from pywintypes import com_error
import tempfile
import os
import exceptions
import win32api
import time
from math import pi

# Define path and names
ProjectRootPath = "C:\Users\\robotuser\Documents\dSPACE\ControlDeskNG\\5.3"
MeasurementExportPath = "C:\Users\\robotuser\Documents\MATLAB\Experiments\Dynamic_identification_experiments"

ProjectName = "ThreeLinkBiped_TorsoSuspended"
ExperimentName = "Exp_MLegMotor_PD_Sine"

# Define sweep parameters
FrequencyStart = 0.4
FrequencyStop = 1.2
FrequencyInterval = 0.01
ReferenceAmplitude = 4
ControllerKp = 15
ControllerKd = 0.1
FilterSwitch = 1

RecordingTime = 5
TransientWaitTime = 30

SweepParameters = [('Tunable Parameters/ref_amplitude', ReferenceAmplitude), \
                   ('Tunable Parameters/Kp', ControllerKp),\
                   ('Tunable Parameters/Kd', ControllerKd),\
                   ('Tunable Parameters/filter_switch', FilterSwitch)]

# Enable WarmUp of bearings
WarmUpEnabled = False
WarmUpTime = 10 # Seconds

def Wait(Time):
    import pythoncom
    
    # Save current time point.
    StartTimePoint = time.time()
    
    while time.time() - StartTimePoint < Time:
        # Pump all waiting messages of the current thread.
        pythoncom.PumpWaitingMessages()

class MeasurementDataManagementEvents(object):

    def OnMeasurementStarted(self):
        print "--- The application changed to measurement state. ---"

    def OnMeasurementStarting(self):
        print "--- The application is going to change into measurement state. ---"

    def OnMeasurementStartingFailed(self):
        print "--- The application has failed to change into measurement state. ---"

    def OnMeasurementStopped(self):
        print "--- The application has left measurement state. ---"

    def OnPlatformMeasurementStarted(self, Platform):
        print "--- The platform %s changed to measurement state. ---" % Dispatch(Platform).Name

    def OnPlatformMeasurementStopped(self,  Platform):
        print "--- The platform %s has left measurement state. ---" % Dispatch(Platform).Name

    def OnPlatformMeasurementStarting(self, Platform):
        print "--- The platform %s is going to change into measurement state. ---" % Dispatch(Platform).Name

    def OnPlatformMeasurementStartingFailed(self, Platform):
        print "--- The platform %s has failed to change into the measurement state. ---" % Dispatch(Platform).Name
    
    def OnPlatformMeasurementDataLost(self, Platform):
        print "--- The platform %s has lost data. ---" % Dispatch(Platform).Name

    def OnRecorderStarted(self, Recorder):
        print "--- The recorder %s has started collecting data. ---" % Dispatch(Recorder).Name

    def OnRecorderStopped(self, Recorder):
        print "--- The recorder %s has stopped collecting data. ---" % Dispatch(Recorder).Name

    def OnRecordingStarted(self):
        print "--- The application changed to recording state. ---"

    def OnRecordingStopped(self):
        print "--- The application has left recording state. ---"

    def OnRecordingSaved(self, Recorder, FullPath):
        print "--- The recorder %s has saved the collected data to the location %s. ---" % (Dispatch(Recorder).Name, FullPath)

    def OnTriggerFired(self, TriggerRule):
        print "--- The trigger %s was fired. ---" % Dispatch(TriggerRule).Name

    def OnBookmarkAdded(self, Bookmark, Measurement):
        print "--- The bookmark %s was added to the recording. ---" % Dispatch(Bookmark).Title

    def OnBookmarkRemoving(self, Bookmark, Measurement):
        print "--- The bookmark %s is will be removed. ---" % Dispatch(Bookmark).Title

    def OnMeasurementBufferSaved(self, FullPath):
        print "--- The measurement buffer was saved to the file %s. ---" % FullPath

    def OnMeasurementClosing(self, Measurement):
        print "--- The measurement %s will be closed. ---" % Dispatch(Measurement).FileName

    def OnMeasurementClosed(self, FullPath):
        print "--- The measurement %s has closed. ---" % FullPath

    def OnMeasurementOpened(self, Measurement):
        print "--- The measurement %s has opened. ---" % Dispatch(Measurement).FileName
        
    def OnMeasurementExported(self, Measurement, FullPath):
        print "--- The measurement %s has exported to %s. ---" % (Dispatch(Measurement).FileName, FullPath)

    def OnMeasurementSaved(self, Measurement):
        print "--- The measurement %s has saved. ---" % Dispatch(Measurement).FileName

class MainExperimentController(object):
    def __init__(self):
        self.ControlDeskApplication = None
        self.Enums = None
        self.ProjectRoot = None
        self.ProjectObject = None
        self.ProjectManagement = None
        self.MeasurementDataManagement = None
        self.MainRecorder = None
    
    def Initialize(self):
        
        self.ControlDeskApplication = Dispatch("ControlDeskNG.Application.9")
        self.Enums = Enums(self.ControlDeskApplication)
        
        # Connect the events for the project management
        #self.ProjectManagement = DispatchWithEvents(self.ControlDeskApplication.ProjectManagement, ProjectManagementEvents)
        
        self.ControlDeskApplication.MainWindow.Visible = True
        self.ControlDeskApplication.MainWindow.State = self.Enums.MainWindowState.Maximized  

        self.MeasurementDataManagement = DispatchWithEvents(self.ControlDeskApplication.MeasurementDataManagement, MeasurementDataManagementEvents)

        self.ProjectRoot = self.ControlDeskApplication.ProjectRoots.Item(ProjectRootPath)
        self.ProjectRoot.Activate()
        Projects = self.ControlDeskApplication.Projects
        self.ProjectObject = Projects.Add(ProjectName)
        
        if self.ControlDeskApplication.MainWindow.Windows.Contains('Project'):
            self.ControlDeskApplication.MainWindow.Windows.Item('Project').Show()

        Experiment = self.ControlDeskApplication.ActiveProject.Experiments.Item(ExperimentName)
        Experiment.Activate()

        self.MainRecorder = self.MeasurementDataManagement.MainRecorder
        self.MainRecorder.AutomaticNamingEnabled = True
        self.MainRecorder.AddToExperimentEnabled = True
        self.MainRecorder.OpenInMeasurementDataPoolEnabled = True
        self.MainRecorder.AutomaticNamingStartIndex = 1
        self.MainRecorder.AutomaticNamingMinimumDigits = 3

        MeasurementBuffer = self.MeasurementDataManagement.MeasurementConfiguration.Buffer
        MeasurementBuffer.Size = 30.0
        MeasurementBuffer.WarningEnabled = True
        MeasurementBuffer.WarningTime = 3.0

        self.ControlDeskApplication.CalibrationManagement.StartOnlineCalibration()

    def WarmUp(self):
        #self.ControlDeskApplication.CalibrationManagement.StartOnlineCalibration()

        Variables = self.ControlDeskApplication.ActiveExperiment.Platforms[0].ActiveVariableDescription.Variables

        Variables.Item("Tunable Parameters/enable_motor").ValueConverted = 1
        Variables.Item("Tunable Parameters/ref_amplitude").ValueConverted = 20
        Variables.Item("Tunable Parameters/ref_frequency").ValueConverted = 0.5
       
        #self.ControlDeskApplication.CalibrationManagement.StopOnlineCalibration()

        Wait(WarmUpTime)

    def ConfigureSweepParameters(self):
        self.ControlDeskApplication.CalibrationManagement.StartOnlineCalibration()

        Variables = self.ControlDeskApplication.ActiveExperiment.Platforms[0].ActiveVariableDescription.Variables

        for Tupel in SweepParameters:
            Variable = Variables.Item(Tupel[0])
            Variable.ValueConverted = Tupel[1]

        self.ControlDeskApplication.CalibrationManagement.StopOnlineCalibration()

    def StopPendulum(self):
        #self.ControlDeskApplication.CalibrationManagement.StartOnlineCalibration()
        Variables = self.ControlDeskApplication.ActiveExperiment.Platforms[0].ActiveVariableDescription.Variables
        Variable = Variables.Item("Tunable Parameters/enable_motor")
        Variable.ValueConverted = 0

        PendulumAtRest = False

        WaitTime = 30

        while not PendulumAtRest and WaitTime > 0:
            Wait(1)
            AngularVelocity = Variables.Item('Model Root/Filter/Velocity')

            #print AngularVelocity.ValueConverted
            PendulumAtRest = abs(AngularVelocity.ValueConverted) < 0.01

            WaitTime -= 1

        print "Pendulum estimated to have stopped with velocity %s" %(AngularVelocity)

    def StartPendulum(self, Frequency):
        #self.ControlDeskApplication.CalibrationManagement.StartOnlineCalibration()
        Variables = self.ControlDeskApplication.ActiveExperiment.Platforms[0].ActiveVariableDescription.Variables
        
        Variables.Item("Tunable Parameters/ref_frequency").ValueConverted = Frequency
        Variables.Item("Tunable Parameters/enable_motor").ValueConverted = 1

        self.MeasurementDataManagement.Start()

        WaitTime = TransientWaitTime * 10
        Angle = 0

        while WaitTime > 0 and Angle < (30*pi/180):
            Wait(0.1)
            Angle = Variables.Item('Model Root/Filter/Angle')
            WaitTime -= 1

    def RecordMeasurement(self, TimeLimit):
        self.MainRecorder.BaseFileName = "Exp_%s_%s_MLegMotor_PD_Sine_.idf" %(time.strftime("%Y%m%d"), time.strftime("%H%M"))

        StopCondition = self.MainRecorder.StopCondition
        StopCondition.Enabled = True
        StopCondition.Type = self.Enums.StopConditionType.TimeLimit
        StopCondition.TimeLimit = TimeLimit

        self.Recording = True
        self.MainRecorder.Start(True, True)

        while self.MainRecorder.State == self.Enums.RecordingState.Running:
            Wait(0.1)

        #self.MeasurementDataManagement.Stop()
            
def main():
    ExperimentController = None

    try:
        print "Initializing ControlDesk"
        ExperimentController = MainExperimentController()
        ExperimentController.Initialize()

        if WarmUpEnabled:
            print "Warming up bearings for %s seconds" %(WarmUpTime)
            ExperimentController.WarmUp()
            ExperimentController.StopPendulum()
        
        ExperimentController.ConfigureSweepParameters()

        Frequency = FrequencyStart

        while Frequency < FrequencyStop:
            print 'Checking frequency = %s Hz' %(Frequency)
            ExperimentController.StartPendulum(Frequency)
            ExperimentController.RecordMeasurement(RecordingTime)
            ExperimentController.StopPendulum()
            Frequency += FrequencyInterval


    except exceptions.Exception, Message:
        import traceback
        traceback.print_exc() 

    finally:
       print "Finished"
            
    return True

#--------------------------------------------------------------------------------------------------
# Main Program
#--------------------------------------------------------------------------------------------------
if __name__ == '__main__':
    import sys
    main()
