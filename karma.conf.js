// Karma configuration
// Generated on Sun Mar 24 2013 17:33:37 GMT-1000 (HST)


// base path, that will be used to resolve files and exclude
basePath = '';


// list of files / patterns to load in the browser
files = [
  QUNIT,
  QUNIT_ADAPTER,

  // JASMINE,
  // JASMINE_ADAPTER,


  // 'vendor/matchers.js',

  // current defaults when using jasmine
  // 'vendor/jasmine-matchers-1.1.0.js',
  // 'vendor/my-matchers.js',
  // 'vendor/jasmine-given.js',
  // 'vendor/jquery-1.9.1.js',
  // 'vendor/jasmine-jquery.js',

  // 'vendor/sinon-1.6.0.js',
  // 'vendor/jasmine-sinon.js',


  'public/lib/tdd.js',
  'public/lib/*.js',
  'public/src/*.js',
  'public/test/test_helpers.js',
  'public/test/*.js'

  // to use source maps, use coffeescript compiler
  // `coffee -o public/ -cwbl coffee/`
  // 'js/app.js',
  // 'js/test.js'
];


// list of files to exclude
exclude = [

];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress', 'growl'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = [
  'Chrome'
  // 'ChromeCanary',
  // 'Firefox',
  // 'Opera',
  // 'Safari', // it opens more than one tab which is annoying on start
  // 'PhantomJS'
  // IE works if you open a vm and point IE at machost.local:9876
];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
