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

host = "10.65.5.40"
username = "admin"
password = "tegile"
pool = "pool-a"

# Setup authorization
IFClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = username
  config.password = password
  config.host = host
  config.verify_ssl = false
end

api_instance = IFClient::DataApi.new
list_projects_param = IFClient::ListProjectsParam.new
list_projects_param.arg0_pool_name = pool
list_projects_param.arg1_local = true


begin
  #Lists all the local or replicated projects in a pool.
  result = api_instance.list_projects_post(list_projects_param)
rescue IFClient::ApiError => e
  puts "Exception when calling DataApi->list_projects_post: #{e}"
end

#Display project in readable line
print "Projects in #{pool} are..."
result.each do |x|
  print "#{x.name}, "
end
puts
