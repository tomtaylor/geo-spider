Gem::Specification.new do |s|
  s.name = %q{geo-spider}
  s.version = "0.2.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Taylor"]
  s.date = %q{2008-09-30}
  s.description = %q{Tool for spidering websites, extracting pages with geodata.}
  s.email = ["tom@tomtaylor.co.uk"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "lib/geo-spider.rb", "lib/geo-spider/extractors/base.rb", "lib/geo-spider/extractors/master.rb", "lib/geo-spider/extractors/microformat.rb", "lib/geo-spider/extractors/postcode.rb", "lib/geo-spider/location.rb", "lib/geo-spider/page.rb", "lib/geo-spider/site.rb", "lib/geo-spider/version.rb", "script/console", "script/destroy", "script/generate", "setup.rb", "spec/assets/pages/multiple_postcodes_and_microformats.html", "spec/assets/pages/page_with_links.html", "spec/assets/pages/separate_microformat_and_postcode.html", "spec/assets/pages/single_microformat.html", "spec/assets/pages/single_postcode.html", "spec/geo-spider/page_spec.rb", "spec/geo-spider/site_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake", "tasks/website.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://geospider.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{geospider}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Tool for spidering websites, extracting pages with geodata.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
