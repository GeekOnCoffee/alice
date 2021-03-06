# TODO FIX truncating item names becuse of predicate

class CommandString

  attr_accessor :content

  PREDICATE_INDICATORS = [
    "to", "from", "with", "on", "in", "about"
  ]

  def initialize(content)
    self.content = content
  end

  def components
    @components ||= self.content.split(' ').reject{|w| w.blank? }
  end

  def has_predicate?
    predicate_position > 0
  end

  def predicate
    return unless predicate_positions.max
    components[(predicate_positions.max + 1)..-1].join(' ')
  end

  def predicate_positions
    PREDICATE_INDICATORS.map{ |indicator| components.index(indicator) }.compact
  end

  def predicate_position
    predicate_positions.max || 0
  end

  def quoted_text
    return unless content =~ /"/
    return "" if content =~ /""/
    content.gsub(/.*"(.*)".*/, '\1')
  end

  def raw_command
    self.content.gsub(/^.?#{verb} /, "")
  end

  def subject
    return components[1..-1].join(' ') unless has_predicate?
    return components[1..(predicate_positions.min - 1)].join(' ')
  end

  def verb
    components[0].gsub(/^!/, '')
  end

end
