// Auto-generated. Do not edit!

// (in-package test_subscriber.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class IMU_settings {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.KP = null;
      this.KI = null;
    }
    else {
      if (initObj.hasOwnProperty('KP')) {
        this.KP = initObj.KP
      }
      else {
        this.KP = 0.0;
      }
      if (initObj.hasOwnProperty('KI')) {
        this.KI = initObj.KI
      }
      else {
        this.KI = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IMU_settings
    // Serialize message field [KP]
    bufferOffset = _serializer.float64(obj.KP, buffer, bufferOffset);
    // Serialize message field [KI]
    bufferOffset = _serializer.float64(obj.KI, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type IMU_settings
    let len;
    let data = new IMU_settings(null);
    // Deserialize message field [KP]
    data.KP = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [KI]
    data.KI = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'test_subscriber/IMU_settings';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bb3456d77fcd813e0b5edd9a6c8556d2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 KP
    float64 KI
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new IMU_settings(null);
    if (msg.KP !== undefined) {
      resolved.KP = msg.KP;
    }
    else {
      resolved.KP = 0.0
    }

    if (msg.KI !== undefined) {
      resolved.KI = msg.KI;
    }
    else {
      resolved.KI = 0.0
    }

    return resolved;
    }
};

module.exports = IMU_settings;
