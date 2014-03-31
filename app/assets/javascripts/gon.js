function recursiveCamelizeObjectKeys(object) {
  var camelizedObject = {};
  Ember.keys(object).forEach(function(key,index) {
    if (typeof object[key] === "object" && object[key] !== null) {
      camelizedObject[key.camelize()] = recursiveCamelizeObjectKeys(object[key])
    } else {
      camelizedObject[key.camelize()] = object[key]
    }
  })
  return camelizedObject
}

var camelizedGon = recursiveCamelizeObjectKeys(gon);

Gameway.Gon = Ember.Object.extend(camelizedGon)

Gameway.gon = Gameway.Gon.create()
