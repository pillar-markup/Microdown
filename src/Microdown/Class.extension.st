Extension { #name : #Class }

{ #category : #'*Microdown' }
Class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	aBuilder 
		buildHeader: 'Class: ', self name;
		buildText: aString
]
