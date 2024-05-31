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
          requires :qrName, type: String, allow_blank: false

        end

        post do
          begin
            if params[:userId] == "2"
              @device_detail = DeviceDetail.find_by(deviceId:"12345678",security_token: params[:securityToken])
            else
              @device_detail = DeviceDetail.find_by(deviceId:params[:deviceId],security_token: params[:securityToken])
            end
            @recently_added =  @device_detail.recently_added.create(
              title:params[:qrType],
              subtitle:params[:data],
              qrType: params[:qrType],
              qr_name: params[:qrName],)
            @qrData = @device_detail.qr_data.create(
              id: @recently_added.id,
              device_detail_id: params[:deviceId],
              securityToken: params[:securityToken],
              versionName: params[:versionName],
              versionCode: params[:versionCode],
              codeData: params[:data],
              qr_name: params[:qrName],)

            {status:200,message:"Success",createdAt:@qrData.created_at.strftime("%d/%m/%y"),id:@recently_added.id}
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end

      end

    end
  end
end
