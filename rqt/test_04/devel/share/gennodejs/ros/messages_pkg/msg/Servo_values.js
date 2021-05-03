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

class Servo_values {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Servo1_state = null;
      this.Servo2_state = null;
    }
    else {
      if (initObj.hasOwnProperty('Servo1_state')) {
        this.Servo1_state = initObj.Servo1_state
      }
      else {
        this.Servo1_state = 0;
      }
      if (initObj.hasOwnProperty('Servo2_state')) {
        this.Servo2_state = initObj.Servo2_state
      }
      else {
        this.Servo2_state = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Servo_values
    // Serialize message field [Servo1_state]
    bufferOffset = _serializer.int16(obj.Servo1_state, buffer, bufferOffset);
    // Serialize message field [Servo2_state]
    bufferOffset = _serializer.int16(obj.Servo2_state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Servo_values
    let len;
    let data = new Servo_values(null);
    // Deserialize message field [Servo1_state]
    data.Servo1_state = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [Servo2_state]
    data.Servo2_state = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'messages_pkg/Servo_values';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '204dedd2256b3647ed49ee8ef7c895f5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16 Servo1_state
    int16 Servo2_state
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Servo_values(null);
    if (msg.Servo1_state !== undefined) {
      resolved.Servo1_state = msg.Servo1_state;
    }
    else {
      resolved.Servo1_state = 0
    }

    if (msg.Servo2_state !== undefined) {
      resolved.Servo2_state = msg.Servo2_state;
    }
    else {
      resolved.Servo2_state = 0
    }

    return resolved;
    }
};

module.exports = Servo_values;
