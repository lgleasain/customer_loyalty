module RequestMacros
  def login_customer
    before do
      @customer = FactoryGirl.create(:customer)
      visit(new_user_session_path)
      fill_in('user_email', :with => @customer.email)
      fill_in('user_password', :with => 'abc123') #defined in user factory
      check('user[remember_me]')
      click_on('Sign in')
    end
  end

  def login_merchant
    before do
      @merchant = FactoryGirl.create(:merchant)
      visit(new_user_session_path)
      fill_in('user_email', :with => @merchant.email)
      fill_in('user_password', :with => 'abc123') #defined in user factory
      check('user[remember_me]')
      click_on('Sign in')
    end
  end
end
