#
# Cookbook Name:: cmake
# Recipe:: default
#

include_recipe "cmake::from_#{node[:cmake][:install_method]}"
