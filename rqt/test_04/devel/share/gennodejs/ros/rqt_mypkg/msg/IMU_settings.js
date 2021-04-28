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

class IMU_settings {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.KP = null;
      this.KI = null;
      this.Ireset = null;
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
      if (initObj.hasOwnProperty('Ireset')) {
        this.Ireset = initObj.Ireset
      }
      else {
        this.Ireset = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IMU_settings
    // Serialize message field [KP]
    bufferOffset = _serializer.float64(obj.KP, buffer, bufferOffset);
    // Serialize message field [KI]
    bufferOffset = _serializer.float64(obj.KI, buffer, bufferOffset);
    // Serialize message field [Ireset]
    bufferOffset = _serializer.int16(obj.Ireset, buffer, bufferOffset);
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
    // Deserialize message field [Ireset]
    data.Ireset = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 18;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rqt_mypkg/IMU_settings';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd5a3580dc4de5a4fda51ba323d7d50f7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 KP
    float64 KI
    int16 Ireset
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

    if (msg.Ireset !== undefined) {
      resolved.Ireset = msg.Ireset;
    }
    else {
      resolved.Ireset = 0
    }

    return resolved;
    }
};

module.exports = IMU_settings;
