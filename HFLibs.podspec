Pod::Spec.new do |s|

  s.name                  = "HFKit"
  s.version               = "0.0.5"
  s.summary               = "基于UIKit 希望能简化UIKit 的设置 快速开发"

  s.description           = <<-DESC
                    基于UIKit 希望能简化UIKit 的设置 快速开发 支持cocoapod
                   DESC

  s.homepage              = "https://github.com/helfyz/HFKit"
  s.license               = 'MIT'
  s.author                = { "helfy" => "562812743@qq.com" }
  s.ios.deployment_target = '7.0'
  s.source                = { :git => "https://github.com/helfyz/HFKit.git", :tag => s.version, :submodules => true}
  s.source_files          = "HFKit/HFKit.h"
  s.public_header_files   = "HFKit/HFKit.h"
  s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
  s.requires_arc          = true

s.subspec 'UIViewAdditions' do |ss|
ss.source_files        = "HFKit/UIViewAdditions/**/*.{h,m}"
ss.public_header_files = "HFKit/UIViewAdditions/**/*.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
end

s.subspec 'HFViews' do |ss|
ss.source_files        = "HFKit/HFViews/**/*.{h,m}"
ss.public_header_files = "HFKit/HFViews/**/*.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
ss.dependency 'HFKit/UIViewAdditions'
 s.dependency "Masonry", '~> 0.6.1'
end

s.subspec 'HFTableViewController' do |ss|
ss.source_files        = "HFKit/HFTableViewController/**/*.{h,m}"
ss.public_header_files = "HFKit/HFTableViewController/**/*.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
#ss.dependency 'HFKit/UIViewAdditions'
ss.dependency 'HFKit/HFViews'

end

end
