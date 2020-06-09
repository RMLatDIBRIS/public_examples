// generator of correct traces for fifo-queues-no-rep.rml: single priority queue with no repetitions, enqueue and dequeue

'use strict';

function dequeue() {
    event_counter++;
    var el=queue.shift();
//    console.log('dequeue(' + el + ')');
    return el;
}

function enqueue(el) {
//    console.log('enqueue(' + el + ')');
    event_counter++;
    if(queue.includes(el))
	return;
    queue.push(el);
    queue.sort(function(a,b){return (a<b)?-1:(a===b)?0:1});
}

var trace_size = Number(process.argv[2]) || 100;
var max_size = Number(process.argv[3]) || Math.floor(trace_size/10);
var max_elem = 1000;
var queue = [];
var event_counter=1;
var elem;
while(event_counter<=trace_size){
    for(elem = max_size; elem >= 1; elem--) {
	enqueue(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	enqueue(elem);
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for (elem = 1; elem <= max_size; elem++) {
	dequeue();
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
