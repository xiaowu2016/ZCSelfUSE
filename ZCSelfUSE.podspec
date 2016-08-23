
Pod::Spec.new do |s|
  
  s.name         = "ZCSelfUSE"
  s.version      = "0.1.6"
  s.summary      = "自用小工具"

 
  # s.description  = <<-DESC
  #                 DESC

  s.homepage     = "https://github.com/xiaowu2016/ZCSelfUSE"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  #s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "zhangchao" => "942777491@qq.com" }
  # Or just: s.author    = "zhangchao"
  # s.authors            = { "zhangchao" => "942777491@qq.com" }
  # s.social_media_url   = "http://twitter.com/zhangchao"

  # s.platform     = :ios
   s.platform     = :ios, "7.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => "https://github.com/xiaowu2016/ZCSelfUSE.git", :tag => "0.1.6" }

  s.source_files  = "Classes", "ZCSelfUSE/Tools/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "ZCSelfUSE/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  #s.framework  = "Security"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

   s.requires_arc = true

  #s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }
  # s.dependency "JSONKit", "~> 1.4"
   s.dependency 'Masonry', '~> 1.0.0' 
end
