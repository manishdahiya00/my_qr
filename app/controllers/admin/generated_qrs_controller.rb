module Admin
    class GeneratedQrsController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            @generatedQr = GeneratedQr.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
        end
        def show
            @generatedQr = GeneratedQr.find_by(id:params[:id])
        end
    end
end
