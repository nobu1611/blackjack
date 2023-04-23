# frozen_string_literal: true

require_relative 'player'

# ディーラークラス
class Dealer < Player
  attr_reader :cards

  def initialize
    super
    @cards = []
  end
end
