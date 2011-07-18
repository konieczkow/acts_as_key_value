require 'spec_helper'

describe "Basic Key Value model" do
  before :all do
  end

  context "BasicModel in general" do

    it "should respond_to get" do
      BasicModel.respond_to?(:"get").should == true
    end

    it "should respond_to set" do
      BasicModel.respond_to?(:"set").should == true
    end

  end

  context "BasicModel in details" do
    before :each do
      basic_model = BasicModel.create
    end

    it "should be able to set value" do

    end
  end

end