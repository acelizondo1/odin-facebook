# -*- encoding: utf-8 -*-
# stub: capybara-wsl 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "capybara-wsl".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mark Tityuk".freeze]
  s.date = "2021-03-29"
  s.description = "Allows Capybara to open pages/screenshots in Windows browsers via Launchy.".freeze
  s.email = "mark.tityuk@gmail.com".freeze
  s.homepage = "https://github.com/dersnek/capybara-wsl".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Open pages/screenshots in WSL from Capybara".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<capybara>.freeze, [">= 2.0"])
    s.add_runtime_dependency(%q<launchy>.freeze, [">= 2.0"])
    s.add_runtime_dependency(%q<dotenv>.freeze, [">= 0"])
  else
    s.add_dependency(%q<capybara>.freeze, [">= 2.0"])
    s.add_dependency(%q<launchy>.freeze, [">= 2.0"])
    s.add_dependency(%q<dotenv>.freeze, [">= 0"])
  end
end
