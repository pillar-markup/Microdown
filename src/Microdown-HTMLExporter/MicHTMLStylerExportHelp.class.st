Class {
	#name : #MicHTMLStylerExportHelp,
	#superclass : #MicHTMLStylerHelp,
	#category : #'Microdown-HTMLExporter-Help'
}

{ #category : #accessing }
MicHTMLStylerExportHelp class >> bookDescription [ 

	^ 'Describes export options'
]

{ #category : #accessing }
MicHTMLStylerExportHelp class >> bookName [

	^ 'Exporting'
]

{ #category : #accessing }
MicHTMLStylerExportHelp class >> exportOptions [

	^ HelpTopic 
		title: 'Export Options'
		contents: self exportOptionsHelp
]

{ #category : #accessing }
MicHTMLStylerExportHelp class >> exportOptionsHelp [

	^ String streamContents: [ : stream |
		stream
			<< self headingText;
			<< self exportOptionsHelpText ]
]

{ #category : #accessing }
MicHTMLStylerExportHelp class >> exportOptionsHelpText [

	^ 'Output file name: The exported HTML file name. If not specified, then index.html will be used.

Output folder: Exported files will be written in the specified directory. If does not exists, it will be created.

Overwrite option. When checked, it will overwrite previously exported HTML files and its parent directory (the output folder) without confirmation.'
]

{ #category : #accessing }
MicHTMLStylerExportHelp class >> headingText [

	^ self heading: 'How to export a document'
]

{ #category : #accessing }
MicHTMLStylerExportHelp class >> pages [

	^ #(exportOptions)
]
