module Admin
    class DeviceDetailsController < Admin::AdminController
        before_action :authenticate_user!
        layout "admin"
        def index
            @deviceDetails = DeviceDetail.all.order("id DESC")
        end
        def show
            @deviceDetail = DeviceDetail.find_by(id:params[:id])
            @qrCodes = RecentlyAdded.where(device_detail_id: @deviceDetail.id)
            @favourites = Favourite.where(device_detail_id: @deviceDetail.id)
        end
    end
end
