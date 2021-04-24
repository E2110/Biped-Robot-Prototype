
(cl:in-package :asdf)

(defsystem "rqt_mypkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Angles" :depends-on ("_package_Angles"))
    (:file "_package_Angles" :depends-on ("_package"))
    (:file "IMU_settings" :depends-on ("_package_IMU_settings"))
    (:file "_package_IMU_settings" :depends-on ("_package"))
    (:file "Motor_settings" :depends-on ("_package_Motor_settings"))
    (:file "_package_Motor_settings" :depends-on ("_package"))
    (:file "motor_values" :depends-on ("_package_motor_values"))
    (:file "_package_motor_values" :depends-on ("_package"))
  ))