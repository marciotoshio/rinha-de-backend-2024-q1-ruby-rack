class Extrato < BaseResource
  def process
    cliente = DB[:clientes].first!(id: cliente_id)
    {
      saldo: {
        total: cliente[:saldo],
        data_extrato: Time.now.utc.iso8601(3),
        limite: cliente[:limite]
      },
      ultimas_transacoes: ultimas_transacoes
    }
  end

  def ultimas_transacoes
    DB[:transacoes]
      .select(:valor, :tipo, :descricao, :realizada_em)
      .where(cliente_id: cliente_id)
      .reverse_order(:realizada_em)
      .limit( 10)
      .all
  end
end
