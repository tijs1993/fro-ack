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
    //Thing.findById(req.params.id, function (err, thing) {
    var query = ExtraData.where({accountId: req.params.id});
    query.findOne(function (err, extradata) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(extradata);
    });
}

exports.create = function(req, res) {
    console.log(req.body);
    ExtraData.create(req.body, function(err, extradata) {
        if(err) { return handleError(res, err); }
        return res.json(201, extradata);
    });
};
exports.update = function(req, res){
    /*
    if(req.body._id) { delete req.body._id; }
    Thing.findById(req.params.id, function (err, thing) {
        if (err) { return handleError(res, err); }
        if(!thing) { return res.send(404); }
        var updated = _.merge(thing, req.body);
        updated.save(function (err) {
            if (err) { return handleError(res, err); }
            return res.json(200, thing);
        });
    });*/
    ExtraData.findById(req.body._id, function(err, extradata){
       if(err){return handleError(res,err);}
        if(!extradata){return res.send(404);}
        var updated = _.merge(extradata, req.body);
        updated.save(function(err){
           if(err){return handleError(res,err);}
            return res.json(200, extradata);
        });
    });
    /*console.log(req.body);
    ExtraData.update(req.body, function(err,extradata){
        if(err) {return handleError(res,err);}
        return res.json(201,extradata);
    })*/
};

function handleError(res, err) {
    return res.send(500, err);
}