#
# Be sure to run `pod lib lint STCameraPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'STCameraPicker'
s.version          = '1.0.0'
s.summary          = 'STCameraPicker is a UIViewController subclass to capture multiple images via the camera.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'STCameraPicker is a UIViewController a la UIImagePickerController which allows to capture mutiple images via camera without interrupting.'
s.homepage         = 'https://github.com/sdtaheri/STCameraPicker'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Saeed Taheri' => 'saeed.taheri@gmail.com' }
s.source           = { :git => 'https://github.com/sdtaheri/STCameraPicker.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/saeed_taheri'

s.ios.deployment_target = '9.0'

# s.source_files = 'STCameraPicker/Classes/Private/*.{m,h}', 'STCameraPicker/Classes/Public/*.h'
s.source_files = 'STCameraPicker/Classes/Private/*.{m,h}'
s.resource_bundle = {'Assets' => ['STCameraPicker/Assets/**/*.{png}']}
# s.public_header_files = ['STCameraPicker/Classes/Public/*.h']
s.frameworks = 'UIKit'
end
