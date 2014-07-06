name              "cmake"
maintainer        "Phil Cohen"
maintainer_email  "github@phlippers.net"
license           "MIT"
description       "Install cmake"
version           "0.3.0"

recipe "cmake::default", "Install default cmake support"

supports "debian"
supports "ubuntu"
supports "redhat"
supports "centos"
supports "fedora"

suggests "build-essential"
