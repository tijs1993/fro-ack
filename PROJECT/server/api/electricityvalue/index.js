'use strict';

var express = require('express');
var controller = require('./electricityvalue.controller');

var router = express.Router();

router.get('/', controller.index);
router.get('/:id', controller.findByAccountId);
router.post('/', controller.create);

module.exports = router;