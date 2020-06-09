// generator of correct traces for iterator.rml: single iterator, strong version

'use strict';

var trace_size = Number(process.argv[2]) || 100;
var stack = [];
var event_counter=0;

function next(){
    event_counter++;
}

function hasNext(){
    event_counter++;
    return  event_counter < trace_size; 
}

while (hasNext())
    next()
