module API
  module V1
    class FavouriteApi < Grape::API
      prefix :api
      version :v1
      format :json

      resources :add_favourites do
        params do
          requires :deviceId,type:String,allow_blank: false
          requires :securityToken,type:String,allow_blank: false
          requires :versionName,type:String,allow_blank: false
          requires :versionCode,type:String,allow_blank: false
          requires :qrCodeId,type:String,allow_blank: false
        end
        post do
          begin
            @device_details = DeviceDetail.find_by(deviceId: params[:deviceId],security_token: params[:securityToken])
            @generated_qr = GeneratedQr.find(params[:qrCodeId])
            @favourites = @device_details.favourites.create(
              deviceId:params[:deviceId],
              versionName:params[:versionName],
              versionCode:params[:versionCode],
              qr_code_id:@generated_qr.id,
              device_detail_id:@device_details.id,
            )
            {status:200,message:"Success"}
          rescue Exception => e
            {status:500,message:e}
          end
        end
      end
      resources :favourites do
        params do
          requires :deviceId,type:String,allow_blank: false
        end
        post do
          @favourites = Favourite.where(deviceId: params[:deviceId])
          {status:200,message:"Success",favourites: @favourites}
        end
      end

    end
  end
end