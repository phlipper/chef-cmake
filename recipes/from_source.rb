
cmake_dirname = "cmake-#{node[:cmake][:version][:major]}.#{node[:cmake][:version][:minor]}.#{node[:cmake][:version][:fix]}.#{node[:cmake][:version][:build]}"
cmake_filename = "#{cmake_dirname}.tar.gz"

remote_file "#{Chef::Config[:file_cache_path]}/#{cmake_filename}" do
  source "http://www.cmake.org/files/v#{node[:cmake][:version][:major]}.#{node[:cmake][:version][:minor]}/#{cmake_filename}"
  action :create_if_missing
  mode 0644
  notifies :run, "extract", :delayed
end

execute "tar --no-same-owner -zxf #{Chef::Config[:file_cache_path]}/#{cmake_filename}" do
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
end

execute "configure" do
  command "./configure"
  cwd "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
end

execute "make" do
  cwd "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
end

execute "make install" do
  cwd "#{Chef::Config[:file_cache_path]}/#{cmake_dirname}"
end
  
