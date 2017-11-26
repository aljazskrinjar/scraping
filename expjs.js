var exec = require('child_process').exec

exec('ruby ./mix.rb "WITLOFT"', function (error, stdout, stderr) {
  console.log('stdout: ' + stdout);
  console.log('stderr: ' + stderr);
  console.log('error: ' + error);
});
