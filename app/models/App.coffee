#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @attributes.playerHand.on 'add', => @transmogrifyPlayer  @
    @attributes.dealerHand.on 'add', => @transmogrifyDealer @

  transmogrifyPlayer: ->
    if @attributes.playerHand.scores() >= 21
      popup = confirm("YOU ROOSE!")
      if popup then location.reload() else location.reload()
      return


  transmogrifyDealer: ->
    console.log("Dealer")
    if @attributes.dealerHand.scores() >= 21
        popup = confirm("WINRAR IS U!")
        if popup then location.reload() else location.reload()
        return
      else if @attributes.dealerHand.scores() > @attributes.playerHand.scores()
        popup = confirm("YOU ROOSE!")
        if popup then location.reload() else location.reload()
        return
      else
        popup = confirm("YOU VIN!")
        if popup then location.reload() else location.reload()

