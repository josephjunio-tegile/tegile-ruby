require "tegile-api"

#Request access info for array
#puts "IntelliFlash Array IP?:"
#host = gets.chomp
=begin
puts "IntelliFlash Array Username?:"
username = gets.chomp
puts "IntelliFlash Array Password?:"
password = gets.chomp
=end

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

host = "10.65.5.40"
username = "admin"
password = "tegile"

# Setup configuration
IFClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = username
  config.password = password
  config.host = host
  config.verify_ssl = false
end

api_instance = IFClient::DataApi.new

#Set volumes params
list_volumes_param = IFClient::ListVolumesParam.new
list_volumes_param.arg0_pool_name = "pool-a"
list_volumes_param.arg1_project_name = "HyperV"
list_volumes_param.arg2_local = TRUE

begin
  #Lists all the local or replicated volumes within a Project.
  result = api_instance.list_volumes_post(list_volumes_param)
rescue IFClient::ApiError => e
  puts "Exception when calling DataApi->list_volumes_post: #{e}"
end


#Return results in readable string
result.each do |x|
  new_vol_size = betternum(x.vol_size)
  #new_available_size = betternum(x.available_size)
  puts "Volume Name:#{x.name}, Volume Size:#{new_vol_size}"
end
