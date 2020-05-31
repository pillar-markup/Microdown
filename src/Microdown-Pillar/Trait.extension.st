Extension { #name : #Trait }

{ #category : #'*Microdown-Pillar' }
Trait >> buildMicroDownUsing: aBuilder withComment: aString [
	
	aBuilder 
		buildHeader: 'Trait: ', self name;
		buildText: aString
]
