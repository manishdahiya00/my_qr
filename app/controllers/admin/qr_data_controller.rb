module Admin
    class QrDataController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            @qrData = QrDatum.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
        end
        def show
            @qrData = QrDatum.find_by(id:params[:id])
        end
    end
end
