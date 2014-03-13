Ember.TEMPLATES["application"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', stack1, helper, options, self=this, helperMissing=helpers.helperMissing;

function program1(depth0,data) {
  
  
  data.buffer.push("<a href>Tournaments</a>");
  }

  data.buffer.push("<nav class=\"navbar navbar-default\" role=\"navigation\">\n  <div class=\"container-fluid\">\n    <!-- Brand and toggle get grouped for better mobile display -->\n    <div class=\"navbar-header\">\n      <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\">\n        <span class=\"sr-only\">Toggle navigation</span>\n        <span class=\"icon-bar\"></span>\n        <span class=\"icon-bar\"></span>\n        <span class=\"icon-bar\"></span>\n      </button>\n      <a class=\"navbar-brand\" href=\"#\">Gameway</a>\n    </div>\n\n    <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\n      <ul class=\"nav navbar-nav\" padding-left=\"20px\">\n        ");
  stack1 = (helper = helpers['link-to'] || (depth0 && depth0['link-to']),options={hash:{
    'tagName': ("li")
  },hashTypes:{'tagName': "STRING"},hashContexts:{'tagName': depth0},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0],types:["STRING"],data:data},helper ? helper.call(depth0, "tournaments", options) : helperMissing.call(depth0, "link-to", "tournaments", options));
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n        <li><a href=\"#\">Teams</a></li>\n      </ul>\n\n      <ul class=\"nav navbar-nav navbar-right\">\n        <li><a href=\"#\">Forgot password?</a></li>\n        <li><a href=\"#\">Sign Up</a></li>\n      </ul>\n\n      <form class=\"navbar-form navbar-right\" role=\"login\">\n        <div class=\"form-group\">\n          <input type=\"text\" class=\"form-control\" placeholder=\"Email\">\n          <input type=\"password\" class=\"form-control\" placeholder=\"Password\">\n        </div>\n        <button type=\"submit\" class=\"btn btn-default\">Log In</button>\n      </form>\n\n<!--       <ul class=\"nav navbar-nav navbar-right\">\n        <li padding-right='10px'><img src=\"http://ttv-api.s3.amazonaws.com/assets/connect_dark.png\"></li>\n      </ul> -->\n    </div><!-- /.navbar-collapse -->\n  </div><!-- /.container-fluid -->\n</nav>\n\n<h1>");
  stack1 = helpers._triageMustache.call(depth0, "appName", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("</h1>\n\n<div>");
  stack1 = helpers._triageMustache.call(depth0, "outlet", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("</div>\n\n\n\n<div style=\"width: 600px; border: 6px solid #eee; margin: 0 auto; padding: 20px; text-align: center; font-family: sans-serif;\">\n  <img src=\"http://emberjs.com/images/about/ember-productivity-sm.png\" style=\"display: block; margin: 0 auto;\">\n  <h1>Welcome to Ember.js!</h1>\n  <p>You're running an Ember.js app on top of Ruby on Rails. To get started, replace this content\n  (inside <code>app/assets/javascripts/templates/application.handlebars</code>) with your application's\n  HTML.</p>\n</div>\n");
  return buffer;
  
});
