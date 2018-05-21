#
# Be sure to run `pod lib lint LXCShow.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXCShow'
  s.version          = '1.0.2'
  s.summary          = 'LXCShow'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'LXCShow描述文件'

  s.homepage         = 'https://github.com/butterflyXX/LXCShow'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'butterflyXX' => '1459709117@qq.com' }
  s.source           = { :git => 'git@github.com:butterflyXX/LXCShow.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LXCShow/Classes/**/*'
  
  s.resource_bundles = {
      'LXCShow' => ['LXCShow/Assets/LXCShow.bundle/*.png']
  }

  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'SDWebImage', '~> 4.3.3'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
