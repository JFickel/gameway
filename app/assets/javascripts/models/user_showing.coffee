Gameway.UserShowing = DS.Model.extend(
  top: DS.attr('boolean')
  match: DS.belongsTo('match')
  user: DS.belongsTo('user')
)

