; Auto-generated. Do not edit!


(cl:in-package messages_pkg-msg)


;//! \htmlinclude encoder_angles.msg.html

(cl:defclass <encoder_angles> (roslisp-msg-protocol:ros-message)
  ((leg1_torso_angle
    :reader leg1_torso_angle
    :initarg :leg1_torso_angle
    :type cl:float
    :initform 0.0)
   (leg2_torso_angle
    :reader leg2_torso_angle
    :initarg :leg2_torso_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass encoder_angles (<encoder_angles>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <encoder_angles>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'encoder_angles)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages_pkg-msg:<encoder_angles> is deprecated: use messages_pkg-msg:encoder_angles instead.")))

(cl:ensure-generic-function 'leg1_torso_angle-val :lambda-list '(m))
(cl:defmethod leg1_torso_angle-val ((m <encoder_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:leg1_torso_angle-val is deprecated.  Use messages_pkg-msg:leg1_torso_angle instead.")
  (leg1_torso_angle m))

(cl:ensure-generic-function 'leg2_torso_angle-val :lambda-list '(m))
(cl:defmethod leg2_torso_angle-val ((m <encoder_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:leg2_torso_angle-val is deprecated.  Use messages_pkg-msg:leg2_torso_angle instead.")
  (leg2_torso_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <encoder_angles>) ostream)
  "Serializes a message object of type '<encoder_angles>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'leg1_torso_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'leg2_torso_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <encoder_angles>) istream)
  "Deserializes a message object of type '<encoder_angles>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leg1_torso_angle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leg2_torso_angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<encoder_angles>)))
  "Returns string type for a message object of type '<encoder_angles>"
  "messages_pkg/encoder_angles")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'encoder_angles)))
  "Returns string type for a message object of type 'encoder_angles"
  "messages_pkg/encoder_angles")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<encoder_angles>)))
  "Returns md5sum for a message object of type '<encoder_angles>"
  "ffa8eca75cf9acd3fb0aa113a097a2c8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'encoder_angles)))
  "Returns md5sum for a message object of type 'encoder_angles"
  "ffa8eca75cf9acd3fb0aa113a097a2c8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<encoder_angles>)))
  "Returns full string definition for message of type '<encoder_angles>"
  (cl:format cl:nil "float32 leg1_torso_angle~%float32 leg2_torso_angle~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'encoder_angles)))
  "Returns full string definition for message of type 'encoder_angles"
  (cl:format cl:nil "float32 leg1_torso_angle~%float32 leg2_torso_angle~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <encoder_angles>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <encoder_angles>))
  "Converts a ROS message object to a list"
  (cl:list 'encoder_angles
    (cl:cons ':leg1_torso_angle (leg1_torso_angle msg))
    (cl:cons ':leg2_torso_angle (leg2_torso_angle msg))
))
