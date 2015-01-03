'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ElectricityValueSchema = new Schema({
    measureday: Date,
    previousValue: Number,
    currentValue: Number,
    meterType: String,
    accountId: String
});

module.exports = mongoose.model('electricityvalue', ElectricityValueSchema);