module Admin
    class FavouritesController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            @favourites = Favourite.all.order("id DESC")
        end
        def show
            @favourite = Favourite.find_by(id:params[:id])
        end
    end
end
