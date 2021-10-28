# -*- encoding: utf-8 -*-
# stub: graphicsmagick 1.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "graphicsmagick".freeze
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chad McGimpsey".freeze]
  s.date = "2018-05-12"
  s.description = "Light ruby wrapper for the GraphicsMagick CLI.".freeze
  s.email = ["chad.mcgimpsey@gmail.com".freeze]
  s.homepage = "https://github.com/dignoe/graphicsmagick".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Light ruby wrapper for the GraphicsMagick CLI.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<subexec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<subexec>.freeze, [">= 0"])
  end
end
