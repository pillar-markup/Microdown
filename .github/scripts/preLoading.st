"This is temporal until we fix the Pharo10 build"
IceRepository registry 
	detect: [ :each | each name = 'Microdown' ]
	ifFound: [ :aRepository | aRepository forget ].
"This, however, needs to stay :)"
#( 'BaselineOfMicrodownDev' 'BaselineOfMicrodown' 'Microdown' 'Microdown-Tests' 'Microdown-MicrodownRichTextComposer' 'Microdown-ResolvePath' 
'Microdown-ResolvePath-Tests' 'NewTools-DocumentationReader-Tests'
'NewTools-DocumentationReader') do: [ :each | 
	(RPackageOrganizer default packageNamed: each ifAbsent: [ nil ]) 
		ifNotNil: [ :aPackage | aPackage removeFromSystem ] ]
