module API
  module V1
    class ScannerDataApi < Grape::API
      format :json
      prefix :api
      version :v1


      class IconType
        attr_reader :url

        def initialize(url)
          @url = url
        end

        UNKNOWN = IconType.new("http://192.168.1.32:8000/assets/help.png")
        ALL_FORMATS = IconType.new("http://192.168.1.32:8000/assets/text.png")
        CODE_128 = IconType.new("http://192.168.1.32:8000/assets/text.png")
        CODE_39 = IconType.new("http://192.168.1.32:8000/assets/text.png")
        CODE_93 = IconType.new("http://192.168.1.32:8000/assets/text.png")
        CODABAR = IconType.new("http://192.168.1.32:8000/assets/text.png")
        DATA_MATRIX = IconType.new("http://192.168.1.32:8000/assets/text.png")
        EAN_13 = IconType.new("http://192.168.1.32:8000/assets/text.png")
        EAN_8 = IconType.new("http://192.168.1.32:8000/assets/text.png")
        ITF = IconType.new("http://192.168.1.32:8000/assets/text.png")
        QR_CODE = IconType.new("http://192.168.1.32:8000/assets/text.png")
        UPC_A = IconType.new("http://192.168.1.32:8000/assets/text.png")
        UPC_E = IconType.new("http://192.168.1.32:8000/assets/text.png")
        PDF417 = IconType.new("http://192.168.1.32:8000/assets/text.png")
        AZTEC = IconType.new("http://192.168.1.32:8000/assets/text.png")
        CONTACT_INFO = IconType.new("http://192.168.1.32:8000/assets/text.png")
        EMAIL = IconType.new("http://192.168.1.32:8000/assets/text.png")
        ISBN = IconType.new("http://192.168.1.32:8000/assets/text.png")
        PHONE = IconType.new("http://192.168.1.32:8000/assets/text.png")
        PRODUCT = IconType.new("http://192.168.1.32:8000/assets/text.png")
        SMS = IconType.new("http://192.168.1.32:8000/assets/text.png")
        TEXT = IconType.new("http://192.168.1.32:8000/assets/text.png")
        URL = IconType.new("http://192.168.1.32:8000/assets/text.png")
        WIFI = IconType.new("http://192.168.1.32:8000/assets/text.png")
        GEO = IconType.new("http://192.168.1.32:8000/assets/text.png")
        CALENDAR_EVENT = IconType.new("http://192.168.1.32:8000/assets/text.png")
        DRIVER_LICENSE = IconType.new("http://192.168.1.32:8000/assets/text.png")
      end

      ICON_TYPE_MAP = {
      "UNKNOWN" => IconType::UNKNOWN,
      "ALL FORMATS" => IconType::ALL_FORMATS,
      "CODE 128" => IconType::CODE_128,
      "CODE 39" => IconType::CODE_39,
      "CODE 93" => IconType::CODE_93,
      "CODABAR" => IconType::CODABAR,
      "DATA MATRIX" => IconType::DATA_MATRIX,
      "EAN 13" => IconType::EAN_13,
      "EAN 8" => IconType::EAN_8,
      "ITF" => IconType::ITF,
      "QR CODE" => IconType::QR_CODE,
      "UPC A" => IconType::UPC_A,
      "UPC E" => IconType::UPC_E,
      "PDF417" => IconType::PDF417,
      "AZTEC" => IconType::AZTEC,
      "CONTACT INFO" => IconType::CONTACT_INFO,
      "EMAIL" => IconType::EMAIL,
      "ISBN" => IconType::ISBN,
      "PHONE" => IconType::PHONE,
      "PRODUCT" => IconType::PRODUCT,
      "SMS" => IconType::SMS,
      "TEXT" => IconType::TEXT,
      "URL" => IconType::URL,
      "WIFI" => IconType::WIFI,
      "GEO" => IconType::GEO,
      "CALENDAR EVENT" => IconType::CALENDAR_EVENT,
      "DRIVER LICENSE" => IconType::DRIVER_LICENSE
    }



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

            {status:200,message:"Success",createdAt:@qrData.created_at.strftime("%d/%m/%y"),id:@recently_added.id,icon: ICON_TYPE_MAP[@recently_added.qr_name].url}
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end

      end

    end
  end
end
