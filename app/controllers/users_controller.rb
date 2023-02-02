class UsersController < ApplicationController
    def index
        @users=User.all
    end

    def new
        @user=User.new
    end

    def create
        @user=User.new(user_params)
        if @user.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show
        @products=Product.all
        @user=User.find(params[:id])
        @addresses=current_user.address.all
        
    end
    private
    def user_params
        params.require(:user).permit(:name, :email, :phone)
    end
end
