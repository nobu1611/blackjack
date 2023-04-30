# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'

# プレイヤークラス
class Player
  attr_reader :hand_cards

  def initialize
    @hand_cards = []
  end

  # デッキからカードを引く
  def draw(deck, number)
    @hand_cards << deck.draw(number)
    @hand_cards.flatten!.to_s
  end

  # 手札の点数を計算する
  def hand_score
    score = 0

    hand_cards.each do |card|
      score += card.score
    end
    # Aを1点あるいは11点のどちらかで扱うようにプログラムを修正。Aはカードの合計値が21以内で最大となる方で数える。
    # ただし、カードの合計値が21を超えてしまう場合は、Aを1点として扱います
    score -= 10 if score > 21 && hand_cards.any? { |card| card.number == 'A' }
    score
  end

  # 手札が２１より上かどうかを判定する
  def over?
    hand_score > 21
  end
end
