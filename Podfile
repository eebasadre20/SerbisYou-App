# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'SerbisYou-App' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SerbisYou-App
#  pod 'Firebase/Core'
#  pod 'Firebase/Auth'
#  pod 'FBSDKCoreKit'
#  pod 'FBSDKLoginKit'
#  pod 'FBSDKShareKit'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'GoogleSignIn'
  pod 'Alamofire', '4.0.0'
  pod 'SwiftyJSON', '3.1.0'
  
  target 'SerbisYou-AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SerbisYou-AppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
