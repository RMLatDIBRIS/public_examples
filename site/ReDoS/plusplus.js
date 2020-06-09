// generator of correct traces for plusplus.rml 

'use strict';

function a() {
    event_counter++;
}


var trace_size = Number(process.argv[2]) || 100;
var event_counter=1;

while(event_counter<=trace_size)
    a()
