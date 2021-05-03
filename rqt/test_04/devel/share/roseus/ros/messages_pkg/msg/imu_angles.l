;; Auto-generated. Do not edit!


(when (boundp 'messages_pkg::imu_angles)
  (if (not (find-package "MESSAGES_PKG"))
    (make-package "MESSAGES_PKG"))
  (shadow 'imu_angles (find-package "MESSAGES_PKG")))
(unless (find-package "MESSAGES_PKG::IMU_ANGLES")
  (make-package "MESSAGES_PKG::IMU_ANGLES"))

(in-package "ROS")
;;//! \htmlinclude imu_angles.msg.html


(defclass messages_pkg::imu_angles
  :super ros::object
  :slots (_leg1_angle _leg2_angle ))

(defmethod messages_pkg::imu_angles
  (:init
   (&key
    ((:leg1_angle __leg1_angle) 0.0)
    ((:leg2_angle __leg2_angle) 0.0)
    )
   (send-super :init)
   (setq _leg1_angle (float __leg1_angle))
   (setq _leg2_angle (float __leg2_angle))
   self)
  (:leg1_angle
   (&optional __leg1_angle)
   (if __leg1_angle (setq _leg1_angle __leg1_angle)) _leg1_angle)
  (:leg2_angle
   (&optional __leg2_angle)
   (if __leg2_angle (setq _leg2_angle __leg2_angle)) _leg2_angle)
  (:serialization-length
   ()
   (+
    ;; float64 _leg1_angle
    8
    ;; float64 _leg2_angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _leg1_angle
       (sys::poke _leg1_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _leg2_angle
       (sys::poke _leg2_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _leg1_angle
     (setq _leg1_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _leg2_angle
     (setq _leg2_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get messages_pkg::imu_angles :md5sum-) "985254c41e9ddd9bde0a2cf0dd651229")
(setf (get messages_pkg::imu_angles :datatype-) "messages_pkg/imu_angles")
(setf (get messages_pkg::imu_angles :definition-)
      "float64 leg1_angle
float64 leg2_angle
")



(provide :messages_pkg/imu_angles "985254c41e9ddd9bde0a2cf0dd651229")


