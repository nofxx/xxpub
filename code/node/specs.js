// require.paths.push("./lib");
require('coffee-script');
var jasmine = require('jasmine-node');
var sys = require('sys');

var target = "";

if(process.argv[2]) {
  if(!require('fs').statSync(process.argv[2]).isFile()) {
    target = process.argv[2];
  } else {
    target = __dirname + "/../" + process.argv[2];
  }
} else {
  target = process.cwd() + '/spec';
}

jasmine.executeSpecsInFolder(target, function(runner, log){
  process.exit(runner.results().failedCount);
}, false, true, "_spec.coffee$");

/*
for(var key in jasmine) {
  global[key] = jasmine[key];
}

var isVerbose = false;
var showColors = true;
process.argv.forEach(function(arg){
  switch(arg) {
  case '--color': showColors = true; break;
  case '--noColor': showColors = false; break;
  case '--verbose': isVerbose = true; break;
  }
});


jasmine.executeSpecsInFolder(__dirname + '/spec', function(runner, log){
  if (runner.results().failedCount == 0) {
    process.exit(0);
  } else {
    process.exit(1);
  }
}, isVerbose, showColors);*/

