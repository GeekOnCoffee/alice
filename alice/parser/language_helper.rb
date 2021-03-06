module Alice

  module Parser

    module LanguageHelper

      ARTICLES = [
        'a', 'the', 'of', 'an', 'to', 'and'
      ]

      NUMBERS = {
        'one' => '1',
        'two' => '2',
        'three' => '3',
        'four' => '4',
        'five' => '5',
        'six' => '6',
        'seven' => '7',
        'eight' => '8',
        'nine' => '9',
        'ten' => '10'
      }

      IDENTIFIERS = NUMBERS.keys + NUMBERS.values + ARTICLES

      def self.similar_to(original_word, test_word)
        return true if original_word =~ /#{test_word}/i
        return true if test_word =~ /#{original_word}/i
        RubyFish::Hamming.distance(original_word, test_word) <= 5
      end

    end

  end

end
