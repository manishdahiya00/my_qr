module Admin
    class QrDataController < Admin::AdminController
        before_action :authenticate_user!

        layout "admin"
        def index
            #@qrData = QrDatum.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
            @qrData = QrDatum.where("created_at >= ?", Date.today).order('created_at desc').paginate(:page => params[:page], :per_page => PER_PAGE)
        end
        def show
            @qrData = QrDatum.find_by(id:params[:id])
        end
    end
end
