;; Auto-generated. Do not edit!


(when (boundp 'messages_pkg::IMU_settings)
  (if (not (find-package "MESSAGES_PKG"))
    (make-package "MESSAGES_PKG"))
  (shadow 'IMU_settings (find-package "MESSAGES_PKG")))
(unless (find-package "MESSAGES_PKG::IMU_SETTINGS")
  (make-package "MESSAGES_PKG::IMU_SETTINGS"))

(in-package "ROS")
;;//! \htmlinclude IMU_settings.msg.html


(defclass messages_pkg::IMU_settings
  :super ros::object
  :slots (_KP _KI _Ireset ))

(defmethod messages_pkg::IMU_settings
  (:init
   (&key
    ((:KP __KP) 0.0)
    ((:KI __KI) 0.0)
    ((:Ireset __Ireset) 0)
    )
   (send-super :init)
   (setq _KP (float __KP))
   (setq _KI (float __KI))
   (setq _Ireset (round __Ireset))
   self)
  (:KP
   (&optional __KP)
   (if __KP (setq _KP __KP)) _KP)
  (:KI
   (&optional __KI)
   (if __KI (setq _KI __KI)) _KI)
  (:Ireset
   (&optional __Ireset)
   (if __Ireset (setq _Ireset __Ireset)) _Ireset)
  (:serialization-length
   ()
   (+
    ;; float64 _KP
    8
    ;; float64 _KI
    8
    ;; int16 _Ireset
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _KP
       (sys::poke _KP (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _KI
       (sys::poke _KI (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int16 _Ireset
       (write-word _Ireset s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _KP
     (setq _KP (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _KI
     (setq _KI (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int16 _Ireset
     (setq _Ireset (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get messages_pkg::IMU_settings :md5sum-) "d5a3580dc4de5a4fda51ba323d7d50f7")
(setf (get messages_pkg::IMU_settings :datatype-) "messages_pkg/IMU_settings")
(setf (get messages_pkg::IMU_settings :definition-)
      "float64 KP
float64 KI
int16 Ireset
")



(provide :messages_pkg/IMU_settings "d5a3580dc4de5a4fda51ba323d7d50f7")


