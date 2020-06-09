// generator of correct traces for iterators.rml: multiple iterators, strong version

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

for(it=0;it<max_it;it++)
    iterator();
while(event_counter < trace_size)
    for(it=0;it<max_it;it++)
	if(hasNext(it)) next(it); else break;
var it2=it
for(it=0;it<max_it;it++)
    if(it!=it2) hasNext(it)
