// generator of correct traces for lists-iterators.rml: multiple iterators for multiple lists, weak version

'use strict';

var trace_size = Number(process.argv[2]) || 100;
var max_ls = Number(process.argv[3]) || 10;
var max_it = Number(process.argv[4]) || 10;
var event_counter=0;
var ls;
var it;

function next(it){event_counter++;}

function hasNext(it){
	event_counter++;
	return  event_counter < trace_size; 
}

function add(id,el){
	event_counter++;
}

function remove(id,el){
	event_counter++;
}

function iterator(id){
    event_counter++;
    return it;
}

function free(id){
    event_counter++;
    return id;
}


for(ls=max_it;ls<max_ls+max_it;ls++){
    for(it=0;it<max_it;it++)
	iterator(ls);
    while(event_counter < trace_size)
	for(it=0;it<max_it;it++){
	    if(event_counter*2>trace_size){
		add(ls,42);
		remove(ls,42);
	    }
	    else if(hasNext(it)) next(it); else break;
	}
    for(it=0;it<max_it;it++)
	free(it)
}
// second loop
event_counter=0

for(ls=max_it;ls<max_ls+max_it;ls++){
    for(it=0;it<max_it;it++)
	iterator(ls);
    while(event_counter < trace_size)
	for(it=0;it<max_it;it++){
	    if(event_counter*2>trace_size){
		add(ls,42);
		remove(ls,42);
	    }
	    else if(hasNext(it)) next(it); else break;
	}
    for(it=0;it<max_it;it++)
	free(it)
}
