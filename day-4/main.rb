# Read data into a list.
def read_data
    file = File.open("./input.txt")
    file.readlines.map { |line| line.strip.gsub(/\s+/, " ") }.filter { |line| line.length > 0 }
end

# Data class for one card.
# Data line has this format:
# Card 1: 1 2 3 4 5 | 6 7 8 9 10 11 12
class Card
    attr_accessor :id, :winning_numbers, :numbers, :winning_count, :instance

    def initialize(line)
        regex = /^Card\s+(\d+): (.+) \| (.+)$/
        result = regex.match(line)

        @id = Integer(result[1])
        @winning_numbers = result[2].split.map { |comp| Integer(comp) }
        @numbers = result[3].split.map { |comp| Integer(comp) }
        @winning_count = @numbers.count { |num| @winning_numbers.include?(num) }
        @instance = 1
    end
end

# A card that has one number that won is worth 1pt, 2 numbers are worth 2pts, then 4pts, 8pts,...
# Result of part one is the sum of all those points across all cards/
def solve_part_one(cards)
    puts cards.map { |_, card| card.winning_count }
              .map { |num| num > 0 ? 2 ** (num - 1) : 0 }
              .sum
end

# Part two is counting the TOTAL number of scratch cards at the end of the session.
# Each winning card grants additional copies of cards BELOW it.
# Result is the total number of cards we got.
def solve_part_two(cards)
    (1..cards.size).map { |idx| [idx, cards[idx]] }.each { |idx, card|
        card = cards[idx]

        # For each instance, add additional copies of more cards below it.
        (idx + 1..idx + card.winning_count)
          .filter { |num| num <= cards.size }
          .each { |num| cards[num].instance += card.instance }
    }

    puts cards.map { |_, card| card.instance }.sum
end

cards = read_data.map { |line| Card.new(line) }.to_h { |card| [card.id, card] }
solve_part_one(cards)
solve_part_two(cards)
