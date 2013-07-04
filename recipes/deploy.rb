include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping deploy::rails application #{application} as it is not an Rails app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  # Disable the deploy restart for this run
  node.set[:opsworks][:rails_stack][:restart_command] = '/bin/true'

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  deploy = node[:deploy][application]
  layer_short_name = node[:opsworks][:instance][:layers].first

  execute "deploy Rails app #{application} for #{layer_short_name}" do
    cwd deploy[:current_path]
    command node[:bare_rails][layer_short_name][:deploy_command]
    action :run
    not_if { node[:bare_rails][layer_short_name][:deploy_command].nil? || node[:bare_rails][layer_short_name][:deploy_command].empty? }
  end
end
