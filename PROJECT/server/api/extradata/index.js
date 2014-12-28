'use strict';

var express = require('express');
var controller = require('./extradata.controller');

var router = express.Router();

router.get('/', controller.index);
router.get('/findOne', controller.findByAccountId);

module.exports = router;