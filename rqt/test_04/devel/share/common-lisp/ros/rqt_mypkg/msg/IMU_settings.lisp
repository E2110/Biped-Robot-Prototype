; Auto-generated. Do not edit!


(cl:in-package rqt_mypkg-msg)


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
    :initform 0.0)
   (Ireset
    :reader Ireset
    :initarg :Ireset
    :type cl:fixnum
    :initform 0))
)

(cl:defclass IMU_settings (<IMU_settings>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IMU_settings>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IMU_settings)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rqt_mypkg-msg:<IMU_settings> is deprecated: use rqt_mypkg-msg:IMU_settings instead.")))

(cl:ensure-generic-function 'KP-val :lambda-list '(m))
(cl:defmethod KP-val ((m <IMU_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:KP-val is deprecated.  Use rqt_mypkg-msg:KP instead.")
  (KP m))

(cl:ensure-generic-function 'KI-val :lambda-list '(m))
(cl:defmethod KI-val ((m <IMU_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:KI-val is deprecated.  Use rqt_mypkg-msg:KI instead.")
  (KI m))

(cl:ensure-generic-function 'Ireset-val :lambda-list '(m))
(cl:defmethod Ireset-val ((m <IMU_settings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rqt_mypkg-msg:Ireset-val is deprecated.  Use rqt_mypkg-msg:Ireset instead.")
  (Ireset m))
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
  (cl:let* ((signed (cl:slot-value msg 'Ireset)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Ireset) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IMU_settings>)))
  "Returns string type for a message object of type '<IMU_settings>"
  "rqt_mypkg/IMU_settings")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IMU_settings)))
  "Returns string type for a message object of type 'IMU_settings"
  "rqt_mypkg/IMU_settings")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IMU_settings>)))
  "Returns md5sum for a message object of type '<IMU_settings>"
  "d5a3580dc4de5a4fda51ba323d7d50f7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IMU_settings)))
  "Returns md5sum for a message object of type 'IMU_settings"
  "d5a3580dc4de5a4fda51ba323d7d50f7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IMU_settings>)))
  "Returns full string definition for message of type '<IMU_settings>"
  (cl:format cl:nil "float64 KP~%float64 KI~%int16 Ireset~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IMU_settings)))
  "Returns full string definition for message of type 'IMU_settings"
  (cl:format cl:nil "float64 KP~%float64 KI~%int16 Ireset~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IMU_settings>))
  (cl:+ 0
     8
     8
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IMU_settings>))
  "Converts a ROS message object to a list"
  (cl:list 'IMU_settings
    (cl:cons ':KP (KP msg))
    (cl:cons ':KI (KI msg))
    (cl:cons ':Ireset (Ireset msg))
))
