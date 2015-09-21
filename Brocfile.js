var compileCoffeeScript = require('broccoli-coffee');
var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');
var browserify = require('broccoli-browserify');
var compileSass = require('broccoli-sass');

var js = compileCoffeeScript('src/coffee');
var js = browserify(js, {
  entries: ['./index.js'],
  outputFile: './bundle.js'
});

js = pickFiles(js, {
  srcDir: '/',
  destDir: 'js'
});

var css = compileSass(['src/sass'], '/index.sass', '/css/index.css');

var index = pickFiles('public', {
  srcDir: '/',
  destDir: '/'
});

module.exports = mergeTrees([js, index, css]);
