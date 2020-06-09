// generator of correct traces for list-iterators.rml: multiple iterators for a single list, weak version

'use strict';

var trace_size = Number(process.argv[2]) || 100;
var max_it = Number(process.argv[3]) || 10;
var event_counter=0;
var it;

function next(it){event_counter++;}

function hasNext(it){
	event_counter++;
	return  event_counter < trace_size; 
}

function add(el){
	event_counter++;
}

function remove(el){
	event_counter++;
}

function iterator(){
    event_counter++;
    return it;
}

function free(id){
    event_counter++;
    return id;
}

for(it=0;it<max_it;it++)
    iterator();
while(event_counter < trace_size)
    for(it=0;it<max_it;it++){
	if(event_counter*2>trace_size){
	    add(42);
	    remove(42);
	}
	else if(hasNext(it)) next(it); else break;
    }
for(it=0;it<max_it;it++)
    free(it)

// second loop
event_counter=0

for(it=0;it<max_it;it++)
    iterator();
while(event_counter < trace_size)
    for(it=0;it<max_it;it++){
	if(event_counter*2>trace_size){
	    add(42);
	    remove(42);
	}
	else if(hasNext(it)) next(it); else break;
    }
for(it=0;it<max_it;it++)
    free(it)
