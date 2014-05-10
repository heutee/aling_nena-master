require 'sinatra'
require './boot.rb'
require './money_calculator.rb'


get '/' do
  products = Item.all
  @rand_products = products.sample(10)
  erb :index
end

get '/about' do
  erb :about
end

get '/products' do
  @products = Item.all
  erb :products
end

get '/purchase/:id' do
  @product = Item.find(params[:id])
  if @product == nil
    @message = "Item not found!"
    erb :error
  else
    erb :buy_product
  end
end

post '/purchased/:id' do
  @product = Item.find(params[:id])
  if @product == nil
    @message = "Item not found!"
    erb :error
  else
    @to_buy = params[:to_buy].to_i
    amt_due = @to_buy*@product.price.to_i
    @cash = MoneyCalculator.new(params[:ones].to_i, params[:fives].to_i, params[:tens].to_i, params[:twenties].to_i, params[:fifties].to_i, params[:hundreds].to_i, params[:five_hundreds].to_i, params[:thousands].to_i)

    if @to_buy > @product.quantity
      @message = "Not enough of #{@product.name} in stock!"
      erb :error
    elsif @cash.total_paid < amt_due
      @message = "The amount you gave was not enough for your purchase."
      erb :error
    else
      new_quan = @product.quantity - @to_buy
      num_sold = @product.sold + @to_buy
      @product.update_attributes!(
      quantity: new_quan,
      sold: num_sold,
      )   
      @change = @cash.change(amt_due)
      @change_amt = @cash.total_change
      erb :product_bought
    end
  end
end

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION
