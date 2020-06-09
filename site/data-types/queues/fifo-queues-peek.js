// generator of correct traces for fifo-queues-peek.rml: single FIFO queue with queue, dequeue and peek

'use strict';

function peek(el) {
    event_counter++;
    var el=queue[queue.length-1];
    //console.log('peek(' + el + ')');
    return el;
}

function dequeue() {
    event_counter++;
    var el=queue.pop();
    //console.log('dequeue(' + el + ')');
    return el;
}

function enqueue(el) {
    //console.log('enqueue(' + el + ')');
    event_counter++;
    queue.unshift(el);
}

var trace_size = Number(process.argv[2]) || 100;
var max_size = Number(process.argv[3]) || Math.floor(trace_size/10);
var max_elem = 1000;
var queue = [];
var event_counter=1;
var elem;
while(event_counter<=trace_size){
    for(elem = 1; elem <= max_size; elem++) {
	enqueue(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	peek(elem);
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for (elem = 1; elem <= max_size; elem++) {
	peek(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	dequeue();
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
