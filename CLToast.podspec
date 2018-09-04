Pod::Spec.new do |s|
  s.name = 'CLToast'
  s.version = '1.0.3'
  s.swift_version = '4.0'
  s.license = 'MIT'
  s.summary = 'This is a Toast'
  s.homepage = 'https://github.com/Darren-chenchen/CLToast'
  s.authors = { 'Darren-chenchen' => '1597887620@qq.com' }
  s.source = { :git => 'https://github.com/Darren-chenchen/CLToast.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CLToast/CLToast/**/*.swift'
  s.resource_bundles = { 
	'CLToast' => ['CLToast/CLToast/Images/**/*.png','CLToast/CLToast/**/*.{xib,storyboard}','CLToast/CLToast/**/*.{lproj,strings}']
  }

end
