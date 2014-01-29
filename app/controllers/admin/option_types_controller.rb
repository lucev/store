class Admin::OptionTypesController < ApplicationController
  # GET /admin/option_types
  # GET /admin/option_types.json
  def index
    @admin_option_types = Admin::OptionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_option_types }
    end
  end

  # GET /admin/option_types/1
  # GET /admin/option_types/1.json
  def show
    @admin_option_type = Admin::OptionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_option_type }
    end
  end

  # GET /admin/option_types/new
  # GET /admin/option_types/new.json
  def new
    @admin_option_type = Admin::OptionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_option_type }
    end
  end

  # GET /admin/option_types/1/edit
  def edit
    @admin_option_type = Admin::OptionType.find(params[:id])
  end

  # POST /admin/option_types
  # POST /admin/option_types.json
  def create
    @admin_option_type = Admin::OptionType.new(params[:admin_option_type])

    respond_to do |format|
      if @admin_option_type.save
        format.html { redirect_to @admin_option_type, notice: 'Option type was successfully created.' }
        format.json { render json: @admin_option_type, status: :created, location: @admin_option_type }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_option_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/option_types/1
  # PUT /admin/option_types/1.json
  def update
    @admin_option_type = Admin::OptionType.find(params[:id])

    respond_to do |format|
      if @admin_option_type.update_attributes(params[:admin_option_type])
        format.html { redirect_to @admin_option_type, notice: 'Option type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_option_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/option_types/1
  # DELETE /admin/option_types/1.json
  def destroy
    @admin_option_type = Admin::OptionType.find(params[:id])
    @admin_option_type.destroy

    respond_to do |format|
      format.html { redirect_to admin_option_types_url }
      format.json { head :no_content }
    end
  end
end
