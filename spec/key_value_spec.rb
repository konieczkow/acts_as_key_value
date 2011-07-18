require 'spec_helper'

describe "Basic Key Value model" do
  before(:each) do
    clean_database!
  end

  context "in general" do

    it "should respond_to get" do
      BasicModel.respond_to?(:"get").should == true
    end

    it "should respond_to set" do
      BasicModel.respond_to?(:"set").should == true
    end

  end

  context "in details" do

    before :each do
      @key = "key"
      @value = "value"
    end

    it "should be able to set value with set" do
      BasicModel.set(@key, @value)
      BasicModel.where(:key => @key).first.value.should == @value
    end

    it "should be able to get value with get" do
      BasicModel.create(:key => @key, :value => @value)
      BasicModel.get(@key).should == @value
    end

    it "should be able to set value with []" do
      BasicModel[@key] = @value
      BasicModel.where(:key => @key).first.value.should == @value
    end

    it "should be able to get value with []" do
      BasicModel.create(:key => @key, :value => @value)
      BasicModel[@key].should == @value
    end

    it "should be able to get object with get(... , :object => true)" do
      BasicModel.create(:key => @key, :value => @value)
      BasicModel.get(@key, :object => true).should == BasicModel.where(:key => @key).first
    end

    it "should override value for given key instead for adding another one (with set)" do
      another_value = 'value2'
      BasicModel.create(:key => @key, :value => @value)
      BasicModel.set(@key, another_value)
      BasicModel.count.should == 1
      BasicModel.where(:key => @key).first.value.should == another_value
    end

    it "should override value for given key instead for adding another one (with [])" do
      another_value = 'value2'
      BasicModel.create(:key => @key, :value => @value)
      BasicModel[@key] = another_value
      BasicModel.count.should == 1
      BasicModel.where(:key => @key).first.value.should == another_value
    end

    it "should return value when assigned with set" do
      BasicModel.set(@key, @value).should == @value
    end

    it "should return value when assigned with []" do
      (BasicModel[@key] = @value).should == @value
    end

    it "should return value when updated with set" do
      BasicModel.create(:key => @key, :value => @value)
      BasicModel.set(@key, @value).should == @value
    end

    it "should return value when updated with []" do
      BasicModel.create(:key => @key, :value => @value)
      (BasicModel[@key] = @value).should == @value
    end

  end

end