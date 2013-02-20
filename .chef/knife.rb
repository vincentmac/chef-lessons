current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "lessonsforlife"
# client_key               "#{current_dir}/vincentmac.pem"
# validation_client_name   "simplicity-io-validator"
# validation_key           "#{current_dir}/simplicity-io-validator.pem"
# chef_server_url          "https://api.opscode.com/organizations/simplicity-io"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
data_bag_path            "#{ENV['HOME']}/.chef/databags"