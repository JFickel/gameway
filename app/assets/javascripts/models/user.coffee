Gameway.User = DS.Model.extend(
  username: DS.attr()
  first_name: DS.attr()
  last_name: DS.attr()
  full_name: DS.attr()
  avatar_url: DS.attr()
  user_url: DS.attr()
  lol_account: DS.attr()
  starcraft2_account: DS.attr()
)

Gameway.Broadcaster = Gameway.User.extend()

Gameway.Moderator = Gameway.User.extend()
