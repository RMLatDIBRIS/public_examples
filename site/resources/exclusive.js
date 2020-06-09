// generator of correct traces for exclusive.rml: non-exclusive access to multiple resources, with entity identities tracked

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
var max_entities = Number(process.argv[3]) || 100;
var entId;
var resId = 42;
var event_counter=1;

while(event_counter<=trace_size){
    for(entId = 1; entId <= max_entities; entId++) {
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
    for(entId = 1; entId <= max_entities; entId++) {
	acquire(entId,entId);
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for(entId = 1; entId <= max_entities; entId++) {
	use(entId,entId);
	if(event_counter>trace_size)
	    process.exit(0)
    }
    for(entId = 1; entId <= max_entities; entId++) {
	release(entId,entId);
	if(event_counter>trace_size)
	    process.exit(0)
    }
}

