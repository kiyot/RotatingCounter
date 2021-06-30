Pod::Spec.new do |spec|
  spec.name         = "RotatingCounter"
  spec.version      = "0.2.0"
  spec.summary      = "A view to display number counting up and down with rotating animation"
  spec.homepage     = "https://github.com/kiyot/RotatingCounter"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Kiyotaka Sasaya" => "kiyotaka.sasaya@gmail.com" }
  spec.swift_version = "5.0"
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/kiyot/RotatingCounter.git", :tag => "#{spec.version}" }
  spec.source_files = "RotatingCounter/**/*.{h,swift}"
  spec.framework    = "UIKit"
end
