module Admin
    class DeviceDetailsController < Admin::AdminController
        before_action :authenticate_user!
        layout "admin"
        def index
            @deviceDetails = DeviceDetail.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
        end
        def show
            @deviceDetail = DeviceDetail.find_by(id:params[:id])
            @qrCodes = RecentlyAdded.where(device_detail_id: @deviceDetail.id).order(id: :desc).paginate(:page => params[:page], :per_page => 10)
            @favourites = Favourite.where(device_detail_id: @deviceDetail.id).order(id: :desc).paginate(:page => params[:page], :per_page => 10)
            @user_id = @deviceDetail.user_detail_id.split(",").last
            @appOpen = AppOpen.where(deviceId: @deviceDetail.deviceId).paginate(:page => params[:page], :per_page => 10)
            if @user_id.present?
                @userDetail = UserDetail.find(@user_id)
                @transactionHistories = @userDetail.transaction_histories.limit(20).order(id: :desc).paginate(:page => params[:page], :per_page => 10)
                @redeems = @userDetail.redeems.limit(20).order(id: :desc).paginate(:page => params[:page], :per_page => 10)
            end
        end
    end
end
