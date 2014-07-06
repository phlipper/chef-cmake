require "spec_helper"

describe "cmake::_package" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "installs the `cmake` package" do
    expect(chef_run).to install_package "cmake"
  end
end
