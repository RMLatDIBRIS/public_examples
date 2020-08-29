'use strict';

// Returns an integer between 0 and max (not included)
function getRandomInt(max) {
	return Math.floor(Math.random() * Math.floor(max));
}

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
	return list[index];
}

var trace_size = process.argv[2] || 100;
var max_size = process.argv[3] || 100;
var max_elem = 1000;
var list= [];
var event_counter=1;
var elem;

while(event_counter<=trace_size){
    for(elem = 1; elem <= max_size; elem++) {
		my_insert(getRandomInt(my_size() + 1),elem);
    }
    for (elem = 1; elem <= max_size; elem++) {
		my_remove(getRandomInt(my_size()));
    }
}