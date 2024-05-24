module Admin
    class RecentlyAddedsController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            @recentlyAdded = RecentlyAdded.all.order("id DESC")
        end
        def show
            @recentlyAdded = RecentlyAdded.find_by(id:params[:id])
        end
    end
end
