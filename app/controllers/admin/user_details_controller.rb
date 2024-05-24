module Admin
    class UserDetailsController < Admin::AdminController
      before_action :authenticate_user!

        layout "admin"
      def index
        @userDetails = UserDetail.all.order(id: :desc)
      end

      def show
        @userDetail = UserDetail.find_by(id: params[:id])
        @transactionHistories = @userDetail.transaction_histories.limit(20)
        @redeems = @userDetail.redeems.limit(20)
      end
    end
  end
