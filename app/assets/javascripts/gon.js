var camelizedGon = {};

Ember.keys(gon).forEach(function(item, index) {
  camelizedGon[item.camelize()] = gon[item];
})

Gameway.Gon = Ember.Object.extend(camelizedGon)

Gameway.gon = Gameway.Gon.create()
