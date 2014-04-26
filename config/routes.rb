Vladimir::Application.routes.draw do

  # Не стал создавать дополнительные контроллеры, так как
  # поставленые задачами и AppCtrl прекрасно  вместит

  root 'application#index'

  post 'search' =>      'application#search',      as: :search
  post 'set_expires' => 'application#set_expires', as: :set_expires

end