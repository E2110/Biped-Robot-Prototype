;; Auto-generated. Do not edit!


(when (boundp 'rqt_mypkg::motor_values)
  (if (not (find-package "RQT_MYPKG"))
    (make-package "RQT_MYPKG"))
  (shadow 'motor_values (find-package "RQT_MYPKG")))
(unless (find-package "RQT_MYPKG::MOTOR_VALUES")
  (make-package "RQT_MYPKG::MOTOR_VALUES"))

(in-package "ROS")
;;//! \htmlinclude motor_values.msg.html


(defclass rqt_mypkg::motor_values
  :super ros::object
  :slots (_motor1_value _motor2_value _OnOff ))

(defmethod rqt_mypkg::motor_values
  (:init
   (&key
    ((:motor1_value __motor1_value) 0.0)
    ((:motor2_value __motor2_value) 0.0)
    ((:OnOff __OnOff) 0)
    )
   (send-super :init)
   (setq _motor1_value (float __motor1_value))
   (setq _motor2_value (float __motor2_value))
   (setq _OnOff (round __OnOff))
   self)
  (:motor1_value
   (&optional __motor1_value)
   (if __motor1_value (setq _motor1_value __motor1_value)) _motor1_value)
  (:motor2_value
   (&optional __motor2_value)
   (if __motor2_value (setq _motor2_value __motor2_value)) _motor2_value)
  (:OnOff
   (&optional __OnOff)
   (if __OnOff (setq _OnOff __OnOff)) _OnOff)
  (:serialization-length
   ()
   (+
    ;; float32 _motor1_value
    4
    ;; float32 _motor2_value
    4
    ;; int16 _OnOff
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _motor1_value
       (sys::poke _motor1_value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _motor2_value
       (sys::poke _motor2_value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int16 _OnOff
       (write-word _OnOff s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _motor1_value
     (setq _motor1_value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _motor2_value
     (setq _motor2_value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int16 _OnOff
     (setq _OnOff (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get rqt_mypkg::motor_values :md5sum-) "12eba4c10619ee8f4c0326813788bdcb")
(setf (get rqt_mypkg::motor_values :datatype-) "rqt_mypkg/motor_values")
(setf (get rqt_mypkg::motor_values :definition-)
      "float32 motor1_value
float32 motor2_value
int16 OnOff
")



(provide :rqt_mypkg/motor_values "12eba4c10619ee8f4c0326813788bdcb")


