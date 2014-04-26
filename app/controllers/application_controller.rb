class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def application
  end

  def search
    query = params[:query]

    if (@photos = Rails.cache.read("query_#{query}")).nil?

      flickr = Flickr.new(File.join(Rails.root, "config", 'flickr.yml'))
      @photos = flickr.photos.search(text: query, per_page: 12)

      Rails.cache.write("query_#{query}",
                        @photos,
                        expires_in: Rails.cache.read('expires_in') || 90.minutes)

    end

  end

  def set_expires
    Rails.cache.write("expires_in",
                      params[:expires],
                      expires_in: Rails.cache.read('expires_in') || 90.minutes)
    render nothing: true
  end
end