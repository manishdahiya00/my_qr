module Admin
    class RecentlyAddedsController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            #@recentlyAdded = RecentlyAdded.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
            @recentlyAdded = RecentlyAdded.where("created_at >= ?", Date.today).order('created_at desc').paginate(:page => params[:page], :per_page => PER_PAGE)
        end
        def show
            @recentlyAdded = RecentlyAdded.find_by(id:params[:id])
        end
    end
end
