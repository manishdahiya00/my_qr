module API
  module V1
    class QrDataApi < Grape::API
      prefix :api
      version :v1
      format :json
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
      resources :qrHistory do
        desc "Single Qr History Api"
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :qrId, type: String, allow_blank: false
          requires :qrType, type: String, allow_blank: false
          requires :userId, type: String, allow_blank: true

        end
        post do
          begin
            if params[:userId] == "2"
              @device_details = DeviceDetail.find_by(deviceId:"12345678",security_token: params[:securityToken])
            else
              @device_details = DeviceDetail.find_by(deviceId:params[:deviceId],security_token: params[:securityToken])
            end
            case params[:qrType]
            when "Scanned"
              @qr = RecentlyAdded.where(id: params[:qrId]).select(:id,:title,:subtitle,:created_at,:qr_name).first
              @history = {
                id: @qr.id,
                title: @qr.qr_name,
                subtitle: @qr.subtitle,
                createdAt: @qr.created_at.strftime("%d/%m/%y"),
                icon: ICON_TYPE_MAP[@qr.qr_name].url
              }
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
              @image = ""
            when "Generated"
              @qr = GeneratedQr.where(id: params[:qrId]).select(:id,:codeData,:created_at,:qr_name).first
              @history = {
                id: @qr.id,
                title: @qr.qr_name,
                subtitle: @qr.codeData,
                createdAt: @qr.created_at.strftime("%d/%m/%y"),
                icon: ICON_TYPE_MAP[@qr.qr_name].url
              }
                @image = @qr.codeImage.url
              @isFavourite = Favourite.find_by(qr_code_id: params[:qrId]).present?
            else
              { status: 500, message: "Invalid qrType" }
            end
            { status: 200, message: "Success", history: @history || {}, image_url: @image , isFavourite: @isFavourite }
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end
    end
  end
end
