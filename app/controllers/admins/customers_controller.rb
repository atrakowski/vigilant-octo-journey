class Admins::CustomersController < Admins::ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :unlock]

  def index
    @customers = Customer.all.order(email: :asc)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_create_params)
    @customer.skip_confirmation!

    respond_to do |format|
      if @customer.save
        format.html { redirect_to admin_customer_url(@customer), notice: t(".success") }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @customer.skip_reconfirmation!

    respond_to do |format|
      if @customer.update(customer_update_params)
        format.html { redirect_to admin_customer_url(@customer), notice: t(".success") }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to admin_customers_url, notice: t(".success") }
      format.json { head :no_content }
    end
  end

  def unlock
    @customer.unlock_access!

    respond_to do |format|
      format.html { redirect_to admin_customers_url, notice: t(".success") }
      format.json { head :no_content }
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :born_on,
      :street,
      :zip_code,
      :city,
      :approved,
      :confirmed_at,
    )
  end
  alias_method :customer_create_params, :customer_params

  def customer_update_params
    result = customer_params
    if result[:password].blank?
      result.delete(:password)
      result.delete(:password_confirmation) if result[:password_confirmation].blank?
    end
    result
  end
end
