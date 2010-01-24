module Webrat
  module Matchers
    class HaveXpath
      def failure_message
        message = "expected the following text to match xpath #{@expected}:\n"
        message += WebratColorized.colorize(@document.to_html)
      end

      def negative_failure_message
        message = "expected the following text to not match xpath #{@expected}:\n"
        message += WebratColorized.colorize(@document.to_html)
      end
    end
  end
end
