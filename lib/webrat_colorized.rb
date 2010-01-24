$LOAD_PATH.unshift File.dirname(__FILE__)
require 'webrat_colorized/html5'
require 'webrat_colorized/webrat_extensions'

module WebratColorized

  # :stopdoc:
  VERSION = '1.0.0'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, args.flatten)
  end

  def self.colorize(html)
    parser = HTML5::HTMLParser.new(:tree => HTML5::TreeBuilders['simpletree'])
    document = parser.parse_fragment(html) rescue parser.parse(html)
    document.hilite
  end

end  # module WebratColorized
