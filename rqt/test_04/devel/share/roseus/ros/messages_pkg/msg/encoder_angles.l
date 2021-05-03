;; Auto-generated. Do not edit!


(when (boundp 'messages_pkg::encoder_angles)
  (if (not (find-package "MESSAGES_PKG"))
    (make-package "MESSAGES_PKG"))
  (shadow 'encoder_angles (find-package "MESSAGES_PKG")))
(unless (find-package "MESSAGES_PKG::ENCODER_ANGLES")
  (make-package "MESSAGES_PKG::ENCODER_ANGLES"))

(in-package "ROS")
;;//! \htmlinclude encoder_angles.msg.html


(defclass messages_pkg::encoder_angles
  :super ros::object
  :slots (_leg1_torso_angle _leg2_torso_angle ))

(defmethod messages_pkg::encoder_angles
  (:init
   (&key
    ((:leg1_torso_angle __leg1_torso_angle) 0.0)
    ((:leg2_torso_angle __leg2_torso_angle) 0.0)
    )
   (send-super :init)
   (setq _leg1_torso_angle (float __leg1_torso_angle))
   (setq _leg2_torso_angle (float __leg2_torso_angle))
   self)
  (:leg1_torso_angle
   (&optional __leg1_torso_angle)
   (if __leg1_torso_angle (setq _leg1_torso_angle __leg1_torso_angle)) _leg1_torso_angle)
  (:leg2_torso_angle
   (&optional __leg2_torso_angle)
   (if __leg2_torso_angle (setq _leg2_torso_angle __leg2_torso_angle)) _leg2_torso_angle)
  (:serialization-length
   ()
   (+
    ;; float32 _leg1_torso_angle
    4
    ;; float32 _leg2_torso_angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _leg1_torso_angle
       (sys::poke _leg1_torso_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _leg2_torso_angle
       (sys::poke _leg2_torso_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _leg1_torso_angle
     (setq _leg1_torso_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _leg2_torso_angle
     (setq _leg2_torso_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get messages_pkg::encoder_angles :md5sum-) "ffa8eca75cf9acd3fb0aa113a097a2c8")
(setf (get messages_pkg::encoder_angles :datatype-) "messages_pkg/encoder_angles")
(setf (get messages_pkg::encoder_angles :definition-)
      "float32 leg1_torso_angle
float32 leg2_torso_angle
")



(provide :messages_pkg/encoder_angles "ffa8eca75cf9acd3fb0aa113a097a2c8")


