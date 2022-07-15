Class {
	#name : #MicHTMLStylerHTMLOptionsHelp,
	#superclass : #MicHTMLStylerHelp,
	#category : #'Microdown-HTMLExporter-Help'
}

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> bookDescription [ 

	^ 'This section Describes HTML configuration options'
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> bookName [

	^ 'HTML Options'
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> headingText [

	^ self heading: 'Why to specify HTML options'
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> htmlOptions [

	^ HelpTopic 
		title: 'HTML Options'
		contents: self htmlOptionsHelp
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> htmlOptionsHelp [

	^ String streamContents: [ : stream |
		stream
			<< self headingText;
			<< self htmlOptionsHelpText ]
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> htmlOptionsHelpText [

	^ 'HTML validation requires the DOCTYPE declaration. If the web page coding does not include a DOCTYPE Declaration (DTD or Document Type Declaration) or it is done incorrectly, you will not be able to use a HTML (HyperText Markup Language) Validator to check the page coding. 
	
# Types of DTD:

- Strict DTD: Used for web pages that exclude attributes and elements that W3C expects to phase out as CSS support grows
- Transitional DTD: Used for web pages that include attributes and elements that W3C expects to phase out as CSS support grows
- Frameset DTD: Used for web pages with frames

# XHTML Versions

- In XHTML 1.1 document type definition (DTD), allows the addition of modules.
- In XHTML 1.0 Frameset: In XHTML 1.0 Frameset document type definition (DTD), framesets can be used. 
- XHTML 1.0 Transitional: In XHTML 1.0 Transitional document type definition (DTD), deprecated elements are allowed.
- XHTML 1.0 Strict: In XHTML 1.0 Strict document type definition (DTD), deprecated tags are not supported and the code must be written according to the XML Specification.

# HTML Versions

- HTML 4.01 Frameset: In HTML 4.01 Frameset document type definition (DTD),Frames can be used.
- HTML 4.01 Transitional: In HTML 4.01 Transitional document type definition (DTD) allows some older PUBLIC and attributes that have been deprecated.
- HTML 4.01 Strict: In HTML 4.01 Strict document type definition (DTD) all those elements and attributes are included that do not appear in frameset documents or that have not been deprecated.'
]

{ #category : #accessing }
MicHTMLStylerHTMLOptionsHelp class >> pages [

	^ #(htmlOptions)
]
