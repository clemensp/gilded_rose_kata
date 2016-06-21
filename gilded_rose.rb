def apply_quality_change(item, delta)
  return unless quality_needs_to_be_updated?(item, delta)

  item.quality += delta
end

def quality_needs_to_be_updated?(item, delta)
  return false if item.quality + delta < 0
  return false if item.quality + delta > 50

  true
end

def update_quality(items)
  items.each do |item|
    if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
      if item.name != 'Sulfuras, Hand of Ragnaros'
        apply_quality_change(item, -1)
      end
    else
      if item.quality < 50
        apply_quality_change(item, 1)

        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            if item.quality < 50
              apply_quality_change(item, 1)
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              apply_quality_change(item, 1)
            end
          end
        end
      end
    end
    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.sell_in -= 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.name != 'Sulfuras, Hand of Ragnaros'
            apply_quality_change(item, -1)
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          apply_quality_change(item, 1)
        end
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

