class ApiLogger < Grape::Middleware::Base

  def before
    ip = env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_ADDR']
    message  = "=> Received #{env['REQUEST_METHOD']}, "
    message += "from: #{ip}, "
    message += "at: #{env['REQUEST_PATH']}, " # or REQUEST_URI
    message += "query params: #{env['QUERY_STRING']}, " if env['QUERY_STRING'].present? # or REQUEST_URI
    unless env["CONTENT_TYPE"].include("application/json")
      message += "params: " + env['rack.input'].read
    else
      message += "Content-Type: #{env["CONTENT_TYPE"]}"
    end
    APP::API.logger.info message
  end

end
