Class {
	#name : 'MicAddParagraphLabelPeriod',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'actions' }
MicAddParagraphLabelPeriod >> correctedLabelLine: line label: firstWord [

    ^ line copyReplaceAll: firstWord with: firstWord , '.'

]

{ #category : 'actions' }
MicAddParagraphLabelPeriod >> correctedLine: line [

	| trimmed firstWord |
	trimmed := line trimLeft.
	trimmed isEmpty ifTrue: [ ^ line ].

	firstWord := trimmed substrings first.

	(MicParagraphMissingLabelPeriodRule new
		 detectIncorrectLabel: trimmed) ifTrue: [
		^ self correctedLabelLine: line label: firstWord ].

	^ line
]

{ #category : 'private' }
MicAddParagraphLabelPeriod >> sanitize: aText [
    | lines stream lastIndex |
    lines := aText lines.
    lastIndex := lines size.

    stream := String streamContents: [:s |
        1 to: lastIndex do: [:i |
            | line |
            line := self correctedLine: (lines at: i).
            s nextPutAll: line.
            (i < lastIndex) ifTrue: [ s cr ]
        ]].
    ^ stream

]
