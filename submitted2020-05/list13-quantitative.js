// generator of correct traces for list13-quantitative.rml: quantitative use of resources 

'use strict';

function available() {
    event_counter++;
//    console.log('available(' + total + ')');
    return total;
}

function use(used) {
    if(used<=total)
	total-=used;
    event_counter++;
//    console.log('use(' + used + ')');
}

var trace_size = Number(process.argv[2]) || 100;
var total = Number(process.argv[3]) || 100;
var used = total/trace_size;
var event_counter=1;

available();
while(used<=total)
    use(used);


