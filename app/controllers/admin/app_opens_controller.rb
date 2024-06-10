module Admin
    class AppOpensController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            @appOpens = AppOpen.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
        end
        def show
            @appOpen = AppOpen.find_by(id: params[:id])
        end
    end
end
