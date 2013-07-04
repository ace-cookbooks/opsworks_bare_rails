node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping shutdown application #{application} as it is not an Rails app")
    next
  end

  deploy = node[:deploy][application]
  layer_short_name = node[:opsworks][:instance][:layers].first

  execute "shutdown Rails app #{application} for #{layer_short_name}" do
    cwd deploy[:current_path]
    command node[:bare_rails][layer_short_name][:shutdown_command]
    action :run
    not_if { node[:bare_rails][layer_short_name][:shutdown_command].nil? || node[:bare_rails][layer_short_name][:shutdown_command].empty? }
  end
end
