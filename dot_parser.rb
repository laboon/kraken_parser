require 'date'

SUPPORTED_CURRENCIES = [:USD, :CHF, :EUR]
currency = :USD

def check_args(args)
  if args.count < 1
    puts "You need to enter a filename."
    exit 1
  end

  if args.count == 1
    puts "Defaulting currency to USD."
  end

  if args.count > 2
    puts "Too many arguments! Enter only FILENAME and CURRENCY."
    puts "Supported currencies: #{SUPPORTED_CURRENCIES}"
    exit 1
  end

  if args.count == 2
    if !SUPPORTED_CURRENCIES.include?(args[1].upcase.to_sym)
      puts "#{args[1]} is not a supported currency."
      puts "Supported currencies: #{SUPPORTED_CURRENCIES}"
      exit 1
    end
  end
  
end

check_args(ARGV)

exit 0


file_loc = ARGV[0]
stake_kind = "DOT.S"

price_file = "./dot-usd.csv"

dot_prices = {}

# Load in pricing information

first_line = true

File.foreach(price_file) do |line|
  
  # Ignore first line
  if first_line
    first_line = false
    next
  end

  data = line.split(",").map { |l| l.delete_prefix('"').delete_suffix('"') }
  
  date = Date.parse(data[0])
  price = data[1]
  dot_prices[date] = price
                             
  
end

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

pp staking_data

if staking_data.count.zero?
  puts "No DOT staking events found in this CSV file."
  exit 1
end


# calculate staking data

total_dots = 0
total_usd_value = 0

staking_data.each do |event|
  date = event[0]
  dot_amount = event[1].to_f
  price = dot_prices[date].to_f.round(2)
  usd_value = (dot_amount * price).round(2)
  total_dots += dot_amount
  total_usd_value += usd_value
  puts "#{date}: #{dot_amount} DOT /  #{usd_value} USD"
  
end

puts "Total DOTs Received: #{total_dots}"
puts "Total USD Value: $#{total_usd_value.round(2)}"
