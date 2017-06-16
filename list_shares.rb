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

#Set share params
list_shares_param = IFClient::ListSharesParam.new
list_shares_param.arg0_pool_name = "pool-a"
list_shares_param.arg1_project_name = "VMWARE-NFS"
list_shares_param.arg2_local = TRUE

begin
  #Lists all the local and replicated shares in a project.
  result = api_instance.list_shares_post(list_shares_param)
  #puts result
rescue IFClient::ApiError => e
  puts "Exception when calling DataApi->list_shares_post: #{e}"
end

#Return results in readable string
result.each do |x|
  new_total_size = betternum(x.total_size)
  #new_available_size = betternum(x.available_size)
  puts "Share Name:#{x.name}, Total Space:#{new_total_size}"
end
