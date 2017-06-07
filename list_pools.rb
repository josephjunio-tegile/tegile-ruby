require "tegile-api"

#Request access info for array
puts "IntelliFlash Array IP?"
host = gets.chomp
puts "IntelliFlash Array Username?"
username = gets.chomp
puts "IntelliFlash Array Password?"
password = gets.chomp


#host = "10.65.103.10"
#username = "admin"
#password = "tegile"

# Setup authorization
IFClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = username
  config.password = password
  config.host = host
  config.verify_ssl = false
end
api_instance = IFClient::DataApi.new

def betternum(n)
  if n < 1099511627776
    n_gb = n.to_f/1024/1024/1024
    return "#{n_gb.floor(2)}GB"
  end
  if n >= 1099511627776
    n_tb = n.to_f/1024/1024/1024/1024
    return "#{n_tb.floor(2)}TB"
  end
end

begin
  #Lists all the pools on the Tegile array
  result = api_instance.list_pools_get
rescue IFClient::ApiError => e
  puts "Exception when calling DataApi->list_pools_get: #{e}"
end


#Return results in readable string
result.each do |x|
  new_total_size = betternum(x.total_size)
  new_available_size = betternum(x.available_size)
  puts "Pool Name:#{x.name}, Total Space:#{new_total_size}, Avilable Space:#{new_available_size}"
end
