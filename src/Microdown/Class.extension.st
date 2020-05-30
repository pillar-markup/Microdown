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
