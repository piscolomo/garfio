require "./lib/ate"

Gem::Specification.new do |s|
  s.name              = "garfio"
  s.version           = Garfio::VERSION
  s.summary           = "Garfio helps you to build hooks in your ruby objects"
  s.description       = "With few lines of code, one method compilation and no method missing Garfio with an easy way lets you to launch callbacks before and after of the methods of your objects."
  s.authors           = ["Julio Lopez"]
  s.email             = ["ljuliom@gmail.com"]
  s.homepage          = "http://github.com/TheBlasfem/garfio"
  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/**/*.rb",
    "*.gemspec",
    "test/**/*.rb"
  ]
  s.license           = "MIT"
  s.add_development_dependency "cutest", "1.1.3"
end