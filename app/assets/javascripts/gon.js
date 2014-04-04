function recursiveCamelizeObjectKeys(object) {
  var camelizedObject = {};
  Ember.keys(object).forEach(function(key,index) {
    if (typeof object[key] === "object" && object[key] !== null && object[key].constructor != Array) {
      camelizedObject[key.camelize()] = recursiveCamelizeObjectKeys(object[key])
    } else if (object[key] != null && object[key].constructor == Array){
      camelizedObject[key.camelize()] = camelizeArrayObjects(object[key])
    } else {
      camelizedObject[key.camelize()] = object[key]
    }
  })
  return camelizedObject
}

function camelizeArrayObjects(array) {
  var camelizedArrayObjects = array.map(function(item) {
    if (typeof item == "object" && typeof item != "null") {
      return recursiveCamelizeObjectKeys(item)
    } else {
      return item
    }
  })
  return camelizedArrayObjects
}

var camelizedGon = recursiveCamelizeObjectKeys(gon);

Gameway.Gon = Ember.Object.extend(camelizedGon)

Gameway.gon = Gameway.Gon.create()
