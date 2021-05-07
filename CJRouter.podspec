Pod::Spec.new do |s|
  s.name             = 'CJRouter'
  s.version          = '1.0.0'
  s.summary          = '业务组件路由：支持分类方法调用以及AppScheme路由两种调用方式'
  s.homepage         = 'http://code.paic.com.cn/ios_common_component/smartrouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lele8446' => 'lele8446@foxmail.com' }
  s.source           = { :git => 'http://code.paic.com.cn/ios_common_component/smartrouter.git', :tag => s.version.to_s }
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.source_files = 'CJRouter/**/*' 
  s.public_header_files = 'CJRouter/**/*.h'
end
