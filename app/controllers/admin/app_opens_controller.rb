module Admin
    class AppOpensController < Admin::AdminController
        before_action :authenticate_user!
        layout "admin"

        def index
          #@appOpens = AppOpen.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
          @appOpens = AppOpen.where("created_at >= ?", Date.today).order('created_at desc').paginate(:page => params[:page], :per_page => PER_PAGE)
        end

        def show
          @appOpen = AppOpen.find_by(id: params[:id])
        end
    end
end
