// Auto-generated. Do not edit!

// (in-package rqt_mypkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class motor_values {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.motor1_value = null;
      this.motor2_value = null;
    }
    else {
      if (initObj.hasOwnProperty('motor1_value')) {
        this.motor1_value = initObj.motor1_value
      }
      else {
        this.motor1_value = 0.0;
      }
      if (initObj.hasOwnProperty('motor2_value')) {
        this.motor2_value = initObj.motor2_value
      }
      else {
        this.motor2_value = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type motor_values
    // Serialize message field [motor1_value]
    bufferOffset = _serializer.float32(obj.motor1_value, buffer, bufferOffset);
    // Serialize message field [motor2_value]
    bufferOffset = _serializer.float32(obj.motor2_value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type motor_values
    let len;
    let data = new motor_values(null);
    // Deserialize message field [motor1_value]
    data.motor1_value = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [motor2_value]
    data.motor2_value = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rqt_mypkg/motor_values';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd0030d48ec79b36863e9007b5cb915eb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 motor1_value
    float32 motor2_value
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new motor_values(null);
    if (msg.motor1_value !== undefined) {
      resolved.motor1_value = msg.motor1_value;
    }
    else {
      resolved.motor1_value = 0.0
    }

    if (msg.motor2_value !== undefined) {
      resolved.motor2_value = msg.motor2_value;
    }
    else {
      resolved.motor2_value = 0.0
    }

    return resolved;
    }
};

module.exports = motor_values;
