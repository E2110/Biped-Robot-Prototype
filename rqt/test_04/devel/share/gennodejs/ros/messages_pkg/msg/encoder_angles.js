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

class encoder_angles {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.leg1_torso_angle = null;
      this.leg2_torso_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('leg1_torso_angle')) {
        this.leg1_torso_angle = initObj.leg1_torso_angle
      }
      else {
        this.leg1_torso_angle = 0.0;
      }
      if (initObj.hasOwnProperty('leg2_torso_angle')) {
        this.leg2_torso_angle = initObj.leg2_torso_angle
      }
      else {
        this.leg2_torso_angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type encoder_angles
    // Serialize message field [leg1_torso_angle]
    bufferOffset = _serializer.float32(obj.leg1_torso_angle, buffer, bufferOffset);
    // Serialize message field [leg2_torso_angle]
    bufferOffset = _serializer.float32(obj.leg2_torso_angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type encoder_angles
    let len;
    let data = new encoder_angles(null);
    // Deserialize message field [leg1_torso_angle]
    data.leg1_torso_angle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [leg2_torso_angle]
    data.leg2_torso_angle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'messages_pkg/encoder_angles';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ffa8eca75cf9acd3fb0aa113a097a2c8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 leg1_torso_angle
    float32 leg2_torso_angle
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new encoder_angles(null);
    if (msg.leg1_torso_angle !== undefined) {
      resolved.leg1_torso_angle = msg.leg1_torso_angle;
    }
    else {
      resolved.leg1_torso_angle = 0.0
    }

    if (msg.leg2_torso_angle !== undefined) {
      resolved.leg2_torso_angle = msg.leg2_torso_angle;
    }
    else {
      resolved.leg2_torso_angle = 0.0
    }

    return resolved;
    }
};

module.exports = encoder_angles;
