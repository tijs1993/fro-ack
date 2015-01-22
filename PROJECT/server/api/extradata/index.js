'use strict';

var express = require('express');
var controller = require('./extradata.controller');

var router = express.Router();

router.get('/', controller.index);
router.get('/:id', controller.findByAccountId);
router.post('/', controller.create);
router.put('/update', controller.update);

module.exports = router;