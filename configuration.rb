require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'time'
require 'erb'

groups = ['default'] | [ENV.fetch('RUBY_ENV', 'default')]
Bundler.require(*groups)

require_relative './open_vpn/management/commands/status'
require_relative './open_vpn/management/commands/state'
require_relative './open_vpn/management/commands'
require_relative './open_vpn/management/client'
require_relative './open_vpn/monitor/helper'
require_relative './open_vpn/monitor/application'
require_relative './open_vpn/monitor/configuration'
require_relative './open_vpn/monitor/operations/generate_html'
require_relative './open_vpn/monitor/operations/prepare_data'
