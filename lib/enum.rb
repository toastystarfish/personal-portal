
class Enum
  def initialize *args
    @kv_map = create_map args
    @vk_map = @kv_map.invert
  end

  def symbols
    @kv_map.keys
  end

  def integers
    @vk_map.keys
  end

  def [] query
    case query
    when Symbol
      @kv_map[query]
    when Integer
      @vk_map[query]
    end
  end
  alias :find :[]

  def symbol_map
    @kv_map
  end
  alias :to_h :symbol_map

  def length
    @kv_map.length
  end
  alias :count :length

  def to_s
    self.symbols.to_s
  end

  private

  def create_map info
    value    = 0
    last_key = nil
    {}.tap do |kv_map|
      info.each do |i|
        case i
        when Symbol
          raise ArgumentError, "duplicate enum key" if kv_map.has_key?(i)
          last_key = i
          kv_map[i] = value
          value += 1
        when Integer
          kv_map[last_key] = i
          value = i += 1
        end
      end
    end
  end
end
