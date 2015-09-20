class Admin::SettingController < AdminController

  def index
    @settings=Rails.application.config.birzha_settings
  end

  def create
    flash[:success] = "Данні успішно збережені"
    File.open("settings.yml", "w") do |file|
      file.write settings_params.to_yaml
    end
    Rails.application.config.birzha_settings=settings_params
    redirect_to admin_setting_index_path

  end

  private
  def settings_params
    params.permit(:name, :email,:facebook_url,:twitter_url,:googleplus_url,:linkedin_url)
  end
end
