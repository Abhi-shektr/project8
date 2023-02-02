class Api::V1::AddressesController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error

    def new
        @address=Address.new
        render json: {address: @address},status: :ok
    end

    def create
        
        if user_signed_in?
            @user=User.find(params[:id])
            @address=@user.address.create(house: params[:address][:house], street: params[:address][:street],city: params[:address][:city],state: params[:address][:state])
            render json: {address: @@address}
        else
            @seller=Seller.find(params[:id])
            @address=@seller.address.create(house: params[:address][:house], street: params[:address][:street],city: params[:address][:city],state: params[:address][:state])
            render json: {address: @address}
        end
    end

    def destroy
        
        @address=Address.find(params[:id])
        @address.destroy
        if user_signed_in?
            render json: {address: @address}
        else
            render json: {address: @address}
        end
    end

    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end
end
