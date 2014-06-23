name              'ohai-nfs-exports'
maintainer        'Peter Fern'
maintainer_email  'ruby@0xc0dedbad.com'
license           'MIT'
description       'A tiny Ohai plugin to populate attributes for NFS exports'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.0.1'

%w{debian ubuntu}.each do |os|
  supports os
end

depends 'ohai'
