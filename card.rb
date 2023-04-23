# frozen_string_literal: true

# カードクラス
class Card
  SUITS = %w[ハート ダイヤ スペード クローバー].freeze # マークの配列を定数にする
  NUMBERS = [*(2..10), 'J', 'Q', 'K', 'A'].freeze # 数字の配列を定数にする

  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  # カードを表す文字列を返す
  def to_s
    "#{suit}の#{number}"
  end

  # カードの得点
  def score
    case number
    when 'A' then 11
    when 'J', 'Q', 'K' then 10
    else
      number
    end
  end
end
