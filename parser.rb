require 'date'

############################################################################
# CONSTANTS AND GLOBAL VARIABLES
############################################################################


# Supported fiat currencies
SUPPORTED_CURRENCIES = ['usd', 'chf', 'eur']
# Currency used (default = usd)
$currency = 'usd'

# Supported tokens
SUPPORTED_TOKENS = ['KSM', 'DOT']

# Supported "staking" versions of tokens according to Kraken
SUPPORTED_TOKENS_S = SUPPORTED_TOKENS.map { |x| x + ".S" }


############################################################################
# HELPER METHODS 
############################################################################

# Checks that valid arguments were passed in

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
    if !SUPPORTED_CURRENCIES.include?(args[1].downcase)
      puts "#{args[1]} is not a supported currency."
      puts "Supported currencies: #{SUPPORTED_CURRENCIES}"
      exit 1
    end
  end
  
end


def print_totals(total_tokens, total_value)
  SUPPORTED_TOKENS.each do |kind|
    if total_tokens[kind] > 0
      print "Total #{kind} Received: #{total_tokens[kind]} "
      puts "( #{total_value[kind].round(2)} #{$currency.upcase} )"
    else
      puts "No #{kind} rewards found."
    end
  end

end


############################################################################
# EXECUTION STARTS HERE
############################################################################

check_args(ARGV)

file_loc = ARGV[0]
$currency = ARGV[1]

all_prices = {}

SUPPORTED_TOKENS.each do |token|
  stake_kind = token + ".S"
  price_file = "./data/#{token.downcase}-#{$currency}.csv"
  prices = {}

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
    prices[date] = price
    
    
  end

  all_prices[token] = prices

  
end


# Load in staking data

staking_data = []

File.foreach(file_loc) do |line|
  data = line.split(",").map { |l| l.delete_prefix('"').delete_suffix('"') }
  deposit_or_staking = data[3]
  kind = data[6]
  if SUPPORTED_TOKENS_S.include?(kind) && deposit_or_staking == "staking"
    staking_event = []
    staking_event << Date.parse(data[2]) << data[7] << kind
    staking_data << staking_event
  end
  
end

if staking_data.count.zero?
  puts "No staking events found in this CSV file."
  exit 1
end




# pre-populate token amounts and values


total_tokens = {}
total_value = {}

SUPPORTED_TOKENS.each do |kind|
  total_tokens[kind] = 0
  total_value[kind] = 0
end


# calculate staking data


staking_data.each do |event|
  date = event[0] # get date
  amount = event[1].to_f # get amount of rewards in token
  kind = event[2].chop.chop # remove .S to get raw token name
  price = all_prices[kind][date].to_f.round(2)
  value = (amount * price).round(2)
  total_tokens[kind] += amount
  total_value[kind] += value
  puts "#{date}: #{amount} #{kind} ( #{value} #{$currency.upcase} )"
  
end

print_totals(total_tokens, total_value)


