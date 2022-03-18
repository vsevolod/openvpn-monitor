require 'rubygems'
require 'bundler'
require 'yaml'

Bundler.require(ENV.fetch('RUBY_ENV', :default).to_sym)

require_relative './open_vpn/monitor/application'
require_relative './open_vpn/monitor/configuration'
