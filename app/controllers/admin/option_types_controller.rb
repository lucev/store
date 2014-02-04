class Admin::OptionTypesController < AdminController
  # GET /admin/option_types
  # GET /admin/option_types.json
  def index
    @option_types = OptionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @option_types }
    end
  end

  # GET /admin/option_types/1
  # GET /admin/option_types/1.json
  def show
    @option_type = OptionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @option_type }
    end
  end

  # GET /admin/option_types/new
  # GET /admin/option_types/new.json
  def new
    @option_type = OptionType.new
    @option_value = OptionValue.new
    @path = admin_option_types_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @option_type }
    end
  end

  # GET /admin/option_types/1/edit
  def edit
    @option_type = OptionType.find(params[:id])
    @path = admin_option_type_path(@option_type)

    @option_value = OptionValue.new
    @action = :edit
  end

  # POST /admin/option_types
  # POST /admin/option_types.json
  def create
    @option_type = OptionType.new(params[:option_type])

    respond_to do |format|
      if @option_type.save
        format.html { redirect_to admin_option_types_url, notice: 'Option type was successfully created.' }
        format.json { render json: @option_type, status: :created, location: @option_type }
      else
        format.html { render action: "new" }
        format.json { render json: @option_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/option_types/1
  # PUT /admin/option_types/1.json
  def update
    @option_type = OptionType.find(params[:id])

    respond_to do |format|
      if @option_type.update_attributes(params[:option_type])
        format.html { redirect_to admin_option_types_url, notice: 'Option type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @option_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/option_types/1
  # DELETE /admin/option_types/1.json
  def destroy
    @option_type = OptionType.find(params[:id])
    @option_type.destroy

    respond_to do |format|
      format.html { redirect_to admin_option_types_url }
      format.json { head :no_content }
    end
  end

  def create_value
    @option_type = OptionType.find(params[:option_type_id])
    @option_value = OptionValue.new(params[:option_value])

    @option_type.option_values << @option_value
    @option_type.save

    redirect_to edit_admin_option_type_path(@option_type)
  end

  def destroy_value
    @option_type = OptionType.find(params[:option_type_id])
    @option_value = OptionValue.find(params[:id])

    @option_type.option_values.find(@option_value.id).delete

    redirect_to edit_admin_option_type_path(@option_type)
  end
end
