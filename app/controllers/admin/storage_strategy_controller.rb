class Admin::StorageStrategyController < ApplicationController

  before_filter :authorize

  def storage_strategies
    @warehouse = User.find(session[:user_id]).warehouse
    @storage_strategies = @warehouse.storage_strategies
  end
  
  def create_storage_strategy
    @storage_strategy = StorageStrategy.new(params[:storage_strategy])
    if @storage_strategy.save
      redirect_to :controller => 'admin', :action => 'storage_strategy_lines', :storage_strategy => @storage_strategy
    else
      flash[:notice] = "Error creating Storage Strategy. \n" 
      @storage_strategy.errors.each_full {|msg| flash[:notice] += msg + "\n"}  
      redirect_to :controller => 'admin', :action => 'storage_strategies'
    end
  end

  def edit_storage_strategy
    @storage_strategy = StorageStrategy.find(params[:storage_strategy])
  end
  
  def update_storage_strategy
    @storage_strategy = StorageStrategy.find(params[:storage_strategy][:id])
    if @storage_strategy.update_attributes(params[:storage_strategy])
      redirect_to :controller => 'admin', :action => 'storage_strategies'
    else
      flash[:notice] = "Oops.  Something went wrong.  Please try again."
      redirect_to :controller => 'admin', :action => 'edit_storage_strategy', :storage_strategy => @storage_strategy
    end
  end
  
  def delete_storage_strategy
    StorageStrategy.delete(params[:storage_strategy])
    redirect_to :controller => 'admin', :action => 'storage_strategies'
  end
  


end
