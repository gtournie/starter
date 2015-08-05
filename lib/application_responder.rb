class AppResponder < ActionController::Responder
  include Responders::CollectionResponder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder
end