Class {
	#name : #MicHTMLCanvas,
	#superclass : #MicExportCanvas,
	#classVars : [
		'HTMLCharacters'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #initialization }
MicHTMLCanvas class >> initialize [
	HTMLCharacters := Dictionary new.
	HTMLCharacters
		at: $" put: '&quot;';
		at: $& put: '&amp;';
		at: $< put: '&lt;';
		at: $> put: '&gt;';
		at: $ç put: '&ccedil;' ;
		at: $è put: '&egrave;';
		at: $ù put: '&ugrave;';
		at: $é put: '&eacute;';
		at: $ú put: '&uacute;';
		at: $à put: '&agrave;';
		at: $î put: '&icirc;';
		at: $ê put: '&ecirc;'
		
		
	"Table taken from Citezen
	
		at: #umlaut put: [:charString | '&', charString,'uml;'];
		at: #tilde put: [:charString | '&', charString,'tilde;'];
	
		at: #scedilla put: '&#351;' ;
		at: #tcedilla put: '&#355;' ;
		at: #inversedQuestionMark put: '&iquest;' ;
		at: #oe put: '&#339;' ;
		at: #ae put: '&aelig;' ;
		at: #ss put: '&szlig;' ;
		at: #smallRingedA put: '&aring;' ;
		at: #capitalRingedA put: '&Aring;' ;
		at: #smallSlashedO put: '&oslash;' ;
		at: #capitalSlashedO put: '&Oslash;' ;
		at: #nonBreakingSpace put: '&nbsp;' ;
		at: #iForm put: 'i';
		at: #jForm put: 'j';
		at: #barredL put: 'l';

		at: #circlea put: '&#229;';
		at: #nu put: '&#957;';
		at: #omega put: '&#969;';
		at: #pi put: '&#960;';
		at: #tau put: '&#964;';
		at: #neq put: '&#8800;';
		at: #wedge put: '&#1783;';

		at: #capitalBarredL put: 'L';
		at: #doubleSlash put: '\';
		at: #ampersand put: '&';
		at: #percent put: '%';
		at: #hash put: '#';
		at: #endash put: '&#8211;';
		at: #emdash put: '&#8212;'.
		
	" 
]

{ #category : #accessing }
MicHTMLCanvas >> nextPut: aCharacter [

	(HTMLCharacters at: aCharacter ifAbsent: nil)
		ifNil: [ super nextPut: aCharacter ]
		ifNotNil: [ :string | self raw: string ]
]

{ #category : #accessing }
MicHTMLCanvas >> tag [
	^ self brush: MicHTMLTag new
]
