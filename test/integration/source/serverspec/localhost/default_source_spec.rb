require "spec_helper"

describe "Source installation" do
  it "installed `cmake`" do
    expect(command "cmake --version").to return_stdout "cmake version 2.8.12.2"
  end
end
