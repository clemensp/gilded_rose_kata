def apply_quality_change(item)
  delta = quality_delta_for(item) 
  return unless quality_needs_to_be_updated?(item, delta)

  item.quality += delta
end

def quality_needs_to_be_updated?(item, delta)
  return false if item.quality + delta < 0
  return false if item.quality + delta > 50

  true
end

def quality_delta_for(item)
  case item.name
  when 'Aged Brie'
    1
  when 'Backstage passes to a TAFKAL80ETC concert'
    quality_delta_for_backstage_pass(item.sell_in)
  when 'Sulfuras, Hand of Ragnaros'
    0
  else
    -1
  end
end

def quality_delta_for_backstage_pass(sell_in)
  if sell_in > 10
    1
  elsif sell_in > 5
    2
  elsif sell_in > 0
    3
  else
    0
  end
end

def update_quality(items)
  items.each do |item|
    apply_quality_change(item)

    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.sell_in -= 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.name != 'Sulfuras, Hand of Ragnaros'
            apply_quality_change(item)
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        apply_quality_change(item)
      end
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

