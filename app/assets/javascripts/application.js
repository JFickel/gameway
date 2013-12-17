// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require twitter/typeahead.min
//= require detect_timezone
//= require jquery.detect_timezone
//= require hogan.js
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require gameway
//= require_tree .

window.Gameway = Ember.Application.create({
  rootElement: '#tournament-show'
});

// record.set("tier", "bronze")
// record.set("points", 0)
// record.save().then(function() { Gameway.flash("Gameway", "You have been assigned to the Bronze league."); })

window.Gameway.Flasher = {
  // { message: <str>, cssClass: <str> }
  messages: [],

  message: function(message) {
    this.messages.pushObject({
      message: message,
      cssClass: "info"
    });
  }
};
