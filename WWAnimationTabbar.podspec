pod::Spec.new do |s|
  s.name         = "WWAnimationTabbar"
  s.version      = "1.1"
  s.summary      = "Animation in tabbar."
  s.homepage     = "http://http://williamzhangwh.github.io/2016/01/25/%E8%B0%B7%E6%AD%8C%E7%BF%BB%E8%AF%91TabBar%E7%82%B9%E5%87%BB%E6%95%88%E6%9E%9C%E5%8A%A8%E7%94%BB%E5%A4%8D%E5%88%BB/"
  s.license      = "MIT"
  s.authors      = { 'williamzhang' => '644208767@qq.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/WilliamZhangWH/WWAnimationTabbar.git", :tag => s.version }
  s.source_files = 'WWAnimationTabbar', 'WWAnimationTabbar/**/*.{h,m}'
  s.requires_arc = true
end
