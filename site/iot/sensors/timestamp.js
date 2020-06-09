// generator of correct traces for timestamp.rml: timestamp anomaly detection for single or multiple sensors

'use strict';

function sensor() {
    event_counter++;
    time+=0.1;
    var res={value:Math.random(),timestamp:time}
    // console.log('sensor(' + JSON.stringify(res) + ')');
    return res;
}

var trace_size = Number(process.argv[2]) || 100;
var time=0;
var event_counter = 0;

while(event_counter<=trace_size){
    sensor();
}
