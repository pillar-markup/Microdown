Extension { #name : #RPackage }

{ #category : #'*Microdown' }
RPackage >> asMicrodown: aBuilder [

	^ String streamContents: [:s | 
			s 
				nextPutAll: aBuilder headerMarkup; 
				nextPutAll: 'Package: ', self name;
				cr.
			]  
]
