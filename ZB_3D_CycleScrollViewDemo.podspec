Pod::Spec.new do |s|
    s.name         = 'ZB_3D_CycleScrollViewDemo'
    s.version      = '0.0.2'
    s.summary      = '实现3D轮播效果，可加载本地图片和网络图片，可塑性高，使用简单方便。'
    s.homepage     = 'https://github.com/AnswerXu/ZB-3D-CycleScrollViewDemo.git'
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "AnswerXu" => "zhengbo073017@163.com" }
    s.source       = { :git => 'https://github.com/AnswerXu/ZB-3D-CycleScrollViewDemo.git', :tag => s.version.to_s }
    s.platform     = :ios, '8.0'
    s.source_files = 'ZB(3D)CycleScrollViewDemo/ZB(3D)CycleScrollView/*.{h,m}',
    s.framework    = 'UIKit','CAAnimation'
    s.requires_arc = true
    s.dependency 'SDWebImage'

end
