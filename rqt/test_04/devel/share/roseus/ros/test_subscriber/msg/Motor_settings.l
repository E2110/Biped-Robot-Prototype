;; Auto-generated. Do not edit!


(when (boundp 'test_subscriber::Motor_settings)
  (if (not (find-package "TEST_SUBSCRIBER"))
    (make-package "TEST_SUBSCRIBER"))
  (shadow 'Motor_settings (find-package "TEST_SUBSCRIBER")))
(unless (find-package "TEST_SUBSCRIBER::MOTOR_SETTINGS")
  (make-package "TEST_SUBSCRIBER::MOTOR_SETTINGS"))

(in-package "ROS")
;;//! \htmlinclude Motor_settings.msg.html


(defclass test_subscriber::Motor_settings
  :super ros::object
  :slots (_KP _KI _KD ))

(defmethod test_subscriber::Motor_settings
  (:init
   (&key
    ((:KP __KP) 0.0)
    ((:KI __KI) 0.0)
    ((:KD __KD) 0.0)
    )
   (send-super :init)
   (setq _KP (float __KP))
   (setq _KI (float __KI))
   (setq _KD (float __KD))
   self)
  (:KP
   (&optional __KP)
   (if __KP (setq _KP __KP)) _KP)
  (:KI
   (&optional __KI)
   (if __KI (setq _KI __KI)) _KI)
  (:KD
   (&optional __KD)
   (if __KD (setq _KD __KD)) _KD)
  (:serialization-length
   ()
   (+
    ;; float64 _KP
    8
    ;; float64 _KI
    8
    ;; float64 _KD
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _KP
       (sys::poke _KP (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _KI
       (sys::poke _KI (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _KD
       (sys::poke _KD (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _KP
     (setq _KP (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _KI
     (setq _KI (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _KD
     (setq _KD (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get test_subscriber::Motor_settings :md5sum-) "136a480595a5448a1d1b3eef5d307252")
(setf (get test_subscriber::Motor_settings :datatype-) "test_subscriber/Motor_settings")
(setf (get test_subscriber::Motor_settings :definition-)
      "float64 KP
float64 KI
float64 KD

")



(provide :test_subscriber/Motor_settings "136a480595a5448a1d1b3eef5d307252")

