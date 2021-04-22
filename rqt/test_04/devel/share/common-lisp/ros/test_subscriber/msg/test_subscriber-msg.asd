
(cl:in-package :asdf)

(defsystem "test_subscriber-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "IMU_settings" :depends-on ("_package_IMU_settings"))
    (:file "_package_IMU_settings" :depends-on ("_package"))
    (:file "Motor_settings" :depends-on ("_package_Motor_settings"))
    (:file "_package_Motor_settings" :depends-on ("_package"))
  ))