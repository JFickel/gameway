Gameway.UserEditController = Gameway.Controller.extend({
  summonerName: '',
  oldPassword: '',
  newPassword: '',
  newPasswordConfirmation: '',
  verifyStep: false,
  summonerId: '',

  hasSummonerNameError: false,
  hasOldPasswordError: false,
  hasNewPasswordError: false,
  hasNewPasswordConfirmationError: false,

  summonerNameErrors: [],
  oldPasswordErrors: [],
  newPasswordErrors: [],
  newPasswordConfirmationErrors: [],

  regions: [
    { label: 'Brazil', value: 'br' },
    { label: 'EU Nordic & East', value: 'eune' },
    { label: 'EU West',  value: 'euw' },
    { label: 'Latin America North', value: 'lan' },
    { label: 'Latin America South', value: 'las' },
    { label: 'North America', value: 'na' },
    { label: 'Oceania', value: 'oce' }
  ],

  generateCode: function makeid() {
    var text = "";
    var possible = "ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz";

    for(var i=0; i < 5; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
  }.property(),
  verificationCode: '',
  selectedRegion: 'na',
  selectedRegionLabel: '',

  actions: {
    // debug: function() {
    //   debugger;
    // },
    verifySummonerName: function() {
      var thisController = this;
      this.send('openModal', 'modals/processing');
      window.setTimeout(function(){
        $.ajax({
          type: 'POST',
          url: 'lol_accounts',
          data: { authenticity_token: Gameway.gon.get('authenticityToken') ,
                  verification_code: thisController.get('verificationCode'),
                  lol_account: {
                    region: thisController.get('selectedRegion'),
                    summoner_name: thisController.get('summonerName'),
                    summoner_id: thisController.get('summonerId'),
                    user_id: thisController.get('currentUser.id')
                  }
                },
          success: function(data) {
            thisController.send('closeModal');
            if (data.errors) {
              data.errors.forEach(function(error){
                Gameway.flashController.pushObject({message: error,
                                                    type: 'alert-danger'});
              })
            } else {
              Gameway.flashController.pushObject({message: 'success :3',
                                                  type: 'alert-success'});
            }
          }
        })
      }, 3500);
    },
    addSummonerName: function() {
      this.send('openModal', 'modals/processing');
      var thisController = this;
      $.ajax({
        type: 'GET',
        url: 'lol_accounts/new',
        data: { authenticity_token: Gameway.gon.get('authenticityToken'),
                lol_account: {
                  region: thisController.get('selectedRegion'),
                  summoner_name: thisController.get('summonerName')
                }
              },
        success: function(data) {
          if (data.errors) {
            thisController.set('hasSummonerNameError', true);
            thisController.set('summonerNameErrors', data.errors)
          } else {
            thisController.send('closeModal');
            thisController.set('verificationCode', thisController.get('generateCode'))
            thisController.set('summonerId', data.summoner_id);
            thisController.set('summonerName', data.summoner_name);
            thisController.set('selectedRegionLabel', thisController.get('regions').findBy('value', thisController.get('selectedRegion')).label);
            thisController.set('verifyStep', true);
            // Gameway.flashController.pushObject({message:  message, type: 'alert-success'});
          }
        }
      })
    },
    updatePassword: function() {
      var thisController = this;
      $.ajax({
        type: 'PATCH',
        url: 'users/password',
        data: { authenticity_token: Gameway.gon.get('authenticityToken'),
                id: Gameway.gon.get('currentUser.id'),
                user: {
                  current_password: thisController.get('oldPassword'),
                  password: thisController.get('newPassword'),
                  password_confirmation: thisController.get('newPasswordConfirmation')
                }
              },
        success: function(data) {
          if (data.errors) {
            if (data.errors.password) {
              thisController.set('hasNewPasswordError', true);
              thisController.set('newPasswordErrors', data.errors.password);
            }
            else if (data.errors.password_confirmation) {
              thisController.set('hasNewPasswordConfirmationError', true);
              thisController.set('newPasswordConfirmationErrors', data.errors.password_confirmation);
            }
            else if (data.errors.current_password) {
              thisController.set('hasOldPasswordError', true);
              thisController.set('oldPasswordErrors', data.errors.current_password);
            }
          } else {
            Gameway.gon.set('authenticityToken', data.authenticity_token);
            Gameway.flashController.pushObject({message: "Password successfully changed.",
                                                type: 'alert-success'});
          }
        }
      })
    }
  }
})
