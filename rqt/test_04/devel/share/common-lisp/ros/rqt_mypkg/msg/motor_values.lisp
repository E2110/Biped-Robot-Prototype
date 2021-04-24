; Auto-generated. Do not edit!


(cl:in-package rqt_mypkg-msg)


;//! \htmlinclude motor_values.msg.html

(cl:defclass <motor_values> (roslisp-msg-protocol:ros-message)
  ((motor1_value
    :reader motor1_value
    :initarg :motor1_value
    :type cl:float
    :initform 0.0)
   (motor2_value
    :reader motor2_value
    :initarg :motor2_value
    :type cl:float
    :initform 0.0))
)

(cl:defclass motor_values (<motor_values>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <motor_values>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'motor_values)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rqt_mypkg-msg:<motor_values> is deprecated: use rqt_mypkg-msg:motor_values instead.")))

(cl:ensure-generic-function 'motor1_value-val :lambda-list '(m))
(cl:defmethod motor1_value-val ((m <motor_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:motor1_value-val is deprecated.  Use rqt_mypkg-msg:motor1_value instead.")
  (motor1_value m))

(cl:ensure-generic-function 'motor2_value-val :lambda-list '(m))
(cl:defmethod motor2_value-val ((m <motor_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:motor2_value-val is deprecated.  Use rqt_mypkg-msg:motor2_value instead.")
  (motor2_value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <motor_values>) ostream)
  "Serializes a message object of type '<motor_values>"
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <motor_values>) istream)
  "Deserializes a message object of type '<motor_values>"
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<motor_values>)))
  "Returns string type for a message object of type '<motor_values>"
  "rqt_mypkg/motor_values")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'motor_values)))
  "Returns string type for a message object of type 'motor_values"
  "rqt_mypkg/motor_values")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<motor_values>)))
  "Returns md5sum for a message object of type '<motor_values>"
  "d0030d48ec79b36863e9007b5cb915eb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'motor_values)))
  "Returns md5sum for a message object of type 'motor_values"
  "d0030d48ec79b36863e9007b5cb915eb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<motor_values>)))
  "Returns full string definition for message of type '<motor_values>"
  (cl:format cl:nil "float32 motor1_value~%float32 motor2_value~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'motor_values)))
  "Returns full string definition for message of type 'motor_values"
  (cl:format cl:nil "float32 motor1_value~%float32 motor2_value~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <motor_values>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <motor_values>))
  "Converts a ROS message object to a list"
  (cl:list 'motor_values
    (cl:cons ':motor1_value (motor1_value msg))
    (cl:cons ':motor2_value (motor2_value msg))
))
