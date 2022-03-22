require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'time'

groups = ['default'] | [ENV.fetch('RUBY_ENV', 'default')]
Bundler.require(*groups)

require_relative './open_vpn/management/commands/status'
require_relative './open_vpn/management/commands/state'
require_relative './open_vpn/management/commands'
require_relative './open_vpn/management/client'
require_relative './open_vpn/monitor/operations/prepare_data'
require_relative './open_vpn/monitor/application'
require_relative './open_vpn/monitor/configuration'
