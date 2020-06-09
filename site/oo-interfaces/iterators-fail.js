// generator of correct traces for iterators.rml: multiple iterators, strong version
// use real objects but cannot be monitored because targetId not tracked in func_post

'use strict';

var trace_size = Number(process.argv[2]) || 100;
var max_it = Number(process.argv[3]) || 10;
var stack = [];
var event_counter=0;
var it;
var iterators = new Array(max_it);

function It(){}
It.prototype.next=function(){event_counter++;}
It.prototype.hasNext=function(){
	event_counter++;
	return  event_counter < trace_size; 
}

function iterator(){
    event_counter++;
    return new It();
}

for(it=0;it<max_it;it++)
    iterators[it]=iterator();
while(event_counter < trace_size)
    for(it=0;it<max_it;it++)
	if(iterators[it].hasNext())
	    iterators[it].next()
