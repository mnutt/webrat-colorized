module WebratColorized
  module NokogiriExtensions
    module NodeSet
      def bash_hilight
        self.map{|c|
          document.decorate(c)
          c.bash_hilight
        }.join
      end
    end
  end
end
