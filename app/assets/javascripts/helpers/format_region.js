Ember.Handlebars.helper("formatRegion", function(region) {
  var regions = {
    br: 'Brazil',
    eune: 'EU Nordic & East',
    euw: 'EU West',
    lan: 'Latin America North',
    las: 'Latin America South',
    na: 'North America',
    oce: 'Oceania',
  }
  return regions[region]
});
