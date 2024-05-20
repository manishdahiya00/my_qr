module API
  module V1
    class FavouriteApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :addFavourites do
        desc "Add Favourites API"
        params do
          requires :deviceId,type:String,allow_blank: false
          requires :securityToken,type:String,allow_blank: false
          requires :versionName,type:String,allow_blank: false
          requires :versionCode,type:String,allow_blank: false
          requires :qrCodeId,type:String,allow_blank: false
          requires :addFavourite,type:Boolean,allow_blank: false
          requires :userId, type: String, allow_blank: true

        end
        post do
          begin
            @device_details = DeviceDetail.find_by(deviceId: params[:deviceId],security_token: params[:securityToken])
            @generated_qr = GeneratedQr.find(params[:qrCodeId])
            @isFavourite = Favourite.find_by(qr_code_id: params[:qrCodeId],deviceId: params[:deviceId])
            if params[:addFavourite] == true
              if @isFavourite.present?
                {status:200,message:"Success",isFavourite:true}
              else
                @favourites = @device_details.favourites.create(
                  id: @generated_qr.id,
                  deviceId:params[:deviceId],
                  versionName:params[:versionName],
                  versionCode:params[:versionCode],
                  qr_code_id:@generated_qr.id,
                  device_detail_id:@device_details.id,
                  )
                {status:200,message:"Success",isFavourite:true}
              end
            else
              if !@isFavourite.present?
                {status:200,message:"Success",isFavourite:false}
              else
                @isFavourite.destroy
              {status:200,message:"Success",isFavourite:false}
              end

            end
          rescue Exception => e
            {status:500,message:e}
          end
        end
      end
    end
  end
end