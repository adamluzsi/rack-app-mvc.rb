$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
# $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'..','..','rack-app','lib')

require 'kramdown'
require 'tilt/kramdown'
require 'rack/app/front_end'
require 'rack/app'
require 'rack/app/test'