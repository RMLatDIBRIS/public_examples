// generator of correct traces for abp$n.rml: alternating bit protocol with two message types

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

while(event_counter<trace_size)
    for(id=1; id<=ids; id++) {
	msg(id);
	ack(id);
    }


