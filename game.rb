# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

# ゲーム全体を管理するクラス
class Game
  def initialize
    @deck = Deck.new # デッキをインスタンス化する
    @player = Player.new # プレイヤーをインスタンス化する
    @dealer = Dealer.new # ディーラーをインスタンス化する
  end

  # ゲームを開始する
  def play
    puts 'ブラックジャックを開始します。'
    player_turn
    dealer_turn1
    player_drow_card?
    dealer_turn2
    judge
    puts 'ブラックジャックゲームを終了します。'
  end
end

# プレイヤーがドローする
def player_turn
  @player.draw(@deck, 2)
  puts "あなたの引いたカードは#{@player.hand_cards[0]}です。"
  puts "あなたの引いたカードは#{@player.hand_cards[1]}です。"
end

# ディーラーがドローする
def dealer_turn1
  @dealer.draw(@deck, 1)
  puts "ディーラーの引いたカードは#{@dealer.hand_cards[0]}です。"
  puts 'ディーラーの引いた２枚目のカードはわかりません。'
end

# プレイヤーがカードを引くかどうかを選択する
def player_drow_card?
  loop do
    puts "あなたの現在の得点は#{@player.hand_score}です。カードを引きますか？（Y/N）"
    input = gets.chomp.upcase
    if input == 'Y' # Yが入力されたらカードを引く
      @player.draw(@deck, 1)
      player_card = @player.hand_cards.last.to_s
      puts "あなたの引いたカードは#{player_card}です。"
      break if @player.over? # バーストしたかどうかを判定する
    elsif input == 'N'
      break
    else
      puts 'YかNで入力してください。'
    end
  end
end

# ディーラーの得点が17以上になるまでカードを引くメソッド
def dealer_turn2
  @dealer.draw(@deck, 1)
  puts "ディーラーの引いた２枚目のカードは#{@dealer.hand_cards[1]}でした。"
  puts "ディーラーの現在の得点は#{@dealer.hand_score}です。"
  loop do
    if @dealer.hand_score < 17
      @dealer.draw(@deck, 1)
      dealer_card = @dealer.hand_cards.last.to_s
      puts "ディーラーの引いたカードは#{dealer_card}です"
      puts "ディーラーの現在の得点は#{@dealer.hand_score}です。"
    elsif @dealer.over?
      break
    else
      break
    end
  end
end

# 勝利判定
def judge
  puts "あなたの得点は#{@player.hand_score}です。"
  puts "ディーラーの得点は#{@dealer.hand_score}です。"
  if @player.over? && @dealer.over?
    puts 'どちらもバーストしました。引き分けです。'
  elsif @player.hand_score == 21
    puts 'あなたのブラックジャック！あなたの勝ちです！'
  elsif @dealer.hand_score == 21
    puts 'ディーラーのブラックジャック！あなたの負けです。'
  elsif @player.over?
    puts 'あなたはバーストしました。あなたの負けです。'
  elsif @dealer.over?
    puts 'ディーラーはバーストしました。あなたの勝ちです！'
  elsif @player.hand_score > @dealer.hand_score
    puts 'あなたの勝ちです！'
  elsif @player.hand_score < @dealer.hand_score
    puts 'あなたの負けです。'
  elsif @player.hand_score == @dealer.hand_score
    puts '引き分けです！'
  else
    puts 'どちらもバーストしました。引き分けです。'
  end
end
