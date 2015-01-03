'use strict';

var _ = require('lodash');
var ElectricityValue = require('./electricityvalue.model');

// Get list of things
exports.index = function (req, res) {
    ElectricityValue.find(function (err, elecValue) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(200, elecValue);
    });
};
exports.findByAccountId = function (req, res) {
    var query = ElectricityValue.where({accountId: req.params.id});
    query.find(function (err, elecValue) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(elecValue);
    });
};
exports.create = function(req, res) {
    console.log(req.body);
    ElectricityValue.create(req.body, function(err, elecValue) {
        if(err) { return handleError(res, err); }
        return res.json(201, elecValue);
    });
};

function handleError(res, err) {
    return res.send(500, err);
}