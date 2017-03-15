# -*- encoding: utf-8 -*-
# stub: abebookr 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "abebookr"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gems.megorei.com" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Johannes Haubold", "Ronny Engelmann"]
  s.bindir = "exe"
  s.date = "2017-03-15"
  s.email = ["jh@megorei.com", "re@megorei.com"]
  s.files = [".gitignore", ".rspec", ".travis.yml", "Gemfile", "README.md", "Rakefile", "abebookr.gemspec", "bin/console", "bin/setup", "comments.txt", "lib/abebookr.rb", "lib/abebookr/inventory_update/abebook.rb", "lib/abebookr/inventory_update/request.rb", "lib/abebookr/inventory_update/response.rb", "lib/abebookr/order_update/book.rb", "lib/abebookr/order_update/buyer.rb", "lib/abebookr/order_update/constants.rb", "lib/abebookr/order_update/get_all_new_orders_request.rb", "lib/abebookr/order_update/get_order_request.rb", "lib/abebookr/order_update/order_totals.rb", "lib/abebookr/order_update/purchase_order.rb", "lib/abebookr/order_update/purchase_order_item.rb", "lib/abebookr/order_update/request.rb", "lib/abebookr/order_update/response.rb", "lib/abebookr/order_update/shipping.rb", "lib/abebookr/order_update/update_request.rb", "lib/abebookr/order_update/update_shipping_request.rb", "lib/abebookr/request.rb", "lib/abebookr/request_error.rb", "lib/abebookr/utils.rb", "lib/abebookr/value_object.rb", "lib/abebookr/version.rb"]
  s.homepage = "https://github.com/megorei/abebookr"
  s.rubygems_version = "2.2.2"
  s.summary = "A simple wrapper for the Abebooks API."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 3.1"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.10"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<builder>, [">= 3.1"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.10"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<builder>, [">= 3.1"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.10"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
