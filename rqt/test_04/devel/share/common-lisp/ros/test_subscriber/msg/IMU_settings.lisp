; Auto-generated. Do not edit!


(cl:in-package test_subscriber-msg)


;//! \htmlinclude IMU_settings.msg.html

(cl:defclass <IMU_settings> (roslisp-msg-protocol:ros-message)
  ((KP
    :reader KP
    :initarg :KP
    :type cl:float
    :initform 0.0)
   (KI
    :reader KI
    :initarg :KI
    :type cl:float
    :initform 0.0))
)

(cl:defclass IMU_settings (<IMU_settings>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IMU_settings>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IMU_settings)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name test_subscriber-msg:<IMU_settings> is deprecated: use test_subscriber-msg:IMU_settings instead.")))

(cl:ensure-generic-function 'KP-val :lambda-list '(m))
(cl:defmethod KP-val ((m <IMU_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader test_subscriber-msg:KP-val is deprecated.  Use test_subscriber-msg:KP instead.")
  (KP m))

(cl:ensure-generic-function 'KI-val :lambda-list '(m))
(cl:defmethod KI-val ((m <IMU_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader test_subscriber-msg:KI-val is deprecated.  Use test_subscriber-msg:KI instead.")
  (KI m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IMU_settings>) ostream)
  "Serializes a message object of type '<IMU_settings>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'KP))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'KI))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IMU_settings>) istream)
  "Deserializes a message object of type '<IMU_settings>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'KP) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'KI) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IMU_settings>)))
  "Returns string type for a message object of type '<IMU_settings>"
  "test_subscriber/IMU_settings")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IMU_settings)))
  "Returns string type for a message object of type 'IMU_settings"
  "test_subscriber/IMU_settings")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IMU_settings>)))
  "Returns md5sum for a message object of type '<IMU_settings>"
  "bb3456d77fcd813e0b5edd9a6c8556d2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IMU_settings)))
  "Returns md5sum for a message object of type 'IMU_settings"
  "bb3456d77fcd813e0b5edd9a6c8556d2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IMU_settings>)))
  "Returns full string definition for message of type '<IMU_settings>"
  (cl:format cl:nil "float64 KP~%float64 KI~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IMU_settings)))
  "Returns full string definition for message of type 'IMU_settings"
  (cl:format cl:nil "float64 KP~%float64 KI~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IMU_settings>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IMU_settings>))
  "Converts a ROS message object to a list"
  (cl:list 'IMU_settings
    (cl:cons ':KP (KP msg))
    (cl:cons ':KI (KI msg))
))
