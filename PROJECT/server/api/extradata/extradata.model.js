'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ExtraDataSchema = new Schema({
    address: {
        street: String,
        number: Number,
        zipcode: Number,
        city: String,
        country: String
    },
    birthday: Date,
    numberOfResidents: Number,
    meterType: String,
    insulation: String,
    typeOfHeating: String,
    sizeOfBuilding: String,
    accountId: String,
    isOnline: Boolean
});

module.exports = mongoose.model('extradata', ExtraDataSchema);