node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping configure application #{application} as it is not an Rails app")
    next
  end

  deploy = node[:deploy][application]
  layer_short_name = node[:opsworks][:instance][:layers].first

  execute "configure Rails app #{application} for #{layer_short_name}" do
    cwd deploy[:current_path]
    command node[:bare_rails][layer_short_name][:configure_command]
    action :run
    not_if { node[:bare_rails][layer_short_name][:configure_command].nil? || node[:bare_rails][layer_short_name][:configure_command].empty? }
  end
end
