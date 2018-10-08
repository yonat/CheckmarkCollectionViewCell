
Pod::Spec.new do |s|

  s.name         = "CheckmarkCollectionViewCell"
  s.version      = "1.0.0"
  s.summary      = "Cell with checkbox when it isSelected, empty circle when not."

  s.homepage     = "https://github.com/yonat/CheckmarkCollectionViewCell"
  s.screenshots  = "https://raw.githubusercontent.com/yonat/CheckmarkCollectionViewCell/master/Screenshots/CheckmarkCollectionViewCell.png"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author             = { "Yonat Sharon" => "yonat@ootips.org" }
  s.social_media_url   = "http://twitter.com/yonatsharon"

  s.swift_version = '4.2'
  s.platform     = :ios, "9.3"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/yonat/CheckmarkCollectionViewCell.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"
  s.subspec 'Resources' do |resources|
      resources.resource_bundle = {s.name => 'Sources/*.png'}
  end

  s.dependency 'MiniLayout'

end
