require 'rubygems'
require 'bundler'
require 'yaml'

Bundler.require

require_relative './open_vpn/monitor/application'

run OpenVPN::Monitor::Application.new
