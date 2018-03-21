Pod::Spec.new do |s|
  s.name         = "EasyTheme"
  s.version      = "0.1.8"
  s.summary      = "This is an easy framework for change your APP theme."
  s.description  = <<-DESC
  This is an easy framework for change your APP theme. You can follow my code and write your own colorful APP theme.
                   DESC
  s.homepage     = "https://github.com/JyHu/EasyTheme.git"
  # s.license      = "Apache License, Version 2.0"
  s.authors            = {
    "JyHu" => "auu.aug@gmail.com",
  }
  s.social_media_url   = "http://www.auu.space"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/JyHu/EasyTheme.git", :tag => s.version }
  s.requires_arc = true

  s.source_files = 'ThemeKit/**/*.{h,m}'
  s.dependency 'SDWebImage'

end
