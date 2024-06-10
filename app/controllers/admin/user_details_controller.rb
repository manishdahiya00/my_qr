module Admin
    class UserDetailsController < Admin::AdminController
      before_action :authenticate_user!

        layout "admin"
      def index
        @userDetails = UserDetail.all.order(id: :desc).paginate(:page => params[:page], :per_page => 10)
      end

      def show
        @userDetail = UserDetail.find_by(id: params[:id])
        @transactionHistories = @userDetail.transaction_histories.limit(20).order(id: :desc).paginate(:page => params[:page], :per_page => 10)
        @redeems = @userDetail.redeems.limit(20).order(id: :desc).paginate(:page => params[:page], :per_page => 10)
      end
    end
  end
