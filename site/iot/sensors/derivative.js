// generator of correct traces for derivative.rml: derivative anomaly detection for single or multiple sensors

'use strict';

function getRandom(min,max) {
    return min+Math.random()*(max-min);
}

function sensor(min,max,time) {
    event_counter++;
    var res = {value:getRandom(min,max), timestamp:time}; 
    // console.log('temp(' + JSON.stringify(res) + ')');
    return res;
}

var trace_size = Number(process.argv[2]) || 100;
var min = Number(process.argv[3]) || 22;
var max = Number(process.argv[4]) || 24;
var event_counter = 0;
var time = 0;
var delta = 1.5;
    
while(event_counter<=trace_size){
    time += delta;
    sensor(min,max,time);
}
