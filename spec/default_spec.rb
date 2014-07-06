require "spec_helper"

describe "cmake::default" do
  describe "default package installation" do
    let(:chef_run) do
      ChefSpec::Runner.new.converge(described_recipe)
    end

    it "includes the `_package` recipe" do
      expect(chef_run).to include_recipe "cmake::_package"
    end
  end

  describe "source installation" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["cmake"]["install_method"] = "source"
        node.set["cmake"]["source"]["version"] = "1.2.3"
      end.converge("build-essential", described_recipe)
    end

    it "includes the `_source` recipe" do
      expect(chef_run).to include_recipe "cmake::_source"
    end
  end
end
