// generator of correct traces for list21-random-queue.rml: single random queue with queue and dequeue

'use strict';

function getRandom(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

function dequeue() {
    event_counter++;
    var el=queue.pop();
    //console.log('dequeue(' + el + ')');
    return el;
}

function enqueue(el) {
    event_counter++;
    //console.log('enqueue(' + el + ')');
    queue.splice(getRandom(queue.length+1),0,el);
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
    }
    for (elem = 1; elem <= max_size; elem++) {
	dequeue();
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
