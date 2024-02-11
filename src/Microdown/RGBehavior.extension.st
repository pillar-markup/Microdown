Extension { #name : 'RGBehavior' }

{ #category : '*Microdown' }
RGBehavior >> buildMicroDownUsing: aMicMicrodownTextualBuilder withComment: aString [

	aMicMicrodownTextualBuilder
		header: [ aMicMicrodownTextualBuilder text: 'Class: '.
					aMicMicrodownTextualBuilder text: self name ] withLevel: 1;
		horizontalLine;
		text: aString
]
