class BaseResource
  def call(env)
    @env = env
    result = process
    [200, headers, [result.to_json]]
  end

  def cliente_id
    cliente_id ||= @env['REQUEST_PATH'].split('/')[2].to_i
  end

  def cliente
    return @cliente if @cliente

    @cliente = DB[:clientes].first(id: cliente_id)
    raise NotFoundError if @cliente.nil?

    @cliente
  end

  def body_params
    return @body_params if @body_params

    request_body_io = request.body
    request_body = request_body_io.read; request_body_io.rewind
    @body_params = JSON.parse(request_body).transform_keys(&:to_sym)
  end

  def request
    Rack::Request.new(@env)
  end

  def process
    ''
  end

  def headers
    { 'Content-Type' => 'text/json' }
  end
end
