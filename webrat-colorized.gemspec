# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{webrat-colorized}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Nutt"]
  s.date = %q{2010-01-24}
  s.description = %q{Colorizes html output for failed webrat assertions}
  s.email = %q{michael@nuttnet.net}
  s.extra_rdoc_files = ["History.txt", "README.txt"]
  s.files = [".gitignore", "History.txt", "README.txt", "Rakefile", "lib/webrat_colorized.rb", "lib/webrat_colorized/decorators/bash_hilight.rb", "lib/webrat_colorized/nokogiri_extensions.rb", "lib/webrat_colorized/webrat_extensions.rb", "spec/spec_helper.rb", "spec/webrat_colorized/decorators/bash_hilight_spec.rb", "spec/webrat_colorized_spec.rb", "webrat-colorized.gemspec"]
  s.homepage = %q{http://github.com/mnutt/webrat-colorized}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{webrat-colorized}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Colorizes html output for failed webrat assertions}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.5.1"])
    else
      s.add_dependency(%q<bones>, [">= 2.5.1"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.5.1"])
  end
end
