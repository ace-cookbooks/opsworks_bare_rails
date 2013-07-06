node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping shutdown application #{application} as it is not an Rails app")
    next
  end

  layer_short_name = node[:opsworks][:instance][:layers].first

  if node[:bare_rails][layer_short_name] && node[:bare_rails][layer_short_name][:shutdown_command] && node[:bare_rails][layer_short_name][:shutdown_command] != ''
    execute "shutdown Rails app #{application} for #{layer_short_name}" do
      cwd deploy[:current_path]
      command node[:bare_rails][layer_short_name][:shutdown_command]
      action :run
    end
  end
end
