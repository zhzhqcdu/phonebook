class API < Grape::API
  #  before_filter :authenticate_user!, :except => [:login]

  mount Phonebook::Versions
  mount Phonebook::Users
  mount Phonebook::Sessions
  mount Phonebook::Organs


  helpers do

  end

end
