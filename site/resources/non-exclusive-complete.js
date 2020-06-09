// generator of correct traces for non-exclusive-complete.rml: non-exclusive access to multiple resources, with entity identities tracked

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
var max_resources = Number(process.argv[3]) || 100;
var max_entities = Number(process.argv[4]) || 100;
var resId, entId;
var event_counter=1;

while(event_counter<=trace_size){
// nested entities 
    for(resId = 1; resId <= max_resources; resId++) {
	    for(entId = 1; entId <= max_entities; entId++) {
		acquire(entId,resId);
		if(event_counter>trace_size)
		    process.exit(0)
	    }
    }
    for (resId = max_resources; resId >0; resId--) {
	for (entId = max_entities; entId >0; entId--) {
	    use(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	    use(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	}
    }
    for (resId = max_resources; resId >0; resId--) {
	for (entId = max_entities; entId >0; entId--) {
	    release(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	}
    }
// nested resources
    for(entId = 1; entId <= max_entities; entId++) {
	for(resId = 1; resId <= max_resources; resId++) {
	    acquire(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	}
    }
    for (entId = max_entities; entId >0; entId--) {
	for (resId = max_resources; resId >0; resId--) {
	    use(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	    use(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	}
    }
    for (entId = max_entities; entId >0; entId--) {
	for (resId = max_resources; resId >0; resId--) {
	    release(entId,resId);
	    if(event_counter>trace_size)
		process.exit(0)
	}
    }
}
