class Router
  def call(env)
    routes = {
      'GET' => Extrato.new,
      'POST' => CriarTransacao.new
    }
    endpoint = routes[env[::Rack::REQUEST_METHOD]]
    raise NotFoundError unless endpoint

    endpoint.call(env)
  end
end
