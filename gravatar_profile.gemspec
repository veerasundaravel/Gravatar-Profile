# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gravatar_profile}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Veerasundaravel Thirugnanasundaram"]
  s.date = %q{2010-09-07}
  s.description = %q{gravatar_profile is a Ruby Wrapper for getting GRAVATAR[http://gravatar.com] avatars and profile informations.}
  s.email = ["veerasundaravel@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc", ]
  s.files = ["CHANGELOG.rdoc", "README.rdoc", "MIT-LICENSE", "gravatar_profile.gemspec", "lib/gravatar_profile.rb"]
  s.homepage = %q{http://veerasundaravel.wordpress.com}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gravatar_profile}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{gravatar_profile is a Ruby Wrapper for getting GRAVATAR[http://gravatar.com] avatars and profile informations. by Veerasundaravel Thirugnanasundaram}
  s.test_files = []

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1
    s.add_development_dependency(%q<xml-simple>, [">= 1.0.0"])
  else
    s.add_dependency(%q<xml-simple>, [">= 1.0.0"])
  end
end
