require "spec_helper"

describe "cmake::_source" do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set["cmake"]["install_method"] = "source"
      node.set["cmake"]["source"]["version"] = "1.2.3"
    end.converge("build-essential", described_recipe)
  end

  it "downloads the source tarball" do
    filename = "/var/chef/cache/cmake-1.2.3.tar.gz"
    resource = chef_run.remote_file(filename)

    expect(chef_run).to create_remote_file filename

    expect(resource).to notify("execute[unpack cmake]").to(:run)
  end

  it "unpacks the tarball when told" do
    resource = chef_run.execute "unpack cmake"

    expect(resource).to do_nothing
    expect(chef_run).to_not run_execute "unpack cmake"

    expect(resource).to notify("execute[configure cmake]").to(:run)
    expect(resource).to notify("execute[make cmake]").to(:run)
    expect(resource).to notify("execute[make install cmake]").to(:run)
  end

  it "does the configure/make/make install dance when told" do
    expect(chef_run.execute "configure cmake").to do_nothing
    expect(chef_run.execute "make cmake").to do_nothing
    expect(chef_run.execute "make install cmake").to do_nothing

    expect(chef_run).to_not run_execute "configure cmake"
    expect(chef_run).to_not run_execute "make cmake"
    expect(chef_run).to_not run_execute "make install cmake"
  end
end
