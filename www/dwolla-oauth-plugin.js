//
// DwollaOauth.js
//
// Created by Calvin Lai on  2013-08-11.
// Copyright 2013 Calvin Lai. All rights reserved.

var cordova = require('cordova'),
    exec = require('cordova/exec');

var DwollaOauth = function() {
  // constructor
};

// Call this to register for push notifications and retreive a deviceToken
DwollaOauth.prototype.compose = function(options, success, error) {
  if (arguments.length == 2) {
    error = function(err) { console.log(err); };
  }
  cordova.exec(success, error, "DwollaOauth", "login", options ? [options] : []);
};

var dwollaOauth = new DwollaOauth();

module.exports = dwollaOauth;
