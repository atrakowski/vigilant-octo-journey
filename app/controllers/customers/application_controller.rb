class Customers::ApplicationController < ApplicationController
  before_action :authenticate_customer!
end
