// generator of correct traces for add-delete-size-single.rml: single set with add, delete and size

'use strict';

function myadd(el) {
    event_counter++;
    var res=!set.has(el);
    //console.log('add(' + el + ',' + res + ')');
    set.add(el);
    return res;
}

function mydelete(el) {
    event_counter++;
    var res=set.delete(el);
    //console.log('delete(' + el + ',' + res + ')');
    return res;
}

function size(){
    event_counter++;
    var res=set.size;
    //console.log('size(' + res + ')');
    return res;
}

var trace_size = Number(process.argv[2]) || 100;
var max_set_size = Number(process.argv[3]) || 100;
var set=new Set();
var event_counter=1;
var elem;

while(event_counter<=trace_size){
    for(elem = 1; elem <= max_set_size; elem++) {
	myadd(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	size();
	if(event_counter>trace_size)
	    process.exit(0)	
	myadd(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	size();
	if(event_counter>trace_size)
	    process.exit(0)		
    }
    for (elem = max_set_size; elem >0; elem--) {
	mydelete(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	size();
	if(event_counter>trace_size)
	    process.exit(0)	
	mydelete(elem);
	if(event_counter>trace_size)
	    process.exit(0)
	size();
	if(event_counter>trace_size)
	    process.exit(0)	
    }
}
