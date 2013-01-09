name              "cmake"
maintainer        "Phil Cohen"
maintainer_email  "github@phlippers.net"
license           "MIT"
description       "Install cmake"
version           "0.1.0"

recipe "default", "Install default cmake support"

%w{ debian ubuntu redhat centos fedora }.each do |os|
  supports os
end


