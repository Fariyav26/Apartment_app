class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]
  
  before_action :authenticate_user!, except: [:index, :show, :map_location, :map_location_all, :destroy] #add this line

  # GET /apartments
  # GET /apartments.json
  def index
    @apartments = Apartment.all
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
  end

  # GET /apartments/new
  def new
    @apartment = Apartment.new
    @apartment.user = current_user
  end

  def map_location
    @apartment = Apartment.find(params[:apartment_id])
    @hash = Gmaps4rails.build_markers(@apartment) do |apartment, marker|
      marker.lat(apartment.latitude)
      marker.lng(apartment.longitude)
      marker.infowindow("<em>" + apartment.full_address + "</em>")
    end
    render json: @hash.to_json
  end
  # used apartment.all because we did not need to find a specific id
  def map_location_all
    apartments = Apartment.all
    @hash = Gmaps4rails.build_markers(apartments) do |apartment, marker|
      marker.lat(apartment.latitude)
      marker.lng(apartment.longitude)
      marker.infowindow("<em>" + apartment.full_address + "</em>")
    end
    render json: @hash.to_json
  end

  # GET /apartments/1/edit
  def edit
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.user = current_user

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    if user_signed_in?
      @apartment.destroy
      respond_to do |format|
        format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      # Do not destroy
      render text: "Not authorized"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:street1, :street2, :city, :postal, :state, :country, :contact_name, :phone, :hours, :latitude, :longitude, :image)
    end
end
