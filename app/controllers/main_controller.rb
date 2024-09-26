class MainController < ApplicationController
  def index
  end
  
  def invite
  	@referral_code = params['refCode']
  	@playbutton = "market://details?id=com.apps.scanbuddy&referrer=utm_source%3DINVITE%26utm_medium%3D#{@referral_code}%26utm_term%3DINVITE%26utm_content%3DINVITE%26utm_campaign%3DINVITE"
  end
end
