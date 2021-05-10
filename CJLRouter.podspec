Pod::Spec.new do |s|
  s.name             = 'CJLRouter'
  s.version          = '1.0.0'
  s.summary          = '路由组件：支持分类方法调用以及AppScheme路由两种调用方式'
  s.homepage         = 'https://github.com/lele8446/CJLRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lele8446' => 'lele8446@foxmail.com' }
  s.source           = { :git => 'https://github.com/lele8446/CJLRouter.git', :tag => s.version.to_s }
  s.platform         = :ios
  s.ios.deployment_target = '9.0'
  s.requires_arc     = true

  s.source_files     = 'CJLRouter/**/*' 
  s.public_header_files   = 'CJLRouter/**/*.h'
end
