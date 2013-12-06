#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @attributes.playerHand.on 'add', => @transmogrifyPlayer  @
    @attributes.dealerHand.on 'change', => @transmogrifyDealer @
    console.log(@)


  transmogrifyPlayer: ->
    if @attributes.playerHand.scores() >= 21
      popup = confirm("YOU ROOSE!")
      if popup then location.reload() else location.reload()
      return


  transmogrifyDealer: ->
    #Write an ace checker function and then look at Hand.coffee for soft bust 
    playerScore = @hiLow(@attributes.playerHand.scores())
    dealerScore = @attributes.dealerHand.scores()
    while dealerScore < 17 and dealerScore < playerScore
      @attributes.dealerHand.add(@attributes.deck.pop()).last()
      dealerScore = @hiLow(@attributes.dealerHand.scores())

    if dealerScore >= 21
        popup = confirm("WINRAR IS U!")
        if popup then location.reload() else location.reload()
        return
      else if dealerScore > playerScore
        popup = confirm("YOU ROOSE!")
        if popup then location.reload() else location.reload()
        return
      else
        popup = confirm("YOU VIN!")
        if popup then location.reload() else location.reload()

    # use lower value from ace array to compare score with bust value.
    # if not bust, check higher value to compare score blah blah bullshit.
    # lower value is always ace[0], higher is ace[1]
    # return an

  hiLow: (scores) ->
    if scores.length is 2
      if scores[0] <= 21 and scores[1] <= 21
        if scores[0] > scores[1]
          return scores[0]
        else
          return scores[1]