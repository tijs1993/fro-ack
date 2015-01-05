'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ElectricityValueSchema = new Schema({
    measureday: Date,
    currentValue: Number,
    previousValue: Number,
    accountId: String
});

module.exports = mongoose.model('electricityvalue', ElectricityValueSchema);