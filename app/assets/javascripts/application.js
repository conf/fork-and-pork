// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require 'moment'
//= require bootstrap-datetimepicker
//= require_tree .

$('.container').on('click', 'tr.add-meal button.close', function() {
    $(this).closest('tr.add-meal').prev('tr.hidden').andSelf().toggleClass('hidden');
});

$('.container').on('click', '.js-filter-form :reset', function(e) {
    e.preventDefault();

    this.form.reset();
    $(this.form).find(':submit').click();
});
