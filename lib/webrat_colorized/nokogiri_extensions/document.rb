module WebratColorized
  module NokogiriExtensions
    module Document
      def decorate_bash_hilight!
        target = self.respond_to?(:document) ? document : self
        unless target.decorators(Nokogiri::XML::Node).include? WebratColorized::Decorators::BashHilight
          target.decorators(Nokogiri::XML::Node) << WebratColorized::Decorators::BashHilight
          target.decorate!
        end

        self.send(:extend, WebratColorized::NokogiriExtensions::NodeSet) if Nokogiri::XML::NodeSet === self

        self
      end
    end
  end
end
