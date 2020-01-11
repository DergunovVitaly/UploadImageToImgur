platform :ios, '12.0'

use_frameworks!

inhibit_all_warnings!

target 'UploadImageToImgur' do

  pod 'SnapKit'
  pod 'R.swift'
  pod 'MBProgressHUD'
  pod 'Closures'
  pod 'Moya/RxSwift'
  pod 'SwiftLint'
  pod 'Eureka'

  target 'UploadImageToImgurTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
