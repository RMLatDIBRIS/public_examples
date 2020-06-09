// generator of correct traces for alt-bit.rml and alt-bit-gen.rml: alternating bit protocol with arbitrary message types

'use strict';

function msg(id) {
    event_counter++;
    // console.log('msg(' + id + ')');
}

function ack(id) {
    event_counter++;
    // console.log('ack(' + id + ')');
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
    while(true)
	for(id=1; id<=ids; id++) {
	    ack(id);
	    if(event_counter>trace_size)
		process.exit(0)
	    msg(id);
	    if(event_counter>trace_size)
		process.exit(0)
    }
}
