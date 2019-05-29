class Card
  attr_reader :suit, :num

  def initialize(input)
    splited_input = input.split("", 2)
    @suit = splited_input[0]
    @num = splited_input[1].to_i == 1 ? 14 : splited_input[1].to_i
  end
end

class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def result
    return 'Straight flash' if straight_flash?
    return 'Four card' if four_card?
    return 'Full house' if full_house?
    return 'Straight' if straight?
    return 'Flash' if flash?
    return 'Three card' if three_card?
    return 'Two pair' if two_pair?
    return 'One pair' if one_pair?
    'High card'

    # case card_nums_array
    # in [1, 1, 1, 2]
    #   p "one_pair"
    # in [1, 2, 2]
    #   p "two_pair"
    # in [1, 1, 3]
    #   p "three_card"
    # end
  end

  private

  def card_nums_array
    @cards.map do |card|
      card.num
    end
  end

  def card_suits_array
    @cards.map do |card|
      card.suit
    end
  end

  def one_pair?
    # card_nums_array.group_by(&:itself).map{ |k, v| v.count }.max == 2
    card_nums_array.group_by(&:itself).map{ |k, v| v.count }.sort == [1, 1, 1, 2]
  end

  def two_pair?
    # card_nums_array.uniq.size == 3
    card_nums_array.group_by(&:itself).map{ |k, v| v.count }.sort == [1, 2, 2]
  end

  def three_card?
    # card_nums_array.group_by(&:itself).map{ |k, v| v.count }.max == 3
    card_nums_array.group_by(&:itself).map{ |k, v| v.count }.sort == [1, 1, 3]
  end

  def straight?
    card_nums_array.uniq.size == 5 && (card_nums_array.min + 4 == card_nums_array.max)
  end

  def flash?
    card_suits_array.uniq.size == 1
  end

  def full_house?
    card_nums_array.group_by(&:itself).map{ |k, v| v.count }.sort == [2, 3]
  end

  def four_card?
    # card_nums_array.group_by(&:itself).map{ |k, v| v.count }.max == 4
    card_nums_array.group_by(&:itself).map{ |k, v| v.count }.sort == [1, 4]
  end

  def straight_flash?
    straight? && flash?
  end
end

p "何か入力してください。"
input = STDIN.gets
cards = input.split().map do |card|
  Card.new(card)
end

hands = Hand.new(cards)
p hands.result
