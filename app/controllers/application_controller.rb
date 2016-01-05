class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  $xaslogger = Logger.new("log/xas.log")

  before_action :set_locale

  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        $xaslogger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    {:locale => I18n.locale}
  end

  # DEVISE LAYOUT CHANGING ADEM
  # device.rb içinde tanımlandığı için burada gerek kalmadı, örnek olsun diye silmedim.
  # layout :layout_by_resource
  # protected
  # def layout_by_resource
  #   if devise_controller?
  #     "devise"
  #   else
  #     "application"
  #   end
  # end
  # Sidebar tarafında index yerine direk edit sayfası açılsın diye ekledik. Çünkü henüz network dizisi alınmadığı
  # için null geliyordu. Böylece, uygulama açıldığında, bir eleman seçilmese bile, network kontroller çalışmasada
  # application_controller üzerinden bir object elde edilmiş oldu.
  # $network_setting=NetworkSet.first

  # DEVISE LAYOUT CHANGING ADEM ABC
  # device.rb içinde tanımlandığı için burada gerek kalmadı, örnek olsun diye silmedim.
  # layout :layout_by_resource
  # protected
  # def layout_by_resource
  #   if devise_controller?
  #     "devise"
  #   else
  #     "application"
  #   end
  # end
  # Sidebar tarafında index yerine direk edit sayfası açılsın diye ekledik. Çünkü henüz network dizisi alınmadığı
  # için null geliyordu. Böylece, uygulama açıldığında, bir eleman seçilmese bile, network kontroller çalışmasada
  # application_controller üzerinden bir object elde edilmiş oldu.
  # $network_setting=NetworkSet.first

end