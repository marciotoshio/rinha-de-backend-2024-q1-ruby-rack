class ErrorHandler
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue NotFoundError, Sequel::NoMatchingRow
    [404, {}, ["not found"]]
  rescue UnprocessableContentError
    [422, {}, ["unprocessable content"]]
  rescue => e
    puts e.message
    [500, {}, ["internal server error"]]
  end
end
