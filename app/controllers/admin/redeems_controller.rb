module Admin
  class RedeemsController < Admin::AdminController
    before_action :authenticate_user!

    layout "admin"

    def edit
      @redeem = Redeem.find(params[:id])
    end

    def update
      @redeem = Redeem.find(params[:id])
      if @redeem.update(redeem_params)
        redirect_to admin_user_detail_path(@redeem.user_detail_id)
      else
        render :edit
      end
    end

    private
    def redeem_params
      params.require(:redeem).permit(:status)
    end
  end
end
