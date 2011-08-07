maintainer       "Saaspire LLC"
maintainer_email "sean@saaspire.com"
license          "Apache 2.0"
description      "Installs/Configures riaksearch"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends          "java::sun"

%w{ debian ubuntu }.each do |os|
  supports os
end
