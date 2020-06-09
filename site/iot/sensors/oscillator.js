// generator of correct traces for oscillator.rml: anomaly detection for a damped harmonic oscillator with a distance sensor 

'use strict';

function getOscillation(t){
    console.log(amplitude*(Math.exp(-zeta*omega0*t)*Math.sin(omega1*t+phase)));
    return amplitude*(Math.exp(-zeta*omega0*t)*Math.sin(omega1*t+phase));
}

function sensor(x) {
    event_counter++;
    var res = {position:getOscillation(x), time : x};
    return res;
}

var trace_size = Number(process.argv[2]) || 100;
var event_counter = 0;
var amplitude = 0.5;
var m=1;
var phase=0;
var k=5000;
var c=18.6*Math.pow(10,-6);
var e=Math.exp(1);
var zeta=c/(2*Math.sqrt(m*k));
var omega0=Math.sqrt(k/m);
var omega1=omega0*Math.sqrt(1-zeta*zeta);

// console.log(`e:${e}`);
// console.log(`c:${c}`);
// console.log(`zeta:${zeta}`);
// console.log(`omega0:${omega0}`);
// console.log(`omega1:${omega1}`);
while(event_counter<=trace_size){
    sensor(event_counter);
}
