# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pubdraft/version'

Gem::Specification.new do |gem|
  gem.name          = "pubdraft"
  gem.version       = Pubdraft::VERSION
  gem.authors       = ["Joe Sak", "Matthew Cowie"]
  gem.email         = ["joe@neotericdesign.com", "matthew@neotericdesign.com"]
  gem.description   = %q{Quickly add publish/draft state to your ActiveRecord models}
  gem.summary       = %q{Quick publish/draft state on ActiveRecord models}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '>= 3.2', '< 6.0'

  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rspec-rails', '> 3.5.0'
  gem.add_development_dependency 'database_cleaner'
end
