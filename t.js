var s1 = {rate: 0.105, max: 14};
var s2 = {rate: 0.175, max: 48};
var s3 = {rate: 0.3, max: 70};
var s4 = {rate: 0.33, max: 100000};

var sal = 120;

var tax = s1.max * s1.rate +
    (s2.max - s1.max) * s2.rate +
    (s3.max - s2.max) * s3.rate +
    (sal - s3.max) * s4.rate;

console.log('TAX: ' + tax);
console.log('TAX %', (tax * 100 / sal).toFixed(2));
