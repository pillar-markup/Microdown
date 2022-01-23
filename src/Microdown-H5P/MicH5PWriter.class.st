"
I'm a slide converter to a limited subset of H5P.


### code 

params"":{
                        ""text"":""<pre>testSetLabel\n\n    | codeBlock |\n    codeBlock := self testedClass new.\n    codeBlock label: 'sec123'.\n    self assert: codeBlock hasLabel. \n    self assert: codeBlock label equals: 'sec123'\n</pre>\n""
                     },

### Bullet
 ""action"":{
                     ""library"":""H5P.AdvancedText 1.1"",
                     ""params"":{
                        ""text"":""<ul>\n\t<li><span style=\""font-size:1.125em\"">Cool</span></li>\n\t<li><span style=\""font-size:1.125em\"">Nice</span></li>\n\t<li><span style=\""font-size:1.125em\"">Super</span></li>\n\t<li><span style=\""font-size:1.125em\"">Hyper language</span></li>\n</ul>\n""
                     },


### Links

""action"":{
                     ""library"":""H5P.Link 1.3"",
                     ""params"":{
                        ""linkWidget"":{
                           ""protocol"":""http://"",
                           ""url"":""www.pharo.org""
                        },
                        ""title"":""What a great link""
                     },
                     ""subContentId"":""4160c8f2-8a7c-4e83-ad3b-a6b5415a7b9e"",
                     ""metadata"":{
                        ""contentType"":""Link"",
                        ""license"":""U""
                     }
"
Class {
	#name : #MicH5PWriter,
	#superclass : #MicDocumentWriter,
	#instVars : [
		'contents'
	],
	#category : #'Microdown-H5P'
}

{ #category : #initialization }
MicH5PWriter >> initialize [ 
	super initialize
]
