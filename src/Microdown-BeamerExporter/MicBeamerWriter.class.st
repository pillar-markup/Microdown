Class {
	#name : #MicBeamerWriter,
	#superclass : #MicLaTeXWriter,
	#category : #'Microdown-BeamerExporter'
}

{ #category : #'as yet unclassified' }
MicBeamerWriter >> createFrametitle: aTitle [
	canvas command
		name: 'frametitle';
		parameter: aTitle
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> createLinkToLabelWithAlias: anInternalLink [
	canvas command
		name: 'hyperlink';
		parameter: [ canvas raw: anInternalLink anchor ];
		parameter: [ canvas raw: anInternalLink alias ]
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> sectionOptionFrom: level To: depth On: parameters [
	parameters
		add:
			((1 > level and: [ 1 <= depth ])
				ifTrue: [ 'sectionstyle=show/show' ]
				ifFalse: [ 'sectionstyle=hide/hide' ]).
	parameters
		add:
			((2 > level and: [ 2 <= depth ])
				ifTrue: [ 'subsectionstyle=show/show/show' ]
				ifFalse: [ 'subsectionstyle=hide/hide/hide' ]).
	parameters
		add:
			((3 > level and: [ 3 <= depth ])
				ifTrue: [ 'subsubsectionstyle=show/show/show' ]
				ifFalse: [ 'subsubsectionstyle=hide/hide/hide' ])
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> visitCode: aCodeBlock [
	| env |
	env := (aCodeBlock hasCaption and: [ aCodeBlock hasLabel ])
		ifTrue: [
			canvas environment 
				name: 'listing';
				optParameter: 'label=', aCodeBlock label;
				optParameter: 'caption={' , (self getStringForAll: aCodeBlock captionElements), '}';
				yourself ]
		ifFalse: [
			env := aCodeBlock hasCaption 
				ifTrue: [ 
					canvas environment 
						name: 'listing';
						optParameter: 'caption={' , (self getStringForAll: aCodeBlock captionElements), '}';
						yourself ]
				ifFalse: [ 
					env := aCodeBlock hasLabel 
						ifTrue: [
							canvas environment 
								name: 'listing';
								optParameter: 'label=', aCodeBlock label;
								yourself ]
						ifFalse: [
							canvas environment 
								name: 'listing';
								yourself ]]].
	env with: [ canvas nextPutAllLines: aCodeBlock body. canvas newLine ]
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> visitColumn: aColumn [
	canvas environment
		name: 'column';
		parameter: [ 
					canvas
						nextPutAll: (aColumn width asNumber / 100.0) printString;
						raw: '\textwidth' ];
		with: [ self visitAll: aColumn children ].
	canvas newLine
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> visitColumns: aColumns [
	canvas environment
		name: 'columns';
		with: [ 
					self visitAll: aColumns children].
	canvas newLine
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> visitFigure: aFigure [
	canvas environment
		name: 'center';
		with: [ self includeGraphicsFor: aFigure ]
]

{ #category : #'as yet unclassified' }
MicBeamerWriter >> visitSlide: aSlide [
	canvas newLine.
	canvas environment
		name: 'frame';
		optParameter: 'fragile';
		with: [ 
					canvas newLine.
					self createFrametitle: aSlide title.
					canvas newLine.
					super visitSlide: aSlide ].
	canvas newLine
]
