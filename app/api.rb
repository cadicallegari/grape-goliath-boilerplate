Dir["./app/apis/**/*.rb"].each { |f| require f }

module APP
  class API < Grape::API

    if Goliath.env?(:production)
      logger Logger.new MultiIO.new(STDOUT)
    else
      log_file = File.open("log/#{Goliath::env}.log", "a+")
      logger Logger.new MultiIO.new(STDOUT, log_file)
      logger.formatter = ::GrapeLogging::Formatters::Default.new
      use ::GrapeLogging::Middleware::RequestLogger, { logger: logger }
    end
    logger.datetime_format = "%d/%m/%Y %H:%M:%S.%L"

    content_type :json, "application/json;charset=UTF-8"
    format          :json
    default_format  :json
    formatter :json, Grape::Formatter::Rabl

    include Grape::Kaminari

    use ApiLogger

    DEFAULT_PER_PAGE = 20
    USER_SESSION_TIME = 360000

    CORS_HEADERS = {
      'Access-Control-Allow-Origin'   => '*',
      'Access-Control-Allow-Methods'  => 'POST, GET, PUT',
      "Access-Control-Allow-Headers"  => "Content-Type",
      "Content-Type"                  => "application/json; charset=UTF-8"
    }

    # for cros
    before do
      CORS_HEADERS.each do |name, content|
        header[name] = content
      end
    end


    helpers do
      def logger
        API.logger
      end

      def default_cors_headers
        CORS_HEADERS
      end

      def default_per_page
        DEFAULT_PER_PAGE
      end

    end

    error_formatter :json, lambda { |message, backtrace, options, env|
      API.logger.error "<====== Returning: #{message}"
      {error: message}.to_json
    }

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      API.logger.error "<====== Returning: #{e.message}"
      rack_response({ error: e.message }.to_json, 406, CORS_HEADERS)
    end

    rescue_from :all do |e|
      API.logger.error "[FATAL] rescued from API #{e.class.name}: #{e.to_s} in #{e.backtrace.first}"
      API.logger.error e.message
      rack_response({ error: e.message }.to_json, 500, CORS_HEADERS)
    end


    mount V1::Root

    route :any, '*path' do
      error!(I18n.t('fails.not_found'), 404)
    end

  end
end
