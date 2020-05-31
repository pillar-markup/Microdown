Extension { #name : #RPackage }

{ #category : #'*Microdown' }
RPackage >> buildMicroDownUsing: aBuilder withComment: aString [
	
	self class environment at: self name 
		ifPresent: [ :b | aBuilder 
			buildHeader: self name;
			buildText: 'A baseline is a kind of map to load project.';
			buildHeader: 'Description' level: 3;
			buildText: aString; 
			buildHeader: 'Dependencies' level: 3;
			buildCodeblockTag: 'pharo' withBody:  (b sourceCodeAt: #baseline: 
									ifAbsent: [ 'No baseline! Houston we have a problem' ]) ] 
		ifAbsent: [ aBuilder 
						buildHeader: 'Package: ', self name;
						buildText: aString ]
	
]
