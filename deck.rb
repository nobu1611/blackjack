# frozen_string_literal: true

require_relative 'card'

# デッキクラス
class Deck
  attr_reader :cards

  def initialize
    @cards = [] # 空の配列を作成する
    Card::SUITS.each do |suit| # 4種類のマークを順番に取り出す
      Card::NUMBERS.each do |number| # 13種類の数字を順番に取り出す
        @cards << Card.new(suit, number) # 取り出したマークと数字を使ってカードを作成し、配列に追加する
      end
    end
    @cards.shuffle! # デッキをシャッフルする
  end

  # デッキからカードを引く
  def draw(number)
    @cards.pop(number) # 配列の最後から引数で指定した数だけ要素を取り出す
  end
end
