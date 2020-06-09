// generator of correct traces for non-exclusive-simple.rml: non-exclusive access to multiple resources, ident of entities accessing the resources are not tracked

'use strict';

function acquire(resId) {
    event_counter++;
//    console.log('acquire(' + resId + ')');
    return resId;
}

function use(resId) {
    event_counter++;
//    console.log('use(' + resId + ')');
}

function release(resId) {
    event_counter++;
//    console.log('release(' + resId + ')');
}

var trace_size = Number(process.argv[2]) || 100;
var max_resources = Number(process.argv[3]) || 100;
var resId;
var event_counter=1;

while(event_counter<=trace_size){
    for(resId = 1; resId <= max_resources; resId++) {
	acquire(resId);
	if(event_counter>trace_size)
	    process.exit(0)
	acquire(resId);
	if(event_counter>trace_size)
	    process.exit(0)	
    }
    for (resId = max_resources; resId >0; resId--) {
	use(resId);
	if(event_counter>trace_size)
	    process.exit(0)
	use(resId);
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for (resId = max_resources; resId >0; resId--) {
	release(resId);
	if(event_counter>trace_size)
	    process.exit(0)
	release(resId);
	if(event_counter>trace_size)
	    process.exit(0)
    }
}
