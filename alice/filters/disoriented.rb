module Alice

  module Filters

    class Disoriented

      def process(text)
        to_process = "#{text}"
        directions = (Place::DIRECTIONS + ["up", "down", "sideways", "diagonally"])
        directions = directions.sort{|a,b| rand(10) <=> rand(10)}
        to_process.gsub!(/east|west|north|south/) { directions.pop }
      end

    end

  end

end