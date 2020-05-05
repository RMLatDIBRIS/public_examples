// generator of correct traces for list12-exclusive.rml: exclusive access to multiple resources, with entity identities tracked

'use strict';

function acquire(entId,resId) {
    event_counter++;
//  console.log('acquire(' + entId + ',' + resId + ')');
    return resId;
}

function use(entId,resId) {
    event_counter++;
//  console.log('use(' + entId + ',' + resId + ')');
}

function release(entId,resId) {
    event_counter++;
//  console.log('release(' + entId + ',' + resId + ')');
}

var trace_size = Number(process.argv[2]) || 100;
var max_res = Number(process.argv[3]) || 100;
var entId = 0;
var resId = 42;
var event_counter=1;

while(event_counter<=trace_size){
    for(resId = 1; resId <= max_res; resId++) {
	acquire(entId,resId);
	if(event_counter>trace_size)
	    process.exit(0)
	use(entId,resId);
	if(event_counter>trace_size)
	    process.exit(0)
	release(entId,resId);
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for(resId = 1; resId <= max_res; resId++) 
	acquire(entId,resId);
    for(resId = 1; resId <= max_res; resId++) 
	use(entId,resId);
    for(resId = 1; resId <= max_res; resId++) 
	release(entId,resId);
}

