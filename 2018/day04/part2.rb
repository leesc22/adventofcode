require 'date'

filename = 'input.txt'

def analyse(filename)
  records   = open(filename).readlines.map { |e| e.scan(/\[(.*)\] (.*)/).flatten }

  new_records = records.sort_by { |e| DateTime.strptime(e[0], "%Y-%m-%d %H:%M") }

  frequency = Hash.new()
  guard_id  = 0
  sleep_min = 0
  
  new_records.each do |record|
    if record[1].start_with?("Guard")
      guard_id = record[1].match(/\d+/).to_s
      frequency[guard_id] ||= Hash.new(0)
    elsif record[1].start_with?("falls")
      sleep_min = record[0].chars.last(2).join.to_i
    else
      awake_min = record[0].chars.last(2).join.to_i
      for i in (sleep_min...awake_min)
        frequency[guard_id][i] += 1
      end
    end
  end

  chosen_hash = frequency.max_by { |id, mins| mins.values.max || 0 }
  chosen_id   = chosen_hash.first
  chosen_min  = chosen_hash.last.key(chosen_hash.last.values.max)

  return chosen_id.to_i * chosen_min
end

puts "#{analyse(filename)} is the ID of the guard chosen multiplied by the minute chosen"