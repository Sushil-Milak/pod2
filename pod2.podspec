#
# Be sure to run `pod lib lint pod2.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'pod2'
  s.version          = '0.1.0'
  s.summary          = 'A short description of pod2.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sushil-Milak/pod2'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sushil-Milak' => 'sushil.milak@va.gov' }
  s.source           = { :git => 'https://github.com/Sushil Milak/pod2.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '16.0'
  s.swift_versions = ['5.0', '5.1', '5.x'] # You can be explicit or use wildcards
  s.platforms = {
          "ios": "16.0"
      }

  #s.source_files = 'pod2/Classes/**/*'
  s.source_files = 'Source/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'pod2' => ['pod2/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # adding 05/21/2025
  s.dependency 'AzureCommunicationUICalling', '1.12.0-beta.1'
  
  #pod for chat
  s.dependency 'AzureCommunicationUIChat', '1.0.0-beta.4'
  
  #pods for firebase messaging
  
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Messaging'
  
  #Add the pod for Firebase Crashlytics
  s.dependency 'Firebase/Crashlytics'
  
  # add the Firebase pod for Google Analytics
  s.dependency 'Firebase/Analytics'
  #s.dependency 'FirebaseAnalytics'
  #s.dependency 'FirebaseAuth'
  #s.dependency 'FirebaseFirestore'
  s.static_framework = true
  s.pod_target_xcconfig = {
  "OTHER_LDFLAGS" => '$(inherited) -framework "Firebase" -framework "FirebaseCore" -framework "FirebaseMessaging"  -framework "FirebaseCrashlytics"  -framework "FirebaseAnalytics"',
  "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => 'YES',
  "FRAMEWORK_SEARCH_PATHS" => '$(inherited) "${PODS_ROOT}/FirebaseCore/Frameworks" "${PODS_ROOT}/FirebaseMessaging/Frameworks"'
  }
end
