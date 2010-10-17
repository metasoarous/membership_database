class VolunteerCategoriesController < ApplicationController
  # GET /volunteer_categories
  # GET /volunteer_categories.xml
  def index
    @volunteer_categories = VolunteerCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteer_categories }
    end
  end

  # GET /volunteer_categories/1
  # GET /volunteer_categories/1.xml
  def show
    @volunteer_category = VolunteerCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @volunteer_category }
    end
  end

  # GET /volunteer_categories/new
  # GET /volunteer_categories/new.xml
  def new
    @volunteer_category = VolunteerCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @volunteer_category }
    end
  end

  # GET /volunteer_categories/1/edit
  def edit
    @volunteer_category = VolunteerCategory.find(params[:id])
  end

  # POST /volunteer_categories
  # POST /volunteer_categories.xml
  def create
    @volunteer_category = VolunteerCategory.new(params[:volunteer_category])

    respond_to do |format|
      if @volunteer_category.save
        format.html { redirect_to(@volunteer_category, :notice => 'Volunteer category was successfully created.') }
        format.xml  { render :xml => @volunteer_category, :status => :created, :location => @volunteer_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @volunteer_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /volunteer_categories/1
  # PUT /volunteer_categories/1.xml
  def update
    @volunteer_category = VolunteerCategory.find(params[:id])

    respond_to do |format|
      if @volunteer_category.update_attributes(params[:volunteer_category])
        format.html { redirect_to(@volunteer_category, :notice => 'Volunteer category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @volunteer_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteer_categories/1
  # DELETE /volunteer_categories/1.xml
  def destroy
    @volunteer_category = VolunteerCategory.find(params[:id])
    @volunteer_category.destroy

    respond_to do |format|
      format.html { redirect_to(volunteer_categories_url) }
      format.xml  { head :ok }
    end
  end
end
