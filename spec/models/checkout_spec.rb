# PLEAE RUN THIS FILE:    rspec --color --format doc spec/     FROM THE COMMAND LINE

require 'checkout'

describe "checkout" do

    it "should scan and calculate basket one correctly as 22.45 - documentation 22.25" do  
      p1 = FruitTea.new
      p2 = Strawberries.new
      p3 = FruitTea.new
      p4 = JavaCoffee.new
      
      # use the rules that would apply
      co = Checkout.new()
      co.scan(p1)
      co.scan(p2)
      co.scan(p3)
      co.scan(p4)
      # NOTE TO DEVELOPER --- I AM CERTAIN THAT THE DOCUMENTATION IS INCORRCT
      # NO COMBINATION OF THE DOCUMENTED PRODUCT PRICES WILL GIVE £22.25
      # I MIGHT BE WRONG....BUT I BET A TRAY OF MOMS BEST COOKIES I AM RIGHT
      co.total.should == 22.45
    
    end
        
    it "should csan and calculate basket two correctly as 3.11 as two for one" do  
      p1 = FruitTea.new
      p2 = FruitTea.new
      
      # use the rules that would apply      
      co = Checkout.new([FruitTeaRule.new])
      co.scan(p1)
      co.scan(p2)
      co.total.should == 3.11
    end

    it "should scan and calculate basket three correctly as 16.61" do  
      p1 = Strawberries.new
      p2 = Strawberries.new
      p3 = FruitTea.new
      p4 = Strawberries.new
      
      # use the rules that would apply
      co = Checkout.new([StrawberryRule.new, FruitTeaRule.new ])
      co.scan(p1)
      co.scan(p2)
      co.scan(p3)
      co.scan(p4)
      co.total.should == 16.61
    end

end


