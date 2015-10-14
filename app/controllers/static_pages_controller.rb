class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def indevelopment
  end

  def torgy
  end
  

  def untreated_wood
    @propozs=Propoz.where(enable: 1)
    @unprocessed=Unprocessed.where(visible: 1)
  end

  def download_propoz
      filename=params[:filename]+'.'+params['format']
      send_file(Rails.root.join('public', 'uploads','propoz', filename),filename: filename)
  end

  def download_result
      filename=params[:filename]+'.'+params['format']
      send_file(Rails.root.join('public', 'uploads','result', filename),filename: filename)
  end


end
