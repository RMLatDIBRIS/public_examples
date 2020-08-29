'use strict';

function my_insert(index,element) {
    event_counter++;
    list.splice(index, 0, element);
}

function my_remove(index) {
	event_counter++;
	var del = list.splice(index,1);
	return del[0];
}

function my_size() {
    event_counter++;
    var s=list.length;
    return s;
}

function my_get(index) {
	event_counter++;
	var s = list[index];
	return s;
}

var trace_size = process.argv[2] || 100;
var max_size = process.argv[3] || 20;
var max_elem = 1000;
var list= [];
var event_counter=1;
var elem;
var bit;
var sz;

while(event_counter<=trace_size){
	bit = 0;
    for(elem = 1; elem <= max_size; elem++) {
		sz = my_size();
		if (bit==0){
			my_insert(0,elem);
			bit++;
		} else if (bit==1){
			my_insert(sz,elem);
			bit++;
		} else {
			my_insert(Math.floor(sz/2),elem);
			bit=0;
		}
		for (i = 0; i <= sz; i++){
			my_get(i);
		}
    }
	bit=0;
    for (elem = 1; elem <= max_size; elem++) {
		sz = my_size();
		if (bit==0){
			my_remove(0);
			bit++;
		} else if (bit==1){
			my_remove(sz-1);
			bit++;
		} else {
			my_remove(Math.floor(sz/2));
			bit=0;
		}
		for (i = 0; i < sz-1; i++){
			my_get(i);
		}
    }
}