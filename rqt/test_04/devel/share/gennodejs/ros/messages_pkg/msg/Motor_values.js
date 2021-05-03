// Auto-generated. Do not edit!

// (in-package messages_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Motor_values {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.motor1_value = null;
      this.motor2_value = null;
      this.OnOff = null;
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
      if (initObj.hasOwnProperty('OnOff')) {
        this.OnOff = initObj.OnOff
      }
      else {
        this.OnOff = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Motor_values
    // Serialize message field [motor1_value]
    bufferOffset = _serializer.float32(obj.motor1_value, buffer, bufferOffset);
    // Serialize message field [motor2_value]
    bufferOffset = _serializer.float32(obj.motor2_value, buffer, bufferOffset);
    // Serialize message field [OnOff]
    bufferOffset = _serializer.int16(obj.OnOff, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Motor_values
    let len;
    let data = new Motor_values(null);
    // Deserialize message field [motor1_value]
    data.motor1_value = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [motor2_value]
    data.motor2_value = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [OnOff]
    data.OnOff = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'messages_pkg/Motor_values';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '12eba4c10619ee8f4c0326813788bdcb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 motor1_value
    float32 motor2_value
    int16 OnOff
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Motor_values(null);
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

    if (msg.OnOff !== undefined) {
      resolved.OnOff = msg.OnOff;
    }
    else {
      resolved.OnOff = 0
    }

    return resolved;
    }
};

module.exports = Motor_values;
