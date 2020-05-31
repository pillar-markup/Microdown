Extension { #name : #RPackage }

{ #category : #'*Microdown' }
RPackage >> buildMicroDownUsing: aBuilder withComment: aString [
	
	aBuilder 
		buildHeader: 'Package: ', self name;
		buildText: aString.
	(self name beginsWith: 'BaselineOf')
		ifTrue: [  ]
]
