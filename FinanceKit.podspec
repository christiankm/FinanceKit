
Pod::Spec.new do |spec|

  spec.name         = 'FinanceKit'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'None' }
  spec.homepage     = 'https://github.com/christiankm'
  spec.authors      = { 'Christian Mitteldorf' => 'christian.km@me.com' }
  spec.summary      = 'FinanceKit.'
  spec.description  = <<-DESC
                        FinanceKit is a library for retrieveing financial data..
                   DESC

  #spec.module_name  = 'FinanceKit'
  spec.source       = { :path => './' }
  spec.source_files = 'FinanceKit/**/*.{swift}'

  spec.ios.deployment_target  = '9.0'
  spec.osx.deployment_target  = '10.10'

  spec.requires_arc = true

  #s.dependency 'Realm'

end
