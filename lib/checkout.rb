
class Checkout
  attr_reader :total
  
  def initialize(price_rule = [])
    @rule,@items = [],[]
    @rule = price_rule
    @discounted_total = 0
  end
  
  def scan(product_item)
    @items << product_item
  end
  
  def total
    calculate_total
    @discounted_total
  end
  
  private
  
  def calculate_total
     @discounted_total = 0 
     @items.sort!{|a,b| b.class.name <=> a.class.name }.each do |p| 
          @rule.each do |r|
             r.execute(p)
             @discounted_total = r.send(:total_charge)
          end
          
          @discounted_total += p.price if @rule.length==0
     end
     puts "Total amount charged: #{@discounted_total}"
     
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