; Auto-generated. Do not edit!


(cl:in-package messages_pkg-msg)


;//! \htmlinclude Motor_settings.msg.html

(cl:defclass <Motor_settings> (roslisp-msg-protocol:ros-message)
  ((KP
    :reader KP
    :initarg :KP
    :type cl:float
    :initform 0.0)
   (KI
    :reader KI
    :initarg :KI
    :type cl:float
    :initform 0.0)
   (KD
    :reader KD
    :initarg :KD
    :type cl:float
    :initform 0.0))
)

(cl:defclass Motor_settings (<Motor_settings>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Motor_settings>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Motor_settings)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages_pkg-msg:<Motor_settings> is deprecated: use messages_pkg-msg:Motor_settings instead.")))

(cl:ensure-generic-function 'KP-val :lambda-list '(m))
(cl:defmethod KP-val ((m <Motor_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:KP-val is deprecated.  Use messages_pkg-msg:KP instead.")
  (KP m))

(cl:ensure-generic-function 'KI-val :lambda-list '(m))
(cl:defmethod KI-val ((m <Motor_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:KI-val is deprecated.  Use messages_pkg-msg:KI instead.")
  (KI m))

(cl:ensure-generic-function 'KD-val :lambda-list '(m))
(cl:defmethod KD-val ((m <Motor_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:KD-val is deprecated.  Use messages_pkg-msg:KD instead.")
  (KD m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Motor_settings>) ostream)
  "Serializes a message object of type '<Motor_settings>"
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
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'KD))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Motor_settings>) istream)
  "Deserializes a message object of type '<Motor_settings>"
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'KD) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Motor_settings>)))
  "Returns string type for a message object of type '<Motor_settings>"
  "messages_pkg/Motor_settings")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Motor_settings)))
  "Returns string type for a message object of type 'Motor_settings"
  "messages_pkg/Motor_settings")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Motor_settings>)))
  "Returns md5sum for a message object of type '<Motor_settings>"
  "136a480595a5448a1d1b3eef5d307252")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Motor_settings)))
  "Returns md5sum for a message object of type 'Motor_settings"
  "136a480595a5448a1d1b3eef5d307252")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Motor_settings>)))
  "Returns full string definition for message of type '<Motor_settings>"
  (cl:format cl:nil "float64 KP~%float64 KI~%float64 KD~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Motor_settings)))
  "Returns full string definition for message of type 'Motor_settings"
  (cl:format cl:nil "float64 KP~%float64 KI~%float64 KD~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Motor_settings>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Motor_settings>))
  "Converts a ROS message object to a list"
  (cl:list 'Motor_settings
    (cl:cons ':KP (KP msg))
    (cl:cons ':KI (KI msg))
    (cl:cons ':KD (KD msg))
))
