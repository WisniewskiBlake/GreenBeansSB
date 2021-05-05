# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GreenBeansSB' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GreenBeansSB
	pod 'LGButton'
	pod 'JSSAlertView'
	pod 'GooglePlaces', '4.2.0'
#pod 'Firebase/Auth'
#pod 'Firebase/Firestore'
#pod 'Firebase/Storage'
pod 'PromisesSwift'
pod 'SideMenu'
pod 'LGButton'

  target 'GreenBeansSBTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GreenBeansSBUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

