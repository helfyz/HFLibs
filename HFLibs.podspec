Pod::Spec.new do |s|

  s.name                  = "HFLibs"
  s.version               = "1.0.0"
  s.summary               = "主要收录了一些 在自己项目中做的东西，目前包括对UIView 的一些简化设置&扩展"

  s.description           = <<-DESC
                    主要收录了一些 在自己项目中做的东西，目前包括对UIView 的一些简化设置&扩展
                    提高开发 支持cocoapod
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

s.subspec 'HFAdditions' do |ss|
ss.source_files        = "HFLibs/HFAdditions/*.{h,m}"
ss.public_header_files = "HFLibs/HFAdditions/HFAdditions.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
end

s.subspec 'HFViews' do |ss|
ss.source_files        = "HFLibs/HFKit/**/*.{h,m}"
ss.public_header_files = "HFLibs/HFKit/HFKit.h"
s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
ss.dependency 'HFLibs/UIViewAdditions'

s.dependency "Masonry", '~> 0.6.1'
s.dependency "UITableView+FDTemplateLayoutCell", '~> 1.3'

end


end
