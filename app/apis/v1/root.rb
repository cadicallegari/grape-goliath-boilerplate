Dir["./app/apis/v1/*.rb"].each { |f| require f }

module APP
  module V1
    class Root < Grape::API

      version 'v1', using: :path
      format          :json
      default_format  :json
      formatter :json, Grape::Formatter::Rabl

      include Grape::Kaminari
      helpers ::Helper::Pagination

      mount API::V1::Books

    end
  end
end
