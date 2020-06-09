// generator of correct traces for mlcom.rml: multi-line C comments

'use strict';

function star() {event_counter++}

function slash() {event_counter++}

function other() {event_counter++}

var trace_size = Number(process.argv[2]) || 100
var event_counter = 0
var limit = trace_size / 10
var i

slash()
star()
while(event_counter<=trace_size){
    for(i=0;i<limit;i++)
	slash();
    for(i=0;i<limit;i++)
	star();
    for(i=0;i<limit;i++)
	other();    
}
star()
slash()
