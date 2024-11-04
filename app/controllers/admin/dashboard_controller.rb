module Admin
  class DashboardController < Admin::AdminController
      before_action :authenticate_user!
	  layout "admin"
	  
	def index
	  @deviceDetail = DeviceDetail.count
	  @userDetail = UserDetail.count
	  @qrData = RecentlyAdded.count
	  @appBanner = AppBanner.count
	  @redeemRequests = Redeem.where(status: "PENDING").count
	end
  end
end
