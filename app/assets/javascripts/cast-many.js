(function() {
  DS.Model.reopenClass({
    createDetached: function(container, store, data) {
      "astralfoxy's mega hack for gameway"
      var record = this._create();
      record.store = store;
      record.container = container;
      record._data = data || {};
      record.loadedData();
      return record;
    }
  });

  DS.castManyMany = function(type) {
    return function(key, newValue) {
      // this is an array containing more arrays
      var outer = this.get("data")[key];
      if (outer == null)
        return outer;

      var _this = this;
      var typeClass = this.store.modelFor(type);
      return outer.map(function(inner) {
        if (inner == null)
          return inner;

        return inner.map(function(item) {
          return typeClass.createDetached(_this.container, _this.store, item);
        })
      })
    }.property("data");
  };
})();
