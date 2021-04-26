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

class Angles {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.leg1_angle = null;
      this.leg2_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('leg1_angle')) {
        this.leg1_angle = initObj.leg1_angle
      }
      else {
        this.leg1_angle = 0.0;
      }
      if (initObj.hasOwnProperty('leg2_angle')) {
        this.leg2_angle = initObj.leg2_angle
      }
      else {
        this.leg2_angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Angles
    // Serialize message field [leg1_angle]
    bufferOffset = _serializer.float64(obj.leg1_angle, buffer, bufferOffset);
    // Serialize message field [leg2_angle]
    bufferOffset = _serializer.float64(obj.leg2_angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Angles
    let len;
    let data = new Angles(null);
    // Deserialize message field [leg1_angle]
    data.leg1_angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [leg2_angle]
    data.leg2_angle = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rqt_mypkg/Angles';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '985254c41e9ddd9bde0a2cf0dd651229';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 leg1_angle
    float64 leg2_angle
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Angles(null);
    if (msg.leg1_angle !== undefined) {
      resolved.leg1_angle = msg.leg1_angle;
    }
    else {
      resolved.leg1_angle = 0.0
    }

    if (msg.leg2_angle !== undefined) {
      resolved.leg2_angle = msg.leg2_angle;
    }
    else {
      resolved.leg2_angle = 0.0
    }

    return resolved;
    }
};

module.exports = Angles;
