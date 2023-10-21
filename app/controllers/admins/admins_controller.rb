class Admins::AdminsController < Admins::ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @admins = Admin.all.order(email: :asc)
  end

  def show
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_create_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_admin_url(@admin), notice: t(".success") }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin.update(admin_update_params)
        format.html { redirect_to admin_admin_url(@admin), notice: t(".success") }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admin_admins_url, notice: t(".success") }
      format.json { head :no_content }
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(
      :email,
      :username,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :born_on,
      :street,
      :zip_code,
      :city,
    )
  end
  alias_method :admin_create_params, :admin_params

  def admin_update_params
    result = admin_params
    if result[:password].blank?
      result.delete(:password)
      result.delete(:password_confirmation) if result[:password_confirmation].blank?
    end
    result
  end
end
