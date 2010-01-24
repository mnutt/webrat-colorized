
require File.join(File.dirname(__FILE__), %w[spec_helper])

describe WebratColorized do
  it "adds a .decorate_bash_hilight! method to the nokogiri document" do
    @document = Nokogiri("")
    @document.send(:extend, WebratColorized::NokogiriExtensions::Document)
    @document.should respond_to(:decorate_bash_hilight!)
  end

  describe ".decorate_bash_hilight!" do
    before do
      @document = Nokogiri("<html><body><h1>hello</h1></body></html>")
      @document.send(:extend, WebratColorized::NokogiriExtensions::Document)      
    end

    it "adds a #bash_hilight method to every node in the document" do
      @document.decorate_bash_hilight!
      @document.should respond_to(:bash_hilight)
      @document.at('body').should respond_to(:bash_hilight)
      @document.at('h1').should respond_to(:bash_hilight)
    end
  end
end

# EOF
