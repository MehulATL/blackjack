class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    @bust()

  stand: ->
    score = @scores()
    @at(0).flip()
    while score < 17
      @add(@deck.pop()).last()
      score = @scores()
    if !@bust() then @trigger('tiger', @)


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  bust: ->
    player = 'You'
    if @isDealer then player = 'Dealer'
    @scores() > 21
