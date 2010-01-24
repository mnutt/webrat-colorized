module HTML5
  module TreeBuilders
    module SimpleTree
      class Element < Node
        def hilite(indent=0, oneline=false)
          newline = oneline ? '' : "\n"
          result = ""
          
          # Open tag
          if self.respond_to?(:name) && name
            result += " " * indent
            result += Term::ANSIColor.red { "<" }
            result += Term::ANSIColor.red { Term::ANSIColor.bold { name.to_s } }
            
            attributes.each do |name, value|
              result += " " + Term::ANSIColor.magenta { name }
              result += "="
              result += Term::ANSIColor.cyan { "\"#{value}\"" }
            end
            result += Term::ANSIColor.red { ">#{newline}" }
          end

          # Children
          result += childNodes.map {|c| c.hilite(indent + 2, oneline) }.join("")

          # Closing tag
          if self.respond_to?(:name) && name
            result += " " * indent unless oneline
            result += Term::ANSIColor.red { "</" }
            result += Term::ANSIColor.red { Term::ANSIColor.bold { name.to_s } }
            result += Term::ANSIColor.red { ">\n" }
          end

          # Don't indent if turned out to bue a short element
          if(!oneline && result.size < 200)
            hilite(indent, true)
          else
            result
          end
        end
      end

      class Document < Node
        def hilite(indent=0, oneline=false)
          childNodes.map { |node|
            node.hilite(indent + 2)
          }.join
        end
      end

      class DocumentType < Node
        def hilite(indent=0, oneline=false)
          Term::ANSIColor.red { to_s } + "\n"
        end
      end

      class TextNode < Node
        def hilite(indent=0, oneline=false, normalize=true)
          return value.strip.gsub(/\s+/, ' ') if oneline
          empty_string? ? "" : indented(indent)
        end

        # is it vaguely sentence-like, or is it javascript, css, etc?
        def is_text?
          (value.scan(/[A-Za-z0-9\s]/).size.to_f / value.size) > 0.9
        end

        def indented(indent)
          return ' ' * indent + value.strip.gsub(/\n/, "\n#{' ' * indent}") + "\n" unless is_text?
          stripped = value.strip.gsub(/\s+/, ' ')
          value_array = []
          while stripped.size > 0
            value_array << "#{' ' * indent}#{stripped.slice!(0, 60)}\n"
          end

          value_array.join
        end

        def empty_string?
          value.strip == ""
        end
      end

      class CommentNode < Node
        def hilite(indent=0, oneline=false)
          return to_s if oneline
          (" " * indent) + Term::ANSIColor.yellow { to_s.gsub(/\n/, "\n#{' ' * indent}") } + "\n"
        end
      end
    end
  end
end
