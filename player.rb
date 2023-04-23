# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'

# プレイヤークラス
class Player
  attr_reader :cards, :score

  def initialize
    @cards = []
  end

  # デッキからカードを引く
  def draw(deck, number)
    @cards << deck.draw(number)
    @cards.flatten!
  end

  # 手札の点数を計算する
  def hand_score
    score = 0

    cards.each do |card|
      score += card.score
    end
    # Aを1点あるいは11点のどちらかで扱うようにプログラムを修正しましょう。Aはカードの合計値が21以内で最大となる方で数えるようにします。
    # ただし、カードの合計値が21を超えてしまう場合は、Aを1点として扱います
    if score > 21 && cards.any? { |card| card.number == 'A' }
      score -= 10
    end
    score
  end

  # 手札が２１より上かどうかを判定する
  def over?
    hand_score > 21
  end
end
