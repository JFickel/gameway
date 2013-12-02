# http://emberjs.com/guides/models/using-the-store/

Gameway.Store = DS.Store.extend
  # Override the default adapter with the `` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: '_ams'
  # adapter: DS.ActiveModelAdapter.create()
