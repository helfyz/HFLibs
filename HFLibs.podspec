Pod::Spec.new do |s|

  s.name                  = "HFLibs"
  s.version               = "0.7.3"
  s.summary               = "基于UIKit 希望能简化UIKit 的设置 快速开发"

  s.description           = <<-DESC
                    基于UIKit 希望能简化UIKit 的设置 快速开发 支持cocoapod
                   DESC

  s.homepage              = "https://github.com/helfyz/HFLibs"
  s.license               = 'MIT'
  s.author                = { "helfy" => "562812743@qq.com" }
  s.ios.deployment_target = '7.0'
  s.source                = { :git => "https://github.com/helfyz/HFLibs.git", :tag => s.version, :submodules => true}
  s.source_files          = "HFLibs/HFLibs.h"
  s.public_header_files   = "HFLibs/HFLibs.h"
  s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
  s.requires_arc          = true

s.subspec 'UIViewAdditions' do |ss|
ss.source_files        = "HFLibs/UIViewAdditions/*.{h,m}"
ss.public_header_files = "HFLibs/UIViewAdditions/*.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
end

s.subspec 'HFViews' do |ss|
ss.source_files        = "HFLibs/HFViews/**/*.{h,m}"
ss.public_header_files = "HFLibs/HFViews/**/*.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
ss.dependency 'HFLibs/UIViewAdditions'

s.dependency "Masonry", '~> 0.6.1'
s.dependency "UITableView+FDTemplateLayoutCell", '~> 1.3'

end


s.subspec 'UIViewController+HF' do |ss|
ss.source_files        = "HFLibs/UIViewController+HF/*.{h,m}"
ss.public_header_files = "HFLibs/UIViewController+HF/*.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
ss.dependency 'HFLibs/HFViews'
end


end
