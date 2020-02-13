Pod::Spec.new do |s|
  s.name         = "MKAToggleButton"
  s.version      = "1.3.0"
  s.summary      = "MKAToggleButton is the button has multiple states for iOS."
  s.description  = <<-DESC
MKAToggleButton is the button has multiple states for iOS.
                   DESC
  s.homepage     = "https://github.com/HituziANDO/MKAToggleButton"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Hituzi Ando"
  s.platform     = :ios, "9.3"
  s.source       = { :git => "https://github.com/HituziANDO/MKAToggleButton.git", :tag => "#{s.version}" }
  s.source_files = "MKAToggleButton/**/*.{h,m}"
  s.requires_arc = true
end
