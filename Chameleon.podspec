Pod::Spec.new do |s|
  s.name         = "Chameleon"
  s.version      = "0.1.0"
  s.summary      = "This is an easy framework for change your APP theme."
  s.description  = <<-DESC
  Chameleon is a skin-changing (theme) framework for iOS/macOS that supports dynamic skin changing and custom attributes, and also supports non-invasive skin changing (swizzling).
                   DESC
  s.homepage     = "https://github.com/JyHu/Chameleon.git"
  s.license      = "MIT"
  s.authors      = {
    "JyHu" => "auu.aug@gmail.com",
  }
  
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'

  s.source       = { :git => "https://github.com/JyHu/Chameleon.git", :tag => s.version }
  s.requires_arc = true

  s.source_files = 'Sources/Chameleon/**/*.swift'
end
