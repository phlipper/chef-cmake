require "spec_helper"

describe "cmake::_binary" do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set["cmake"]["install_method"] = "binary"
    end.converge("git", described_recipe)
  end

end
