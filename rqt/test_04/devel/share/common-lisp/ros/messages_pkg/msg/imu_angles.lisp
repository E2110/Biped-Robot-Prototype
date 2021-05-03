; Auto-generated. Do not edit!


(cl:in-package messages_pkg-msg)


;//! \htmlinclude imu_angles.msg.html

(cl:defclass <imu_angles> (roslisp-msg-protocol:ros-message)
  ((leg1_angle
    :reader leg1_angle
    :initarg :leg1_angle
    :type cl:float
    :initform 0.0)
   (leg2_angle
    :reader leg2_angle
    :initarg :leg2_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass imu_angles (<imu_angles>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <imu_angles>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'imu_angles)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages_pkg-msg:<imu_angles> is deprecated: use messages_pkg-msg:imu_angles instead.")))

(cl:ensure-generic-function 'leg1_angle-val :lambda-list '(m))
(cl:defmethod leg1_angle-val ((m <imu_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:leg1_angle-val is deprecated.  Use messages_pkg-msg:leg1_angle instead.")
  (leg1_angle m))

(cl:ensure-generic-function 'leg2_angle-val :lambda-list '(m))
(cl:defmethod leg2_angle-val ((m <imu_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:leg2_angle-val is deprecated.  Use messages_pkg-msg:leg2_angle instead.")
  (leg2_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <imu_angles>) ostream)
  "Serializes a message object of type '<imu_angles>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'leg1_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'leg2_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <imu_angles>) istream)
  "Deserializes a message object of type '<imu_angles>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leg1_angle) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leg2_angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<imu_angles>)))
  "Returns string type for a message object of type '<imu_angles>"
  "messages_pkg/imu_angles")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'imu_angles)))
  "Returns string type for a message object of type 'imu_angles"
  "messages_pkg/imu_angles")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<imu_angles>)))
  "Returns md5sum for a message object of type '<imu_angles>"
  "985254c41e9ddd9bde0a2cf0dd651229")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'imu_angles)))
  "Returns md5sum for a message object of type 'imu_angles"
  "985254c41e9ddd9bde0a2cf0dd651229")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<imu_angles>)))
  "Returns full string definition for message of type '<imu_angles>"
  (cl:format cl:nil "float64 leg1_angle~%float64 leg2_angle~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'imu_angles)))
  "Returns full string definition for message of type 'imu_angles"
  (cl:format cl:nil "float64 leg1_angle~%float64 leg2_angle~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <imu_angles>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <imu_angles>))
  "Converts a ROS message object to a list"
  (cl:list 'imu_angles
    (cl:cons ':leg1_angle (leg1_angle msg))
    (cl:cons ':leg2_angle (leg2_angle msg))
))
