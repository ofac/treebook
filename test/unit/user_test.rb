require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "A user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "A user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end  

  test "A user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end  

  test "A user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:ofac).profile_name
  	assert !user.save
  	#puts user.errors.inspect
  	assert !user.errors[:profile_name].empty?
  end   

  test "A user should have a profile name without spaces" do
  	user = User.new(first_name: 'Oscar', last_name: 'Aristizabal', email: 'ofaczero@gmail.com')
    user.password = user.password_confirmation = "12345678"

  	user.profile_name = "My profile name with spaces"
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert  user.errors[:profile_name].include?("Must be formatted correctly.")
  end     

  test "A user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Oscar', last_name: 'Aristizabal', email: 'ofac@gmail.com')
    user.password = user.password_confirmation = '12345678'

    user.profile_name = 'ofac_1'
    assert user.valid?
  end 

end
