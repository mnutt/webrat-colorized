require 'term/ansicolor'

module WebratColorized
  module Decorators
    module BashHilight
      def bash_hilight(indent=0, oneline=false)
        if html?
          bash_hilight_document
        elsif comment?
          bash_hilight_comment(indent, oneline)
        elsif text?
          bash_hilight_text(indent, oneline)
        elsif cdata?
          bash_hilight_cdata(indent, oneline)
        elsif element?
          bash_hilight_element(indent, oneline)
        elsif self.type == self.class::DTD_NODE
          bash_hilight_dtd
        else
          bash_hilight_unknown(indent, oneline)
        end
      end

      def bash_hilight_dtd
        # need to do this better
        result = Term::ANSIColor.red { "<!DOCTYPE " }
        result += Term::ANSIColor.magenta { "name" }
        result += "="
        result += Term::ANSIColor.cyan { "\"#{name}\"" }
        result += Term::ANSIColor.red { ">\n" }
      end

      def bash_hilight_document
        children.map {|c|
           document.decorate(c)
          c.bash_hilight
        }.join("")
      end

      def bash_hilight_comment(indent=0, oneline=false)
        return to_s if oneline
          (" " * indent) + Term::ANSIColor.yellow { to_s.gsub(/\n/, "\n#{' ' * indent}") } + "\n"
      end

      def bash_hilight_text(indent=0, oneline=false)
        return content.strip.gsub(/\s+/, ' ') if oneline

        is_text = (content.scan(/[A-Za-z0-9\s]/).size.to_f / content.size) > 0.9
        return ' ' * indent + content.strip.gsub(/\n/, "\n#{' ' * indent}") + "\n" unless is_text

        stripped = content.strip.gsub(/\s+/, ' ')
        stripped.gsub(/(.{1,60})( +|$\n?)|(.{1,60})/, ' ' * indent + "\\1\\3\n")
      end

      def bash_hilight_cdata(indent=0, oneline=false)
        result = Term::ANSIColor.yellow { to_s.strip }
        return result if oneline
        ' ' * indent + result.gsub(/\n/, "\n#{' ' * indent}") + "\n"
      end

      def bash_hilight_element(indent=0, oneline=false)
        return "" unless name
        newline = oneline ? '' : "\n"
        result = ""

        # Open tag
        result += " " * indent
        result += Term::ANSIColor.red { "<" }
        result += Term::ANSIColor.red { Term::ANSIColor.bold { name.to_s } }

        attributes.each do |name, value|
          result += " " + Term::ANSIColor.magenta { name }
          result += "="
          result += Term::ANSIColor.cyan { "\"#{value}\"" }
        end if attributes
        result += Term::ANSIColor.red { ">#{newline}" }

        # Children
        result += children.map {|c|
          document.decorate(c)
          c.bash_hilight(indent + 2, oneline)
        }.join("")

        # Closing tag
        result += " " * indent unless oneline
        result += Term::ANSIColor.red { "</" }
        result += Term::ANSIColor.red { Term::ANSIColor.bold { name.to_s } }
        result += Term::ANSIColor.red { ">\n" }

        # Don't indent if turned out to be a short element
        if(!oneline && result.size < 200)
          bash_hilight(indent, true)
        else
          result
        end
      end

      def bash_hilight_unknown(indent=0, oneline=false)
        bash_hilight_cdata(indent, oneline)
      end
    end
  end
end
