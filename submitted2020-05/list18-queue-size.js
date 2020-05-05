// generator of correct traces for list18-queue-trace.rml: single FIFO queue with queue, dequeue and size

'use strict';

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

function size(){
    event_counter++;
    var l=queue.length;
//  console.log('size(' + s +')');
    return l;
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
	size()
	if(event_counter>trace_size)
	    process.exit(0)	
    }
    for (elem = 1; elem <= max_size; elem++) {
	dequeue();
	if(event_counter>trace_size)
	    process.exit(0)
		size()
	if(event_counter>trace_size)
	    process.exit(0)	
    }
}
