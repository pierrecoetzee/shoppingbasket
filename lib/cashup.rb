class Cashup
   
   def initialize
     test1
     test2
     test3
   end
   
   def test1
     p1 = FruitTea.new
     p2 = Strawberries.new
     p3 = FruitTea.new
     p4 = JavaCoffee.new
   
     co = Checkout.new()
     co.scan(p1)
     co.scan(p2)
     co.scan(p3)
     co.scan(p4)
     
     puts "Total should be #{co.total == 22.45} on basket one, documentation 22.25"
   end
   
   def test2
     p1 = FruitTea.new
     p2 = FruitTea.new
     
     co = Checkout.new([FruitTeaRule.new])
     co.scan(p1)
     co.scan(p2)
     puts "Total should be #{co.total == 3.11} on basket one"
   end
   
   def test3
     p1 = Strawberries.new
     p2 = Strawberries.new
     p3 = FruitTea.new
     p4 = Strawberries.new
   
     co = Checkout.new([StrawberryRule.new, FruitTeaRule.new ])
     co.scan(p1)
     co.scan(p2)
     co.scan(p3)
     co.scan(p4)

     puts "Total should be #{co.total == 16.61} on basket one"
   end
end

class FruitTea

  def price
    3.11
  end

  def name
   "Fruit Tea"  
  end

  def product_code
   "FR1"
  end
end

class JavaCoffee

  def price
    11.23
  end

  def name
   "Coffee"  
  end

  def product_code
   "CF1"
  end
end

class Strawberries

  def price
    5.00
  end

  def name
   "Strawberries"  
  end

  def product_code
   "SR1"
  end
end

class ProductRule
  
  attr_accessor :price, :discount
 
  def initialize
     # available accross instances
     $total = 0
     @items = 0
  end
  
  def total_charge
    $total
  end
  
  def price(amount)
    $total +=amount
  end
  
  def discount(amount)
    $total  -=  amount
  end
  
end

class StrawberryRule < ProductRule

  def initialize
     @strawberries = 0
     @strawberry_amount = 0
     super
  end
  
  def price(amount)
    @strawberry_amount += amount
    super
  end
  
  def total
    @strawberry_amount
  end
  
  def execute(product)

    return if [JavaCoffee,FruitTea].include?(product.class)

    @strawberries += 1
    self.price(product.price) 
    discount(@strawberries < 3 ? 0 :  ((0.50 ) * @strawberries))
  end
end

class FruitTeaRule < ProductRule
  
  def initialize
    @fruit_teas = 0
    @fruit_teas_amount = 0
    super
  end

  def price(amount)
    @fruit_teas_amount += amount
    super
  end
  
  def total
     @fruit_teas_amount 
  end
  
  def set_count
    @fruit_teas = 0 if @fruit_teas == 2 
  end

  def execute(product)

     return if !product.is_a?(FruitTea)
   
     @fruit_teas += 1
     self.price(product.price)
    
     discount( @fruit_teas == 2 ? product.price : 0  ) 
     set_count
   end
end

# UNCOMMENT THESE TWO LINES TO RUN THIS FILE ON ITS OWN IF YOU PREFER TO JUST SEE THE OUTPUT
# OTHERWISE RUN WITH RSPEC:   rspec --color --format doc spec/
 load 'checkout.rb'
 Cashup.new