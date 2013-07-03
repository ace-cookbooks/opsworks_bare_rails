name             'opsworks_bare_rails'
maintainer       'Ryan Schlesinger  '
maintainer_email 'ryan@instanceinc.com'
license          'Apache 2.0'
description      'Sets up a bare rails layer on opsworks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'opsworks_bare_rails::setup', 'Sets up the bare rails layer'
recipe 'opsworks_bare_rails::configure', 'Configures the bare rails layer'
recipe 'opsworks_bare_rails::deploy', 'Deploys the bare rails layer'
recipe 'opsworks_bare_rails::undeploy', 'Undeploys the bare rails layer'
recipe 'opsworks_bare_rails::shutdown', 'Shuts down the bare rails layer'
