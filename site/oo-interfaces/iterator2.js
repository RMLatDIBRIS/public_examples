// generator of correct traces for iterator2.rml: single iterator, weak version

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

while (hasNext()){
    hasNext()
    next()
}
hasNext()
