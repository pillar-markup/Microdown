Extension { #name : 'MicHTMLVisitor' }

{ #category : '*Microdown-Toc' }
MicHTMLVisitor >> visitToCEntry: aMicTocEntry [

	aMicTocEntry isLeaf
		ifTrue: [
				canvas tag
					name: 'li';
					with: [
						aMicTocEntry header headerElements do: [ :each |
								each accept: self ] ].
				canvas newLine ]
		ifFalse: [
				canvas tag
					name: 'li';
					with: [
							aMicTocEntry header headerElements do: [ :each |
									each accept: self ].
							canvas newLine.
							canvas tag
								name: 'ol';
								with: [
										canvas newLine.
										aMicTocEntry children do: [ :each | each accept: self ] ].
							canvas newLine ].
				canvas newLine ]
]
