IceRepository registry 
	detect: [ :each | #('Microdown' 'NewTools-DocumentationReader') includes: each name ]
	ifFound: [ :aRepository | aRepository forget ].
"This, however, needs to stay :)"
#( 'BaselineOfMicrodownDev' 'BaselineOfMicrodown' 'Microdown' 'Microdown-Tests' 'Microdown-MicrodownRichTextComposer' 'Microdown-ResolvePath' 
'Microdown-ResolvePath-Tests' 'NewTools-DocumentationReader-Tests' 'BaselineOfNewToolsDocumentationReader'
'NewTools-DocumentationReader') do: [ :each | 
	(RPackageOrganizer default packageNamed: each ifAbsent: [ nil ]) 
		ifNotNil: [ :aPackage | aPackage removeFromSystem ] ]
