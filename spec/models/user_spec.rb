require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'creates user if validations true' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.valid?
      expect(@user.errors).not_to include('blanks exist')
    end
    it 'error if no name' do
      @user = User.new(email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.valid?
      expect(@user.errors[:name]).to include('blanks exist')
    end
    it 'error if no password' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password_confirmation: 'AWESOMES')
      @user.valid?
      expect(@user.errors[:password]).to include('blanks exist')
    end
    it 'error if no password_confirmation' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES')
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include('blanks exist')
    end
    it 'error if no email' do
      @user = User.new(name: 'Jake', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.valid?
      expect(@user.errors[:email]).to include('blanks exist')
    end
    it 'error if passwords do not match' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMESS')
      @user.valid?
      expect(@user.errors[:password_digest]).to include('no match')
    end
    it 'error if passwords too short' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOME', password_confirmation: 'AWESOME')
      @user.valid?
      expect(@user.errors[:password]).to include('too short 8 char min')
    end
    it 'error if email exists' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.save
      @user2 = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user2.valid?
      expect(@user2.errors[:email]).to include('already exists')
    end
  end

  describe '.user_authenticated' do
    it 'authenticate if pass and email valid' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.save
      @valid = User.user_authenticated('jakey@j.com', 'AWESOMES')
      expect(@valid).to eq(@user)
    end
    it 'authenticate if email uppercase' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.save
      @valid = User.user_authenticated('JAKEY@j.com', 'AWESOMES')
    end
    it 'authenticate if email space' do
      @user = User.new(name: 'Jake', email: 'jakey@j.com', password: 'AWESOMES', password_confirmation: 'AWESOMES')
      @user.save
      @valid = User.user_authenticated('    JAKEY@j.com', 'AWESOMES')
    end
  end
end
