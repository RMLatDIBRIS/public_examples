// generator of correct traces for push-pop-size-single.rml: single stack with push, pop and size

'use strict';

function mypop() {
    event_counter++;
    var el=stack.pop();
//    console.log('pop(' + el + ')');
    return el;
}

function mypush(el) {
    event_counter++;
//  console.log('push(' + el + ')');
    stack.push(el);
}

function size(){
    event_counter++;
    var s=stack.length;
//  console.log('size(' + s +')');
    return s;
}

var trace_size = process.argv[2] || 100;
var max_size = process.argv[3] || 100;
var max_elem = 1000;
var stack = [];
var event_counter=1;
var elem;

while(event_counter<=trace_size){
    for(elem = 1; elem <= max_size; elem++) {
	mypush(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	size();
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for (elem = 1; elem <= max_size; elem++) {
	mypop();
	if(event_counter>trace_size)
	    process.exit(0)
	size();
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
