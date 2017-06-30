#
# Be sure to run `pod lib lint MyComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MyComponents'
  s.version          = '0.1.1'
  s.summary          = '这是私人的组件库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a private component library.
                       DESC

  s.homepage         = 'https://github.com/CharlsPrince/MyComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CharlsPrince' => '961629701@qq.com' }
  s.source           = { :git => 'https://github.com/CharlsPrince/MyComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MyComponents/Classes/*.*'
  s.public_header_files = 'MyComponents/Classes/*.*'
  s.requires_arc = true #是否支持arc
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'

  s.subspec 'TestObject' do |ss|
    ss.source_files = 'MyComponents/Classes/TestObject/*.{h,m}'
    ss.public_header_files = 'MyComponents/Classes/TestObject/*.h'
    ss.frameworks = 'UIKit', 'Foundation'
  end
  s.subspec 'RewardSuccess' do |ss|
    ss.source_files = 'MyComponents/Classes/RewardSuccess/*.{h,m}'
    ss.public_header_files = 'MyComponents/Classes/RewardSuccess/*.h'
    ss.frameworks = 'UIKit', 'Foundation'
    ss.resource_bundles = {
      'success_star' => ['MyComponents/Assets/success_star@2x.png']
    }
  end
    s.subspec 'EasyKVO' do |ss|
    ss.source_files = 'MyComponents/Classes/EasyKVO/*.{h,m}'
    ss.public_header_files = 'MyComponents/Classes/EasyKVO/*.h'
    ss.frameworks = 'UIKit', 'Foundation'
  end
  
  # s.resource_bundles = {
  #   'MyComponents' => ['MyComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
