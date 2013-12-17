Gameway.TeamShowing = DS.Model.extend(
  top: DS.attr('boolean')
  match: DS.belongsTo('match')
  team: DS.belongsTo('team')
)

