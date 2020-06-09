// generator of correct traces for random-queues-norep-peek.rml: single random queue with no repetitions, queue, dequeue and peek

'use strict';

function getRandom(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

function dequeue() {
    event_counter++;
    var i=to_peek===undefined?getRandom(queue.length):to_peek;
    var el=queue[i];
//    console.log('dequeue(' + el + ')');
    queue.splice(i,1);
    to_peek=undefined;
    return el;
}

function enqueue(el) {
    event_counter++;
//    console.log('enqueue(' + el + ')');
    if(queue.includes(el))
	return;
    queue.push(el);
}

function peek() {
    event_counter++;
    if(to_peek===undefined)
	to_peek=getRandom(queue.length);
    var el=queue[to_peek];
//    console.log('peek(' + el + ')');
    return el;
}

var trace_size = Number(process.argv[2]) || 100;
var max_size = Number(process.argv[3]) || Math.floor(trace_size/10);
var max_elem = 1000;
var queue = [];
var to_peek;
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
