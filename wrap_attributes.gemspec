$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "wrap_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "wrap_attributes"
  spec.version     = WrapAttributes::VERSION
  spec.authors     = ["tanmen"]
  spec.email       = ["yt.prog@gmail.com"]
  spec.homepage    = "https://github.com/tanmen/wrap_attributes"
  spec.summary     = "convert request parameter to suffix '_attributes'"
  spec.description = "convert request parameter to suffix '_attributes'"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.1"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler"
end
