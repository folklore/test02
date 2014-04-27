class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def search
    # Текст запроса
    query = params[:query]

    # Первым делом проверяем, нет ли в кэше результата текущего запроса ...
    if (@photos = Rails.cache.read("query_#{query}")).nil?
      # Проверяем в довольно странной форме,
      # но даёт возможность обойтись без exists?

      # Собственно обращаемся с просьбой к flickr'у
      flickr = Flickr.new(File.join(Rails.root, "config", 'flickr.yml'))
      @photos = flickr.photos.search(text: query, per_page: 13)

      # И полученный результат записываем в кеш, указывая срок хранения
      Rails.cache.write("query_#{query}",
                        @photos,
                        expires_in: Rails.cache.read('expires_in') || 90.minutes)

    end

  end

  def set_expire
    # Настройки срока хранения в кэше
    Rails.cache.write("expires_in",
                      params[:expire],
                      expires_in: Rails.cache.read('expires_in') || 90.minutes)
  end
end