class MoneyCalculator
attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands, :total_paid

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
    
    @ones = ones
    @fives = fives
    @tens = tens
    @twenties = twenties
    @fifties = fifties
    @hundreds = hundreds
    @five_hundreds = five_hundreds
    @thousands = thousands
	

    @total_paid = ones*1 + fives*5 + tens*10 + twenties*20 + fifties*50 + hundreds*100 + five_hundreds*500 + thousands*1000
  end

  def change(amt_due)
  	to_change = @total_paid - amt_due
  	
    if to_change >= 1000
        @thousands = to_change/1000
        to_change = to_change%1000
    end 
    if to_change >= 500
        @five_hundreds = to_change/500
        to_change = to_change%500
    end 
    if to_change >= 100
        @hundreds = to_change/100
        to_change = to_change%100
    end 
    if to_change >= 50
        @fifties = to_change/50
        to_change = to_change%50
    end 
    if to_change >= 20
        @twenties = to_change/20
        to_change = to_change%20
    end 
    if to_change >= 10
        @tens = to_change/10
        to_change = to_change%10
    end 
    if to_change >= 5
        @fives = to_change/5
        to_change = to_change%5
    end 
    @ones = to_change
    
  	@change = {
  		:ones => @ones,
  		:fives => @fives,
  		:tens => @tens,
  		:twenties => @twenties,
  		:fifties => @fifties,
  		:hundreds => @hundreds,
  		:five_hundreds => @five_hundreds,
  		:thousands => @thousands,
  	}

  	return @change
  end
end