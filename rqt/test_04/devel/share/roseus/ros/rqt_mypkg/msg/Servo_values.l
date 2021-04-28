;; Auto-generated. Do not edit!


(when (boundp 'rqt_mypkg::Servo_values)
  (if (not (find-package "RQT_MYPKG"))
    (make-package "RQT_MYPKG"))
  (shadow 'Servo_values (find-package "RQT_MYPKG")))
(unless (find-package "RQT_MYPKG::SERVO_VALUES")
  (make-package "RQT_MYPKG::SERVO_VALUES"))

(in-package "ROS")
;;//! \htmlinclude Servo_values.msg.html


(defclass rqt_mypkg::Servo_values
  :super ros::object
  :slots (_Servo1_state _Servo2_state ))

(defmethod rqt_mypkg::Servo_values
  (:init
   (&key
    ((:Servo1_state __Servo1_state) 0)
    ((:Servo2_state __Servo2_state) 0)
    )
   (send-super :init)
   (setq _Servo1_state (round __Servo1_state))
   (setq _Servo2_state (round __Servo2_state))
   self)
  (:Servo1_state
   (&optional __Servo1_state)
   (if __Servo1_state (setq _Servo1_state __Servo1_state)) _Servo1_state)
  (:Servo2_state
   (&optional __Servo2_state)
   (if __Servo2_state (setq _Servo2_state __Servo2_state)) _Servo2_state)
  (:serialization-length
   ()
   (+
    ;; int16 _Servo1_state
    2
    ;; int16 _Servo2_state
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _Servo1_state
       (write-word _Servo1_state s)
     ;; int16 _Servo2_state
       (write-word _Servo2_state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _Servo1_state
     (setq _Servo1_state (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _Servo2_state
     (setq _Servo2_state (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get rqt_mypkg::Servo_values :md5sum-) "204dedd2256b3647ed49ee8ef7c895f5")
(setf (get rqt_mypkg::Servo_values :datatype-) "rqt_mypkg/Servo_values")
(setf (get rqt_mypkg::Servo_values :definition-)
      "int16 Servo1_state
int16 Servo2_state
")



(provide :rqt_mypkg/Servo_values "204dedd2256b3647ed49ee8ef7c895f5")


