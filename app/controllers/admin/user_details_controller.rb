module Admin
    class UserDetailsController < Admin::AdminController
      before_action :authenticate_user!
      layout "admin"

      def index2
        @userDetails = UserDetail.all.order(id: :desc).paginate(:page => params[:page], :per_page => 10)
      end

      def index
        if params[:search]      
          if params[:search] == 'top'        
            sql = "SELECT count(1), utm_medium FROM user_details WHERE created_at > DATE_SUB(NOW(), INTERVAL 3 DAY) GROUP BY utm_medium ORDER BY count(1) DESC LIMIT 100;"
            @results = ActiveRecord::Base.connection.execute(sql)        
          else
            @userDetails = UserDetail.search(params[:search]).order("created_at desc").paginate(:page => params[:page], :per_page => PER_PAGE)
          end  
        else
          #@users = User.all.order('created_at desc').paginate(:page => params[:page], :per_page => PER_PAGE)
          @userDetails = UserDetail.where("created_at >= ?", Date.today).order('created_at desc').paginate(:page => params[:page], :per_page => PER_PAGE)
        end  
      end

      def show
        @userDetail = UserDetail.find_by(id: params[:id])
        @transactionHistories = @userDetail.transaction_histories.limit(20).order(id: :desc).paginate(:page => params[:page], :per_page => PER_PAGE)
        @redeems = @userDetail.redeems.limit(20).order(id: :desc).paginate(:page => params[:page], :per_page => PER_PAGE)
      end
    end
  end
