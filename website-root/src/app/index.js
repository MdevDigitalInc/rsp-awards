// [ Moreira Development -----------------/
//
// HTML 5 Boilerplate - This html 5 boilerplate
// is to be used for the creation of WordPress
// themes and static websites for clients.
//
// [ Entry File ] -----------------------/
//
// All of the imports and requires added here
// will be compiled into a bundle specific for this page


// Javascript
import index from '../js/js_index.js';

// Stylesheets
require('../styles/global-main.scss');

// Images
function requireAll(r) { r.keys().forEach(r); }
requireAll(require.context('../img/', true, /\.*$/));

// Code to run
window.jQuery = window.$ = require('jquery');
window.console.log('Mdev-v1.0');
