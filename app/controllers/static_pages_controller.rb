class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def indevelopment
  end

  def untreated_wood
    @propozs=Propoz.where(enable: 1)

  end

  def download_propoz
      filename=params[:filename]+'.'+params['format']
      send_file(Rails.root.join('public', 'uploads','propoz', filename),filename: filename)
  end


end
