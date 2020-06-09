// generator of correct traces for curiosity-rover.rml: speed control of Curiosity rover

'use strict';

function getRandom(min,max) {
    return min+Math.random()*(max-min);
}

function command(com) {
    event_counter++;
    //console.log(com);
}

var trace_size = Number(process.argv[2]) || 100;
var event_counter = 0;

while(event_counter<=trace_size){
    command({topic:'wheels_control',direction:'left',speed:10})
    command({topic:'wheels_control',direction:'right',speed:10})
    command({topic:'wheels_control',direction:'forward',speed:10})
    command({topic:'wheels_control',direction:'backward',speed:10})
}
