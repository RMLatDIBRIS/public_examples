// generator of correct traces for msg.rml

'use strict';

function msg(id) {
    event_counter++;
    console.log('msg(' + id + ')');
}


var trace_size = Number(process.argv[2]) || 100;
var ids = Number(process.argv[3]) || 2;
var event_counter = 0;
var id;

while(event_counter<=trace_size){
    for(id=1; id<=ids; id++) {
	msg(id);
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
