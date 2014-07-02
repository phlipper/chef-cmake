
cmake_dirname = "cmake-#{node[:cmake][:version][:major]}.#{node[:cmake][:version][:minor]}.#{node[:cmake][:version][:fix]}.#{node[:cmake][:version][:build]}"
cmake_filename = "#{cmake_dirname}.tar.gz"

remote_file "#{Chef::Config[:file_cache_path]}/#{cmake_filename}" do
  source "http://www.cmake.org/files/v#{node[:cmake][:version][:major]}.#{node[:cmake][:version][:minor]}/#{cmake_filename}"
  notifies :run, "extract", :delayed
end

execute "extract" do
  command "tar xf #{Chef::Config[:file_cache_path]}/#{cmake_filename}"
  cwd "#{Chef::Config[:file_cache_path]}"
  notifies :run, "configure", :delayed
end

execute "configure" do
  command "./configure"
  cwd "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
  action :nothing
  notifies :run, 'make', :delayed
end

execute "make" do
  command "make"
  cwd "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
  action :nothing
  notifies :run, 'make install', :delayed
end

execute "make install" do
  command "make install"
  cwd "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
  action :nothing
end
  
