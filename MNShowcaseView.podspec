
Pod::Spec.new do |s|

  s.name         = "MNShowcaseView"
  s.version      = "0.0.1"
  s.summary      = " MNShowcaseView can highlight particular view of your app and describe about it as a guided tutorial."
  s.description  = <<-DESC
MNShowcaseView can highlight particular view of your app and describe about it as a guided tutorial.  It can be used as guided tutorial in your app where you can tell new user's how they can use   different items in your app.
                   DESC

  s.homepage     = "https://github.com/nabeelarif100/MNShowcaseView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Muhammad Nabeel Arif" => "nabeel.arif100@gmail.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/nabeelarif100/MNShowcaseView.git", :tag => "#{s.version}" }
  s.source_files  = "MNShowcaseView/API/"

end
