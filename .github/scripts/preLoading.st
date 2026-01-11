
#( 'Microdown' 'BeautifulComments' 'DocumentBrowser' ) do: [ :name |
		(IceRepository repositoryNamed: name)
			ifNil: [ ('Project not found: ' , name) traceCr ]
			ifNotNil: [ :found |
				found
					unload;
					forget ] ]
