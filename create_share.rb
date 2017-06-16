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

# Setup configuration
IFClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = username
  config.password = password
  config.host = host
  config.verify_ssl = false
end

api_instance = IFClient::DataApi.new

#Set share option params
new_share_option = IFClient::ShareOptions.new
new_share_option.block_size = IFClient::BlockSizeEnum::N32_KB
#new_share_option.mount_point = ##OPTIONAL
new_share_option.quota = -1
new_share_option.reservation = -1

#Set share permissions params
new_share_permission = IFClient::SharePermissions.new
#new_share_permission.group_list = ##OPTIONAL
new_share_permission.share_permission_enum = IFClient::PermissionTypeEnum::N0
new_share_permission.share_permission_mode = IFClient::PermissionTypeEnum::N0
#new_share_permission.user_list = ##OPTIONAL

#Set share params
create_share_param = IFClient::CreateShareParam.new
create_share_param.arg0_pool_name = "pool-a"
create_share_param.arg1_project_name = "share-project"
create_share_param.arg2_share_name = "share5"
create_share_param.arg3_share_options = new_share_option
create_share_param.arg4_share_permissions = [new_share_permission] ##Requires []

begin
  #Creates a share with the specified share options and share permissions.
  result = api_instance.create_share_post(create_share_param)
  if result == 0
    puts "Created Successfully"
  else
    puts "Error When Creating Volume"
  end
rescue IFClient::ApiError => e
  puts "Exception when calling DataApi->create_share_post: #{e}"
end
