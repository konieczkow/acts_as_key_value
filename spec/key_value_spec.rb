require 'spec_helper'

describe "Model with acts as key value" do
  before :each do
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
      @basic  = BasicModel.create(:key => @key, :value => @value)
      @object = TrueObject.create(:key => @key, :value => @value)
    end

    context "with :object => true" do
      it "should be able to get object with get" do
        TrueObject.get(@key).should == @object
      end

      it "should be able to get object with []" do
        TrueObject[@key].should == @object
      end

      it "should be able to get value with get(... , :value => true)" do
        TrueObject.get(@key, :value => true).should == @object.value
      end

      it "should return object when created with set" do
        another_key = 'key2'
        TrueObject.set(another_key, @value).should == TrueObject.where(:key => another_key).first
      end

      it "should return object when updated with set" do
        TrueObject.set(@key, @value).should == TrueObject.where(:key => @key).first
      end

      it "should return value when created with set(... , :value => true)" do
        another_key = 'value2'
        TrueObject.set(another_key, @value, :value => true).should == TrueObject.where(:key => another_key).first.value
      end

      it "should return value when updated with set(... , :value => true)" do
        TrueObject.set(@key, @value, :value => true).should == TrueObject.where(:key => @key).first.value
      end
    end

    it "should be able to set value with set" do
      BasicModel.set(@key, @value)
      BasicModel.where(:key => @key).first.value.should == @value
    end

    it "should be able to get value with get" do
      BasicModel.get(@key).should == @value
    end

    it "should be able to set value with []" do
      BasicModel[@key] = @value
      BasicModel.where(:key => @key).first.value.should == @value
    end

    it "should be able to get value with []" do
      BasicModel[@key].should == @value
    end

    it "should be able to get object with get(... , :object => true)" do
      BasicModel.get(@key, :object => true).should == BasicModel.where(:key => @key).first
    end

    it "should override value for given key instead for adding another one (with set)" do
      another_value = 'value2'
      BasicModel.set(@key, another_value)
      BasicModel.count.should == 1
      BasicModel.where(:key => @key).first.value.should == another_value
    end

    it "should override value for given key instead for adding another one (with [])" do
      another_value = 'value2'
      BasicModel[@key] = another_value
      BasicModel.count.should == 1
      BasicModel.where(:key => @key).first.value.should == another_value
    end

    it "should return value when created with set" do
      another_key = "key2"
      BasicModel.set(another_key, @value).should == @value
    end

    it "should return value when updated with set" do
      BasicModel.set(@key, @value).should == @value
    end

    it "should return object when created with set(... , :object => true)" do
      another_key = "key2"
      BasicModel.set(another_key, @value, :object => true).should == BasicModel.where(:key => another_key).first
    end

    it "should return object when updated with set(... , :object => true)" do
      BasicModel.set(@key, @value, :object => true).should == BasicModel.where(:key => @key).first
    end


  end

end