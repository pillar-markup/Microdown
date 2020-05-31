Extension { #name : #Class }

{ #category : #'*Microdown' }
Class >> asMicrodown: aBuilder [ 
	^ String streamContents: [:s | 
			s 
				nextPutAll: aBuilder headerMarkup; 
				nextPutAll: self name;
				cr.
			]  
]

{ #category : #'*Microdown' }
Class >> buildMicroDownUsing: aBuilder withComment: aString [
	
	aBuilder 
		buildHeader: 'Class: ', self name;
		buildText: aString
]
