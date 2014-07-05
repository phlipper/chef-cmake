require "spec_helper"

describe "Package installation" do
  it "installed the `cmake` package" do
    expect(package "cmake").to be_installed
  end
end
