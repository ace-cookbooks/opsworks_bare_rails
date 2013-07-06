include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping deploy::rails-undeploy application #{application} as it is not an Rails app")
    next
  end

  layer_short_name = node[:opsworks][:instance][:layers].first

  if node[:bare_rails][layer_short_name][:undeploy_command] && node[:bare_rails][layer_short_name][:undeploy_command] != ''
    execute "undeploy Rails app #{application} for #{layer_short_name}" do
      cwd deploy[:current_path]
      command node[:bare_rails][layer_short_name][:undeploy_command]
      action :run
    end
  end

  directory "#{deploy[:deploy_to]}" do
    recursive true
    action :delete
    only_if do
      File.exists?("#{deploy[:deploy_to]}")
    end
  end
end
