require 'nokogiri'
require 'webrat_colorized/decorators/bash_hilight'

module WebratColorized
  module NokogiriExtensions
    def decorate_bash_hilight!
      unless decorators(Nokogiri::XML::Node).include? WebratColorized::Decorators::BashHilight
        decorators(Nokogiri::XML::Node) << WebratColorized::Decorators::BashHilight
        decorate!
      end

      self
    end
  end
end

Nokogiri::XML::Document.send(:include, WebratColorized::NokogiriExtensions)
