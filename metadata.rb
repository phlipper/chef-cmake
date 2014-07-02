name              "cmake"
maintainer        "Phil Cohen"
maintainer_email  "github@phlippers.net"
license           "MIT"
description       "Install cmake"
version           "0.3.0"

recipe "default", "Install default cmake support"

%w{ build-essential }.each do |dependency|
  depends dependency

%w{ debian ubuntu redhat centos fedora }.each do |os|
  supports os
end


