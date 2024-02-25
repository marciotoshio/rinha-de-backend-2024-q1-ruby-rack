require 'json'
require 'rack'
require 'sequel'
require 'time'

require_relative './error_handler'
require_relative './router'
require_relative './base_resource'
require_relative './criar_transacao'
require_relative './extrato'

DB = Sequel.connect(ENV['DATABASE_URL'])

class NotFoundError < StandardError; end
class UnprocessableContentError < StandardError; end

use ErrorHandler

run Router.new
