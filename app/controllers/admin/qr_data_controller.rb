module Admin
    class QrDataController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            @qrData = QrDatum.all.order("id DESC")
        end
        def show
            @qrData = QrDatum.find_by(id:params[:id])
        end
    end
end
