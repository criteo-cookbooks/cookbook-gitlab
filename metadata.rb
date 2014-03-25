maintainer       "Eric G. Wolfe"
maintainer_email "eric.wolfe@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures gitlab"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name             "gitlab"
version          "6.9.0"
%w[ redhat centos debian ubuntu ].each do |os|
  supports os
end
