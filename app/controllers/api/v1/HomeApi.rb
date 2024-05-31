module API
  module V1
    class HomeApi < Grape::API
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

      resources :home do
        desc "Api for Home Screen"
        params do
          requires :deviceId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :userId, type: String, allow_blank: true
        end

        post do
          puts params
          begin
            @appBanners = AppBanner.all.select(:id, :imgUrl, :actionUrl).where(:status => true)
            if params[:userId] == "2"
              @deviceDetail = DeviceDetail.find_by(deviceId: "12345678",security_token: params[:securityToken])
              @recentlyAdded = RecentlyAdded.where(device_detail_id: @deviceDetail.id).select(:id,:title, :subtitle,:created_at).order(created_at: :desc).limit(10)
            else
              @deviceDetail = DeviceDetail.find_by(deviceId: params[:deviceId], security_token: params[:securityToken])
              puts @deviceDetail
              @recentlyAdded = RecentlyAdded.where(device_detail_id: @deviceDetail.id).order(created_at: :desc).limit(10)
            end
            @user = UserDetail.find_by(id:params[:userId])
            if @user.present?
              @userCoins = @user.wallet_balance.to_s
            else
              @userCoins = "0"
            end
            recentlyAddeds = []
            @recentlyAdded.each do |qr|
              qr_data = {
                id:qr.id,
                title:qr.qr_name,
                subtitle:qr.subtitle,
                createdAt:qr.created_at.strftime("%d/%m/%Y"),
                qrType:qr.title,
                icon: ICON_TYPE_MAP[qr.qr_name].url
              }
            recentlyAddeds << qr_data
            end
            { status: 200, message: "Success", appBanners: @appBanners.any? ? @appBanners : [], recentlyAdded: recentlyAddeds.any? ? recentlyAddeds : [],userCoins: @userCoins }
          rescue Exception => e
            {status:500,message:"Internal Server Error",error:e}
          end
        end
      end
    end
  end
end
