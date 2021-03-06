class Admin::WarehousesController < ApplicationController


  before_filter :authorize

  def index
    @company = User.find(session[:user_id]).company 
  end
  
  def show
    @warehouse = Warehouse.find(params[:id])
  end
  
  def new
    @warehouse = Warehouse.new
  end
  
  def create
    @warehouse = Warehouse.new(params[:warehouse])
    if @warehouse.save
      @warehouse.add_system_parameters
      redirect_to admin_warehouses_path
    else
      flash[:notice] = "Error creating new warehouse.  Please try again."
      render :action => 'add_warehouses'
    end
  end
  
  def edit
    @warehouse = Warehouse.find(params[:id])    
  end
  
  def update
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.update_attributes(params[:warehouse])
      redirect_to admin_warehouses_path
    else
      flash[:notice] = "Error updating warehouse.  Please try again."
      render :action => 'edit_warehouse'
    end
  end
  
  def destroy
    Warehouse.destroy(params[:id])
    redirect_to(admin_warehouses_path)
  end

end
