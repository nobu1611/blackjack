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
    puts 'ブラックジャックゲームを開始します。'
    @player.draw(@deck, 2)
    puts "あなたの引いたカードは#{@player.cards[0].to_s}です。"
    puts "あなたの引いたカードは#{@player.cards[1].to_s}です。"
    @dealer.draw(@deck, 1)
    puts "ディーラーの引いたカードは#{@dealer.cards[0].to_s}です。"
    puts 'ディーラーの引いた２枚目のカードはわかりません。'

    # プレイヤーがカードを引くかどうかを選択する
    loop do
      puts "あなたの現在の得点は#{@player.hand_score}です。カードを引きますか？（Y/N）"
      input = gets.chomp.upcase
      if input == 'Y' # Yが入力されたらカードを引く
        @player.draw(@deck, 1)
        player_card = @player.cards.last.to_s
        puts "あなたの引いたカードは#{player_card}です。"
        break if @player.over? # バーストしたかどうかを判定する
      elsif input == 'N'
        break
      else
        puts 'YかNで入力してください。'
      end
    end

    @dealer.draw(@deck, 1)
    puts "ディーラーの引いた２枚目のカードは#{@dealer.cards[1].to_s}でした。"
    puts "ディーラーの現在の得点は#{@dealer.hand_score}です。"

    loop do
      # if @dealer.hand_score > 21 && @card.number == 'A'
      #   @dealer.hand_score -= 10
      # end
      if @dealer.hand_score < 17
        @dealer.draw(@deck, 1)
        dealer_card = @dealer.cards.last.to_s
        puts "ディーラーの引いたカードは#{dealer_card}です"
        puts "ディーラーの現在の得点は#{@dealer.hand_score}です。"
      elsif @dealer.over?
        break
      else
        break
      end
    end

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
    puts 'ブラックジャックゲームを終了します。'
  end
end
