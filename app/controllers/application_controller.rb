class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index

  end

  def search
    query = params[:query]

    if (@photos = Rails.cache.read("query_#{query}")).nil?

      flickr = Flickr.new(File.join(Rails.root, "config", 'flickr.yml'))
      @photos = flickr.photos.search(text: query, per_page: 13)

      Rails.cache.write("query_#{query}",
                        @photos,
                        expires_in: Rails.cache.read('expires_in') || 90.minutes)

    end

  end

  def set_expire
    Rails.cache.write("expires_in",
                      params[:expire],
                      expires_in: Rails.cache.read('expires_in') || 90.minutes)
    render nothing: true
  end
end