// generator of correct traces for data-val.rml: shows that monitors can implicitly manage objects and arrays as data values

'use strict';

function output() {
    return out_val;
}

function input(val) {
}

var out_val=[{x:1,y:2},{w:0,z:1}];
var in_val=[{y:2,x:1},{z:1,w:0}];

output();
input(in_val);
