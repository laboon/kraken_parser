require 'date'


file_loc = ARGV[0]
stake_kind = "EUR.M"


# Load in staking data

staking_data = []

File.foreach(file_loc) do |line|
  data = line.split(",").map { |l| l.delete_prefix('"').delete_suffix('"') }
  deposit_or_staking = data[3]
  kind = data[6]
  if kind == stake_kind && deposit_or_staking == "staking"
    staking_event = []
    staking_event << Date.parse(data[2]) << data[7]
    staking_data << staking_event
  end
  
end

# calculate staking data

total_dots = 0
total_eur_value = 0

staking_data.each do |event|
  date = event[0]
  value = event[1].to_f
  total_eur_value += value
  puts "#{date}: #{value} EUR"
  
end

puts "Total EUR Value: €#{total_eur_value.round(2)}"
