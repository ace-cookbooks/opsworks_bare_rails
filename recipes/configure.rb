node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping configure application #{application} as it is not an Rails app")
    next
  end

  layer_short_name = node[:opsworks][:instance][:layers].first

  if node[:bare_rails][layer_short_name] && node[:bare_rails][layer_short_name][:configure_command] && node[:bare_rails][layer_short_name][:configure_command] != ''
    execute "configure Rails app #{application} for #{layer_short_name}" do
      cwd deploy[:current_path]
      command node[:bare_rails][layer_short_name][:configure_command]
      action :run
    end
  end
end
