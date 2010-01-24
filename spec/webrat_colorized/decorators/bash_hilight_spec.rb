require 'spec_helper'

describe WebratColorized::Decorators::BashHilight do
  describe "#bash_hilight" do
    before do
      @document = Nokogiri(<<-EOF
<html>
  <body>
    <div id='element'><h1></h1></div>
    <div id='comment'><!-- comment --></div>
    <div id='text'>text</div>
    <div id='cdata'><script>alert('hi');</script></div>
  </body>
</html>
EOF
)
      @document.decorate_bash_hilight!
    end
    it "calls #bash_hilight_element for element nodes" do
      h1 = @document.at('#element').children.first
      h1.should_receive(:bash_hilight_element)
      h1.bash_hilight
    end

    it "calls #bash_hilight_text for text nodes" do
      text = @document.at('#text').children.first
      text.should_receive(:bash_hilight_text)
      text.bash_hilight
    end

    it "calls #bash_hilight_comment for comment nodes" do
      comment = @document.at('#comment').children.first
      comment.should_receive(:bash_hilight_comment)
      comment.bash_hilight
    end

    it "calls #bash_hilight_cdata for cdata nodes" do
      pending
      raise cdata.cdata?.to_s
      cdata.should_receive(:bash_hilight_cdata)
      cdata.bash_hilight
    end

    it "calls #bash_hilight_document for document nodes" do
      @document.should_receive(:bash_hilight_document)
      @document.bash_hilight
    end
  end

  describe "#bash_hilight_comment" do
    before do
      @comment = "<!-- hello there -->"
      @document = Nokogiri <<-EOF
<html>
  <body>#{@comment}</body>
</html>
EOF
      @document.decorate_bash_hilight!
      @hilighted = @document.at('body').children.first.bash_hilight
    end

    it "should contain the text of the comment" do
      @hilighted.should =~ /#{@comment}/
    end

    it "should begin by setting the color to yellow" do
      @hilighted.should =~ /^\e\[33m/
    end
  end

  describe "#bash_hilight_text" do
    before do
      @text = "hello there"
      @document = Nokogiri <<-EOF
<html>
  <body>#{@text}</body>
</html>
EOF
      @document.decorate_bash_hilight!
      @hilighted = @document.at('body').children.first.bash_hilight
    end

    it "should contain the text" do
      @hilighted.should =~ /#{@text}/
    end

    it "should not set any colors" do
      @hilighted.should_not =~ /\e\[\d+/
    end
  end

  describe "#bash_hilight_element" do
    before do
      @document = Nokogiri <<-EOF
<html>
  <body>
    <div class="hi"></div>
  </body>
</html>
EOF
      @document.decorate_bash_hilight!
      @hilighted = @document.at('div')
    end

    it "should contain the tag name in bold red" do
      expected = Term::ANSIColor.red { Term::ANSIColor.bold { "div" } }
      expected = expected.gsub(/\\/, '\\').gsub!(/\[/, '\[')
      @hilighted.bash_hilight.should =~ /#{expected}/
    end

    it "should contain the attribute name in magenta" do
      expected = Term::ANSIColor.magenta { "class" }
      expected = expected.gsub(/\\/, '\\').gsub(/\[/, '\[')
      @hilighted.bash_hilight.should =~ /#{expected}/
    end

    it "should contain the attribute value and quotes in cyan" do
      expected = Term::ANSIColor.cyan { "\"hi\"" }
      expected = expected.gsub(/\\/, '\\').gsub(/\[/, '\[')
      @hilighted.bash_hilight.should =~ /#{expected}/
    end
  end
end
