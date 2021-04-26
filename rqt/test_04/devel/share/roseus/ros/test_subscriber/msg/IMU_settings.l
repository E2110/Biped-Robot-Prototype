;; Auto-generated. Do not edit!


(when (boundp 'test_subscriber::IMU_settings)
  (if (not (find-package "TEST_SUBSCRIBER"))
    (make-package "TEST_SUBSCRIBER"))
  (shadow 'IMU_settings (find-package "TEST_SUBSCRIBER")))
(unless (find-package "TEST_SUBSCRIBER::IMU_SETTINGS")
  (make-package "TEST_SUBSCRIBER::IMU_SETTINGS"))

(in-package "ROS")
;;//! \htmlinclude IMU_settings.msg.html


(defclass test_subscriber::IMU_settings
  :super ros::object
  :slots (_KP _KI ))

(defmethod test_subscriber::IMU_settings
  (:init
   (&key
    ((:KP __KP) 0.0)
    ((:KI __KI) 0.0)
    )
   (send-super :init)
   (setq _KP (float __KP))
   (setq _KI (float __KI))
   self)
  (:KP
   (&optional __KP)
   (if __KP (setq _KP __KP)) _KP)
  (:KI
   (&optional __KI)
   (if __KI (setq _KI __KI)) _KI)
  (:serialization-length
   ()
   (+
    ;; float64 _KP
    8
    ;; float64 _KI
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
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _KP
     (setq _KP (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _KI
     (setq _KI (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get test_subscriber::IMU_settings :md5sum-) "bb3456d77fcd813e0b5edd9a6c8556d2")
(setf (get test_subscriber::IMU_settings :datatype-) "test_subscriber/IMU_settings")
(setf (get test_subscriber::IMU_settings :definition-)
      "float64 KP
float64 KI
")



(provide :test_subscriber/IMU_settings "bb3456d77fcd813e0b5edd9a6c8556d2")


