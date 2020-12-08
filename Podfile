# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end


target 'Food Truck Hunter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Food Truck Hunter
  pod 'Firebase/Analytics'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  # Optionally, include the Swift extensions if you're using Swift.
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'GoogleSignIn'
  pod 'NanoID', '~> 1.0'

  target 'Food Truck HunterTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Food Truck HunterUITests' do
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
    pod 'Firebase/Auth'
    pod 'GoogleSignIn'
    pod 'NanoID', '~> 1.0'
    # Pods for testing
  end

end
