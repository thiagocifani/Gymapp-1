class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    if params[:employee] && params[:employee].key?(:q)
      q = params[:employee][:q]

      @employees = Employee.where('name LIKE ?', "%#{q}%").order('name ASC').paginate(:page => params[:page])
    else
      @employees = Employee.all.order('name ASC').paginate(:page => params[:page])
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    authorize @employee
  end

  # GET /employees/1/edit
  def edit
    authorize @employee
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    authorize @employee, :create?

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Funcionário criado com sucesso.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    authorize @employee, :update?
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Funcionário atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    if @employee.active
      @employee.update_attribute(:active, false)
      redirect_to employees_path(employee_id: @employee.id),
      notice: 'Funcionário desativado com sucesso'
    elsif !@employee.active
      @employee.update_attribute(:active, true)
      redirect_to employees_path(employee_id: @employee.id),
      notice: 'Funcionário reativado com sucesso'
    else
      redirect_to clients_path(client_id: @client.id),
      alert: 'Algum problema ocorreu tentando desativar o funcionário'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :position, :birth_date, :rg, :cpf, :telephone, :admission_date, :avatar,
       :email, :password, :password_confirmation)
    end
  end
