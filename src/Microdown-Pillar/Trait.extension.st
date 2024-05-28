Extension { #name : 'Trait' }

{ #category : '*Microdown-Pillar' }
Trait >> buildMicroDownUsing: aBuilder withComment: aString [
	
	aBuilder 
		header: [	aBuilder text: 'Trait: '.
					aBuilder text: self name] withLevel: 1;
		horizontalLine;
		text: aString
]
