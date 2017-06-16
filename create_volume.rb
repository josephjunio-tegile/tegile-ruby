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

# Setup authorization
IFClient.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = username
  config.password = password
  config.host = host
  config.verify_ssl = false
end

api_instance = IFClient::DataApi.new

#Set volume params
new_vol = IFClient::VolumeV10.new
new_vol.name = "vol4"
new_vol.pool_name = "pool-a"
new_vol.project_name = "vol-project"
new_vol.protocol = "iSCSI"
new_vol.vol_size = 10737418240
new_vol.block_size = IFClient::BlockSizeEnum::N32_KB
new_vol.thin_provision = true
#new_vol.local = true

create_volume_param = IFClient::CreateVolumeParam.new
create_volume_param.arg0_volume = new_vol
create_volume_param.arg1_inherit_san_view_settings_from_project = true


begin
  #Creates a volume with the specified settings.
  result = api_instance.create_volume_post(create_volume_param)
  if result == 0
    puts "Created Successfully"
  else
    puts "Error When Creating Volume"
  end
rescue IFClient::ApiError => e
  puts "Exception when calling DataApi->create_volume_post: #{e}"
end
