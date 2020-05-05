// generator of correct traces for list16-stack-size-multiple.rml: multiple stacks with push, pop and size

'use strict';

// Stack objects
function Stack(){Array.apply(this,arguments)}
Object.setPrototypeOf(Stack.prototype,Array.prototype);
Stack.prototype.size=function(){return this.length}

function create(id){
    if(id===undefined)
	id=stacks.length;
    mynew(id);
    mysize(id);
    return id;
}

function myfree(id){
    event_counter++;
    //console.log('free('+id+')');
}

function mynew(id){
    event_counter++;
    stacks[id]=new Stack();
    //console.log('new('+id+')');
    return id;
}

function dealloc(id){
    if(!(id in stacks))
	return;
    while(stacks[id].length)
	popsize(id);
    delete stacks[id];
    myfree(id);
}

function mypop(id) {
    event_counter++;
    var el=stacks[id].pop();
    //console.log('pop(' + id + ',' + el + ')');
    return el;
}

function mypush(id,el) {
    event_counter++;
    //console.log('push(' + id + ',' + el + ')');
    stacks[id].push(el);
}

function popsize(id) {
    mypop(id);
    mysize(id);
}

function pushsize(id,el) {
    mypush(id,el);
    mysize(id);
}

function mysize(id){
    event_counter++;
    var s=stacks[id].size();
    //console.log('size(' + id + ',' + s +')');
    return s;
}

var trace_size = Number(process.argv[2]) || 100;
var max_size =  Math.floor(Math.sqrt(Number(process.argv[3]))) || Math.floor(Math.sqrt(trace_size));
var max_stacks = max_size;
var max_elem = 1000;
var stacks = [];
var event_counter=1;
var elem;
var id;

while(event_counter<=trace_size){
    for(id=1;id<=max_stacks;id++){
	mynew(id);
	for(elem = 1; elem <= max_size; elem++) {
	    mypush(id,elem);
	    if(event_counter>trace_size)
		process.exit(0)
	    mysize(id);
	    if(event_counter>trace_size)
		process.exit(0)
	}
    }
    for(id=1;id<=max_stacks;id++){
	for (elem = 1; elem <= max_size; elem++) {
	    mypop(id);
	    if(event_counter>trace_size)
		process.exit(0)
	    mysize(id);
	    if(event_counter>trace_size)
		process.exit(0)
	}
	myfree(id);
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
