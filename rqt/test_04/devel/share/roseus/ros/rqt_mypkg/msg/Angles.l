;; Auto-generated. Do not edit!


(when (boundp 'rqt_mypkg::Angles)
  (if (not (find-package "RQT_MYPKG"))
    (make-package "RQT_MYPKG"))
  (shadow 'Angles (find-package "RQT_MYPKG")))
(unless (find-package "RQT_MYPKG::ANGLES")
  (make-package "RQT_MYPKG::ANGLES"))

(in-package "ROS")
;;//! \htmlinclude Angles.msg.html


(defclass rqt_mypkg::Angles
  :super ros::object
  :slots (_leg1_angle _leg2_angle ))

(defmethod rqt_mypkg::Angles
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

(setf (get rqt_mypkg::Angles :md5sum-) "985254c41e9ddd9bde0a2cf0dd651229")
(setf (get rqt_mypkg::Angles :datatype-) "rqt_mypkg/Angles")
(setf (get rqt_mypkg::Angles :definition-)
      "float64 leg1_angle
float64 leg2_angle
")



(provide :rqt_mypkg/Angles "985254c41e9ddd9bde0a2cf0dd651229")


