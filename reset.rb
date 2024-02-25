require 'sequel'
DB = Sequel.connect(ENV['DATABASE_URL'])
DB[:clientes].update(saldo: 0)
DB[:transacoes].delete
