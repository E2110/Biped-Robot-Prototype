; Auto-generated. Do not edit!


(cl:in-package rqt_mypkg-msg)


;//! \htmlinclude Motor_values.msg.html

(cl:defclass <Motor_values> (roslisp-msg-protocol:ros-message)
  ((motor1_value
    :reader motor1_value
    :initarg :motor1_value
    :type cl:float
    :initform 0.0)
   (motor2_value
    :reader motor2_value
    :initarg :motor2_value
    :type cl:float
    :initform 0.0)
   (OnOff
    :reader OnOff
    :initarg :OnOff
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Motor_values (<Motor_values>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Motor_values>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Motor_values)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rqt_mypkg-msg:<Motor_values> is deprecated: use rqt_mypkg-msg:Motor_values instead.")))

(cl:ensure-generic-function 'motor1_value-val :lambda-list '(m))
(cl:defmethod motor1_value-val ((m <Motor_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:motor1_value-val is deprecated.  Use rqt_mypkg-msg:motor1_value instead.")
  (motor1_value m))

(cl:ensure-generic-function 'motor2_value-val :lambda-list '(m))
(cl:defmethod motor2_value-val ((m <Motor_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:motor2_value-val is deprecated.  Use rqt_mypkg-msg:motor2_value instead.")
  (motor2_value m))

(cl:ensure-generic-function 'OnOff-val :lambda-list '(m))
(cl:defmethod OnOff-val ((m <Motor_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:OnOff-val is deprecated.  Use rqt_mypkg-msg:OnOff instead.")
  (OnOff m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Motor_values>) ostream)
  "Serializes a message object of type '<Motor_values>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor1_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor2_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'OnOff)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Motor_values>) istream)
  "Deserializes a message object of type '<Motor_values>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor1_value) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor2_value) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'OnOff) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Motor_values>)))
  "Returns string type for a message object of type '<Motor_values>"
  "rqt_mypkg/Motor_values")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Motor_values)))
  "Returns string type for a message object of type 'Motor_values"
  "rqt_mypkg/Motor_values")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Motor_values>)))
  "Returns md5sum for a message object of type '<Motor_values>"
  "12eba4c10619ee8f4c0326813788bdcb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Motor_values)))
  "Returns md5sum for a message object of type 'Motor_values"
  "12eba4c10619ee8f4c0326813788bdcb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Motor_values>)))
  "Returns full string definition for message of type '<Motor_values>"
  (cl:format cl:nil "float32 motor1_value~%float32 motor2_value~%int16 OnOff~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Motor_values)))
  "Returns full string definition for message of type 'Motor_values"
  (cl:format cl:nil "float32 motor1_value~%float32 motor2_value~%int16 OnOff~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Motor_values>))
  (cl:+ 0
     4
     4
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Motor_values>))
  "Converts a ROS message object to a list"
  (cl:list 'Motor_values
    (cl:cons ':motor1_value (motor1_value msg))
    (cl:cons ':motor2_value (motor2_value msg))
    (cl:cons ':OnOff (OnOff msg))
))
