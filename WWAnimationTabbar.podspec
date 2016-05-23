Pod::Spec.new do |s|
  s.name         = "WWAnimationTabbar"
  s.version      = "1.1"
  s.summary      = "Animation in tabbar."
  s.homepage     = "https://github.com/WilliamZhangWH/WWAnimationTabbar"
  s.license      = "MIT"
  s.authors      = { 'williamzhangwh' => '644208767@qq.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/WilliamZhangWH/WWAnimationTabbar.git", :tag => s.version }
  s.source_files = 'WWAnimationTabbar', 'WWAnimationTabbar/WWAnimationTabbar/WWTabbar/*.{h,m}'
  s.requires_arc = true
end
