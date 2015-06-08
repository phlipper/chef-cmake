#
# Cookbook:: cmake
# Recipe:: _binary
#

cache_dir = Chef::Config[:file_cache_path]
cmake_platform = node["cmake"]["binary"]["platform"]
cmake_arch     = node["cmake"]["binary"]["architecture"]
cmake_repo     = node["cmake"]["binary"]["repo"]
cmake_prefix   = node["cmake"]["binary"]["prefix"]

package "git" do
  action :install
  only_if { node["cmake"]["binary"]["version"] == "LATEST" }
end

ruby_block "get latest" do
  block do
    if node["cmake"]["binary"]["version"] == "LATEST"
      vers = []
      IO.popen("git ls-remote -t #{cmake_repo}").each do |line|
        m = line.match(%r{^\S+\s+refs\/tags\/v(\d+.\d+.\d+)$})
        if m
          vers.push(Gem::Version.new(m[1])) # sort semver-ly
        end
      end
      vers.sort
      node.set["cmake"]["binary"]["version"] = vers[-1].to_s
    end
    node.set["cmake"]["binary"]["sh"] = "cmake-#{node['cmake']['binary']['version']}-#{cmake_platform}-#{cmake_arch}.sh" # rubocop:disable LineLength
  end
end

remote_file "get sh" do
  path lazy { "#{cache_dir}/#{node['cmake']['binary']['sh']}" }
  source lazy { "http://www.cmake.org/files/v#{node['cmake']['binary']['version'][/^\d\.\d/, 0]}/#{node['cmake']['binary']['sh']}" } # rubocop:disable LineLength
end

directory "prefix" do
  path lazy { cmake_prefix }
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute "cmake install" do
  command lazy { "bash #{cache_dir}/#{node['cmake']['binary']['sh']} --prefix=#{cmake_prefix} --exclude-subdir" } # rubocop:disable LineLength
  cwd "/tmp"
  creates "#{cmake_prefix}/bin/cmake"
end
