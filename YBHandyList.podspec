

Pod::Spec.new do |s|


  s.name         = "YBHandyListKit"
  s.version      = "1.0.0"
  s.summary      = "让 UITableView / UICollectionView 更加简单优雅，轻易实现列表动态化、模块化、MVVM 架构"
  s.description  = <<-DESC
  					让 UITableView / UICollectionView 更加简单优雅，轻易实现列表动态化、模块化、MVVM 架构。
                   DESC

  s.homepage     = "https://github.com/wangyingbo"

  s.license      = "MIT"

  s.author       = { "wangyingbo" => "wangyingbo528@126.com" }
 
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/wangyingbo/YBHandyListKit.git", :tag => "#{s.version}" }

  s.source_files  = "YBHandyListKit/**/*.{h,m}"

  s.requires_arc = true

end
