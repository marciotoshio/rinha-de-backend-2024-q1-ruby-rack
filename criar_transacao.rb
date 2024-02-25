class CriarTransacao < BaseResource
  OPERATION = { 'c' => '+', 'd' => '-' }

  def process
    validar_parametros

    DB.transaction do
      DB[:transacoes].insert(valor: body_params[:valor], tipo: body_params[:tipo], descricao: body_params[:descricao], cliente_id: cliente_id)
      DB.fetch("UPDATE clientes SET saldo = saldo #{OPERATION[body_params[:tipo]]} #{body_params[:valor]} WHERE id = #{cliente_id} RETURNING limite, saldo;").first
    end
  rescue
    raise UnprocessableContentError
  end

  def validar_parametros
    raise UnprocessableContentError unless body_params[:valor].is_a? Integer
    raise UnprocessableContentError unless %w[c d].include?(body_params[:tipo])
    raise UnprocessableContentError unless body_params[:descricao] && (1..10).include?(body_params[:descricao].size)
  end
end
