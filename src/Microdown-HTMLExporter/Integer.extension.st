Extension { #name : #Integer }

{ #category : #'*Microdown-HTMLExporter' }
Integer >> asFileSizeString [
	" From Magritte-Model.MetaGUI-SeanDeNigris.459.mcz "

	#( 'B' 'KB' 'MB' 'GB' 'TB' 'PB' 'EB' 'ZB' 'YB' )
		inject: self
		into: [ :value :each |
			value < 1024
				ifFalse: [ value // 1024 ]
				ifTrue: [ 
					^ String streamContents: [ : stream |
							stream 
								nextPutAll: value asString;
								space;
								nextPutAll: each ] ] ]
]
