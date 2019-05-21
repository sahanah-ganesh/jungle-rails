require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create new product if validations true' do
      @category = Category.new(name: 'Props')
      @product = Product.new(name: 'Blue Suede Shoes', price: 10, quantity: 20, :category => @category)
      @product.valid?
      expect(@product.errors).not_to include('blank exists')
    end
    it 'should have a name to exist' do
      @category = Category.new(name: 'Props')
      @product = Product.new(price: 10, quantity: 20, :category => @category)
      @product.valid?
      expect(@product.errors[:name]).to include('blank exists')
    end
    it 'should have a price to exist' do
      @category = Category.new(name: 'Props')
      @product = Product.new(name: 'Blue Suede Shoes', quantity: 20, :category => @category)
      @product.valid?
      expect(@product.errors[:price]).to include('blank exists')
    end
    it 'should have a quantity to exist' do
      @category = Category.new(name: 'Props')
      @product = Product.new(name: 'Blue Suede Shoes', price: 10, :category => @category)
      @product.valid?
      expect(@product.errors[:quantity]).to include('blank exists')
    end
    it 'should have a category to exist' do
      @category = Category.new(name: 'Props')
      @product = Product.new(name: 'Blue Suede Shoes', price: 10, quantity: 20)
      @product.valid?
      expect(@product.errors[:category]).to include('blank exists')
    end
  end
end
