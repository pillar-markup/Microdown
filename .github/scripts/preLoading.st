"IceRepository registry 
	detect: [ :each | #('Microdown' 'NewTools-DocumentationReader') includes: each name ]
	ifFound: [ :aRepository | aRepository forget ].
#( 'BaselineOfMicrodownDev' 'BaselineOfMicrodown' 'Microdown' 'Microdown-Tests' 'Microdown-MicrodownRichTextComposer' 'Microdown-ResolvePath' 
'Microdown-ResolvePath-Tests' 'NewTools-DocumentationReader-Tests' 'BaselineOfNewToolsDocumentationReader' 'Microdown-RichTextComposer' 'Spec2-Microdown'
'NewTools-DocumentationReader' 'BaselineOfBeautifulComments' 'BeautifulComments') do: [ :each | 
	(RPackageOrganizer default packageNamed: each ifAbsent: [ nil ]) 
		ifNotNil: [ :aPackage | aPackage removeFromSystem ] ]"

#( 'Microdown' 'BeautifulComments' 'DocumentBrowser' ) do: [ :name |
		(IceRepository repositoryNamed: name)
			ifNil: [ self inform: 'Project not found: ' , name ]
			ifNotNil: [ :found |
				found
					unload;
					forget ] ]
