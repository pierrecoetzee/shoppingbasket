require 'spec_helper'

require 'product'

describe "products" do
  it "should contain all the specified products" do
    products = Product.all
    products.length.should == 3
  end
  
  it "the products must include a price for strawberries" do
    product = Product.all
    product[:strawberries].should_not be_nil
    product[:fruit_tea].should_not be_nil
    product[:coffee].should_not be_nil
  end
  
end