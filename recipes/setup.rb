node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping application #{application} as it is not an Rails app")
    next
  end

  opsworks_deploy_user do
    deploy_data deploy
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end
end
