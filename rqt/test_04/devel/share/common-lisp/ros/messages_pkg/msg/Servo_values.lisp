; Auto-generated. Do not edit!


(cl:in-package messages_pkg-msg)


;//! \htmlinclude Servo_values.msg.html

(cl:defclass <Servo_values> (roslisp-msg-protocol:ros-message)
  ((Servo1_state
    :reader Servo1_state
    :initarg :Servo1_state
    :type cl:fixnum
    :initform 0)
   (Servo2_state
    :reader Servo2_state
    :initarg :Servo2_state
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Servo_values (<Servo_values>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Servo_values>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Servo_values)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name messages_pkg-msg:<Servo_values> is deprecated: use messages_pkg-msg:Servo_values instead.")))

(cl:ensure-generic-function 'Servo1_state-val :lambda-list '(m))
(cl:defmethod Servo1_state-val ((m <Servo_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:Servo1_state-val is deprecated.  Use messages_pkg-msg:Servo1_state instead.")
  (Servo1_state m))

(cl:ensure-generic-function 'Servo2_state-val :lambda-list '(m))
(cl:defmethod Servo2_state-val ((m <Servo_values>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader messages_pkg-msg:Servo2_state-val is deprecated.  Use messages_pkg-msg:Servo2_state instead.")
  (Servo2_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Servo_values>) ostream)
  "Serializes a message object of type '<Servo_values>"
  (cl:let* ((signed (cl:slot-value msg 'Servo1_state)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'Servo2_state)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Servo_values>) istream)
  "Deserializes a message object of type '<Servo_values>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Servo1_state) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Servo2_state) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Servo_values>)))
  "Returns string type for a message object of type '<Servo_values>"
  "messages_pkg/Servo_values")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Servo_values)))
  "Returns string type for a message object of type 'Servo_values"
  "messages_pkg/Servo_values")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Servo_values>)))
  "Returns md5sum for a message object of type '<Servo_values>"
  "204dedd2256b3647ed49ee8ef7c895f5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Servo_values)))
  "Returns md5sum for a message object of type 'Servo_values"
  "204dedd2256b3647ed49ee8ef7c895f5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Servo_values>)))
  "Returns full string definition for message of type '<Servo_values>"
  (cl:format cl:nil "int16 Servo1_state~%int16 Servo2_state~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Servo_values)))
  "Returns full string definition for message of type 'Servo_values"
  (cl:format cl:nil "int16 Servo1_state~%int16 Servo2_state~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Servo_values>))
  (cl:+ 0
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Servo_values>))
  "Converts a ROS message object to a list"
  (cl:list 'Servo_values
    (cl:cons ':Servo1_state (Servo1_state msg))
    (cl:cons ':Servo2_state (Servo2_state msg))
))
