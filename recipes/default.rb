#
# Cookbook Name:: cmake
# Recipe:: default
#

if node[:cmake][:from_source] then
  include_recipe "cmake::from_source"
else
  case node[:platform]
  when "centos","fedora","redhat"
    package "cmake28"
  when "ubuntu","debian"
    package "cmake"
  end
end
