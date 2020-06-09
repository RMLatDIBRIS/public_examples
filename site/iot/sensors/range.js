// generator of correct traces for range.rml: temperature range anomaly detection for single or multiple sensors

'use strict';

function getRandom(min,max) {
    return min+Math.random()*(max-min);
}

function sensor(min,max) {
    event_counter++;
    var res = {value:getRandom(min,max)}; 
    //console.log('temp(' + res + ')');
    return res;
}

var trace_size = Number(process.argv[2]) || 100;
var min = Number(process.argv[3]) || 22;
var max = Number(process.argv[4]) || 24;
var event_counter = 0;

while(event_counter<=trace_size){
    sensor(min,max);
}
