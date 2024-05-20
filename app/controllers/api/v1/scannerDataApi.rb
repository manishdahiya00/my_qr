module API
  module V1
    class ScannerDataApi < Grape::API
      format :json
      prefix :api
      version :v1

      resources :scannerData do
        desc "Create Qr Code History"
        params do
          requires :deviceId,type:String,allow_blank: false
          requires :securityToken,type:String,allow_blank: false
          requires :versionName,type:String,allow_blank: false
          requires :versionCode,type:String,allow_blank: false
          requires :data,type:String,allow_blank: false
          requires :qrType,type:String,allow_blank: false
          requires :userId, type: String, allow_blank: true

        end

        post do
          begin
            @device_detail = DeviceDetail.find_by(deviceId: params[:deviceId],security_token: params[:securityToken])
            @recently_added =  @device_detail.recently_added.create(
              title:params[:qrType],
              subtitle:params[:data],
              qrType: params[:qrType])
            @qrData = @device_detail.qr_data.create(
              id: @recently_added.id,
              device_detail_id: params[:deviceId],
              securityToken: params[:securityToken],
              versionName: params[:versionName],
              versionCode: params[:versionCode],
              codeData: params[:data])

            {status:200,message:"Success"}
          rescue Exception => e
            {status:500,message:e}
          end
        end

      end

    end
  end
end
