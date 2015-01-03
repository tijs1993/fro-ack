'use strict';

var _ = require('lodash');
var ExtraData = require('./extradata.model');

// Get list of things
exports.index = function (req, res) {
    ExtraData.find(function (err, extradata) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(200, extradata);
    });
};
exports.findByAccountId = function (req, res) {
    var query = ExtraData.where({accountId: "549975614cd1dfa8068e388a"});
    query.findOne(function (err, extradata) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(200, extradata);
    });
}

exports.create = function(req, res) {
    console.log(req.body);
    ExtraData.create(req.body, function(err, extradata) {
        if(err) { return handleError(res, err); }
        return res.json(201, extradata);
    });
};

function handleError(res, err) {
    return res.send(500, err);
}