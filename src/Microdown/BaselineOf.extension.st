Extension { #name : #BaselineOf }

{ #category : #'*Microdown' }
BaselineOf class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	aBuilder 
		buildHeader: self name;
		buildText: 'A baseline is a kind of map to load project.';
		buildHeader: 'Description' level: 3;
		buildText: aString; 
		buildHeader: 'Dependencies' level: 3;
		buildCodeblockTag: 'pharo' withBody:  (self sourceCodeAt: #baseline:)
]
