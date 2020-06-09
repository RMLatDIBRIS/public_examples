// generator of correct traces for iterators2.rml: multiple iterators, weak version

'use strict';

var trace_size = Number(process.argv[2]) || 100;
var max_it = Number(process.argv[3]) || 10;
var stack = [];
var event_counter=0;
var it;

function next(it){event_counter++;}
function hasNext(it){
	event_counter++;
	return  event_counter < trace_size; 
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
    for(it=0;it<max_it;it++)
	if(hasNext(it)) next(it); else break;
for(it=0;it<max_it;it++)
    hasNext(it)
for(it=0;it<max_it;it++)
    hasNext(it)
for(it=0;it<max_it;it++)
    free(it)
