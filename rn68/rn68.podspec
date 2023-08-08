#
# Be sure to run `pod lib lint rn68.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

require 'json'

# Returns the version number for a package.json file
pkg_version = lambda do |dir_from_root = '', version = 'version'|
  path = File.join(__dir__, dir_from_root, 'package.json')
  JSON.parse(File.read(path))[version]
end

# Let the main package.json decide the version number for the pod
rn68_version = pkg_version.call
# Use the same RN version that the JS tools use
react_native_version = pkg_version.call('node_modules/react-native')

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name             = 'rn68'
  s.version          = rn68_version
  s.summary          = 'A short description of rn68.'
  s.description      = 'A short description of rn68.'
  s.homepage         = 'https://github.com/teguhwibowophincon/rn68'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'teguhwibowophincon' => 'teguh.wibowo@phincon.com' }
  s.source           = { :git => 'https://github.com/teguhwibowophincon/rn68.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.source_files   = 'Pod/Classes/**/*.{h,m,mm,swift}'
  s.resources      = 'Pod/Assets/{rn68.js,assets}'
  s.platform       = :ios, '11.0'

  # React is split into a set of subspecs, these are the essentials
  # s.dependency 'React/Core', react_native_version
  # s.dependency 'React/CxxBridge', react_native_version
  # s.dependency 'React/RCTAnimation', react_native_version
  # s.dependency 'React/RCTImage', react_native_version
  # s.dependency 'React-RCTLinking', react_native_version
  # s.dependency 'React/RCTNetwork', react_native_version
  # s.dependency 'React/RCTText', react_native_version
  s.dependency "React-Core"

  # Don't install the dependencies when we run `pod install` in the old architecture.
  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
    }
    
    s.dependency "React-Codegen"
    s.dependency "RCT-Folly"
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
  end
  

  # React's dependencies
  # s.dependency 'Yoga', "1.14.0"
  # podspecs = [
  #   'node_modules/react-native/third-party-podspecs/DoubleConversion.podspec',
  #   'node_modules/react-native/third-party-podspecs/RCT-Folly.podspec',
  #   'node_modules/react-native/third-party-podspecs/glog.podspec'
  # ]
  # podspecs.each do |podspec_path|
  #   spec = Pod::Specification.from_file podspec_path
  #   s.dependency spec.name, "#{spec.version}"
  # end
end
